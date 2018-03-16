xquery version "3.0" encoding "UTF-8";

declare namespace local="http://kb.dk/this/app";
declare namespace ft="http://exist-db.org/xquery/lucene";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace mts="http://www.loc.gov/METS/";
declare namespace mds="http://www.loc.gov/mods/v3";
declare namespace xlink="http://www.w3.org/1999/xlink";

declare variable  $op := doc("/db/pq/view-alto.xsl");
 
declare option exist:serialize "method=xml media-type=text/html encoding=UTF-8";           


declare function local:browse($doc as node(), $pageid as xs:string,$direction as xs:string) as node()*
{
let $id    := request:get-parameter("id","")
let $query := request:get-parameter("q","")
let $next  := if($direction = "previous") then $doc//mts:div[@ID=$pageid]/preceding::mts:div[1]/@ID/string() else $doc//mts:div[@ID=$pageid]/following::mts:div[1]/@ID/string()

return if($next) then <a href="view-page.xq?id={$id}&amp;q={$query}&amp;page={$next}">{$direction}</a> else ()

};

declare function local:get-uri($doc as node(), $pageid as xs:string, $iftext as xs:string) as xs:string
{
let $pgdiv := $doc//mts:div[@ID=$pageid]

let $file := if(contains($iftext,'text')) then
$pgdiv//mts:fptr//mts:area[contains(@FILEID,"ALTO")]/@FILEID/string()
else
$pgdiv//mts:fptr//mts:area[contains(@FILEID,"IMG")]/@FILEID/string()

let $uri :=  $doc//mts:file[@ID=$file]/mts:FLocat/@xlink:href/string()

return $uri
};

declare function local:make-iiif-uri($tiff as xs:string) as xs:string
{
let $width := "400,"
let $iip  := "http://kb-images.kb.dk/public/pq/"
let $iiif := concat("/full/",$width,"/0/native.jpg")

let $start   := replace($tiff,"(^.*?)(den-kbd-all-)(\d+)(.*$)","$2$3") 
let $section := replace($tiff,"(^.*?)(den-kbd-all-)(\d+)(-\d\d\d)(.*$)","$4") 
let $page    := replace($tiff,"(^.*?)(den-kbd-all-)(\d+)(-\d\d\d)(.*?)(\.tiff?)$","$5") 

(: file://./den-kbd-all-110408004677-001-0002R.tif

den-kbd-all-110304010217/den-kbd-all-110304010217-000/den-kbd-all-110304010217-000-0000B/full/full/0/native.jpg:)

return if(contains($tiff,"..")) then concat($iip,$start,"/",$start,$section,$page,$iiif) else concat($iip,$start,"/",$start,$section,"/",$start,$section,$page,$iiif)
};


let $id    := request:get-parameter("id","")
let $query := request:get-parameter("q","")
let $page  := request:get-parameter("page","")

let $doc :=
for $d in collection("/db/pq")//mts:mets
where contains(util:document-name($d),$id)
return $d

return
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>ID={$id}; PAGE={$page}</title><meta http-equiv="Content-Type" content="text/html;charset:UTF-8"/></head>
<body>
<h1>ID={$id}</h1>
<form action="metadata-search.xq" method="get"><p>[<a href="start.xml">Start</a>]|[<input name="q" value="{$query}"/><input type="submit" value="search"/>]|[<a href="./get-volume.xq?id={$id}&amp;q={$query}">back to volume</a>]</p></form>
<p>{local:browse($doc, $page,"previous")} | {local:browse($doc, $page,"next")}</p>
<div style="width:45%; float: left;">
{
let $ruri := local:get-uri($doc, $page, "text")

let $text := replace(local:get-uri($doc, $page, "text"),"(^.*?)(ocr)(.*$)","$2$3") 
let $alto := doc(resolve-uri($text,base-uri($doc)))
let $hdoc := transform:transform($alto,$op,())

return <div><strong>{$text}</strong>
{$hdoc}
</div>
}
</div>
<div  style="width:45%; float: left;">
{
let $tiff := local:get-uri($doc, $page, "image")
return <p><img src="{local:make-iiif-uri($tiff)}" alt="{$tiff}"/><br/>$tiff</p>
}
</div>

</body>
</html>
