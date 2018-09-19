xquery version "3.1" encoding "UTF-8";

declare namespace local="urn:believe-it-or-not-but-this-was-invented-here";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace fn="http://www.w3.org/2005/xpath-functions";
declare namespace file="http://exist-db.org/xquery/file";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace ft="http://exist-db.org/xquery/lucene";
declare namespace alto="http://schema.ccs-gmbh.com/ALTO";

declare variable $file := request:get-parameter("file","test.xml") cast as xs:string;
declare variable $coll := "/db/dirtytext";

declare function local:enter-text(
  $id   as xs:string,
  $doc  as node(),
  $text as xs:string+) as node()*
{
  let $new_content := attribute CONTENT {$text}		
  let $u           := update replace  $doc//alto:String[@ID=$id]/@CONTENT with $new_content

  return ($u)
    
};


let $doc :=
for $d in collection($coll)
where contains(util:document-name($d),$file)
return $d

let $wid  := request:get-parameter("id","P21_ST00017")  cast as xs:string
let $text := request:get-parameter("text","full of shit") cast as xs:string

let $run :=
if(contains(request:get-parameter("text","empty"),"empty")) then
	()
else
	local:enter-text($wid,$doc,$text)


for $word in $doc//alto:String[@ID=$wid]
    return (<span>{$word}</span>, comment {$text})

