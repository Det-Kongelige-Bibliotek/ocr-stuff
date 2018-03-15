xquery version "3.0" encoding "UTF-8";

declare namespace local="http://kb.dk/this/app";
declare namespace ft="http://exist-db.org/xquery/lucene";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace mts="http://www.loc.gov/METS/";
declare namespace mds="http://www.loc.gov/mods/v3";
declare namespace xlink="http://www.w3.org/1999/xlink";

declare option exist:serialize "method=xml media-type=text/html encoding=UTF-8";           

declare function local:get-page($doc as node(), $pageid as xs:string, $objectid as xs:string ) as node()
{
let $pg := <br/>

return $pg
};

declare function local:get-file-uri($doc as node(), $objectid as xs:string ) as xs:string
{
let $pg := $doc//mts:file[@ID=$objectid]/mts:FLocat/@xlink:href/string()

return $pg
};

declare function local:pages($thewhole as node(),$doc as node(),$did as xs:string) as node()
{

let $i := request:get-parameter("id","")
let $q := request:get-parameter("q","")

let $pages :=
<table>{
for $d in $doc/mts:div|$doc/mts:fptr
  return
  if(local-name($d)="div") then <tr><td valign="top"><strong>view: </strong><a href="./view-page.xq?id={$i}&amp;q={$q}&amp;page={$d/@ID/string()}">{$d/@ID/string()}</a> lable={$d/@LABEL/string()}</td><td valign="top">{local:pages($thewhole,$d,$did)}</td></tr>
  else 
  <ul> {
  for $a in $d//mts:area
    return <li>{local:get-file-uri($thewhole,$a/@FILEID/string())}</li>
  } </ul>		
}</table>

return $pages

};

let $id  := request:get-parameter("id","")
let $query  := request:get-parameter("q","")
let $page := request:get-parameter("page","")

return
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>ID={$id}</title><meta http-equiv="Content-Type" content="text/html;charset:UTF-8"/></head>
<body>
<h1>ID={$id}</h1>
<form action="metadata-search.xq" method="get"><p>[<a href="start.xml">Start</a>]|[<input name="q" value="{$query}"/><input type="submit" value="search"/>]</p></form>
<div>
{
	let $doc :=
	for $d in collection("/db/pq")//mts:mets
	where contains(util:document-name($d),$id)
	return $d

	for $r in $doc//mds:mods[mds:recordInfo]
	  let $author := 
	  for $a in $r//mds:name[@type="personal" and contains(./mds:role/mds:roleTerm,"author")]
	  return $a/mds:namePart/string()
	  let $did := $r//mds:recordInfo/mds:recordIdentifier/string()
	  let $tit := $r//mds:title/string()
	  let $notes := for $n in $r//mds:note return <span>{$n/string()}<br/></span>
          return <div><p><strong>Author:</strong> {string-join($author,'; ')}<br/><strong>Title:</strong> {string-join($tit,'; ')}<br/><strong>Record:</strong> {$did}<br/><strong>Note:</strong>{$notes}</p><div><h2>Contents</h2>{if($page) then local:get-page($doc,$page,$did) else local:pages($doc,$doc//mts:structMap,$did)}</div></div>

}
</div>

</body>
</html>

