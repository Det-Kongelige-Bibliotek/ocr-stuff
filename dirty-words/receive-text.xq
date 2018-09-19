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
  $text as xs:string*
{
  let $content := $doc//node()[@xml:id=$id]/@CONTENT
  let $new_content := attribute CONTENT {$text}		

  let $bibl_date    := $doc//t:bibl[@xml:id = $letter/@decls]/t:date

  let $date_struct  := $json//pair[@name="date"]
  let $date_val     := $date_struct/pair[@name="edtf"]/text()


  let $mid          := concat("idm",util:uuid())
  let $date         := <t:date xml:id="{$mid}">{$date_val}</t:date>
  let $u            := update replace $bibl_date with $date
  let $same :=
    if($date_struct/pair[@name="xml_id"]/text()) then
      let $date_text_id := $date_struct/pair[@name="xml_id"]/text()
      let $s            := update insert attribute sameAs {$mid} into 
	$letter//t:date[@xml:id = $date_text_id]
      return $s
    else
      ""

  return ()
    
};


let $doc :=
for $d in collection($coll)
where contains(util:document-name($d),$file)
return $d

let $wid  := request:get-parameter("wid","P21_ST00017")  cast as xs:string
let $text := request:get-parameter("text","") cast as xs:string

for $word in $doc//alto:String[@ID=$wid]
    return <span>{$word}</span>

