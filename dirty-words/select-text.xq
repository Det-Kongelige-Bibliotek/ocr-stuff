xquery version "1.0" encoding "UTF-8";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace fn="http://www.w3.org/2005/xpath-functions";
declare namespace file="http://exist-db.org/xquery/file";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace ft="http://exist-db.org/xquery/lucene";
declare namespace alto="http://schema.ccs-gmbh.com/ALTO";

declare variable $id := request:get-parameter("id","P269_TB00001") cast as xs:string;

declare variable $maxh := 25941;
declare variable $maxw := 20463;

<div>
{
for $block in collection("/db/dirtytext")//alto:TextBlock[@ID=$id]
  let $htmlblock:=
  for $line in $block/alto:TextLine
  return
      for $token in $line/alto:SP|$line/alto:String
	let $htmltoken :=
	  if(contains(name($token),'SP')) then
	    let $space := "&#160;"
	    return $space
	  else
	    let $vpos   := $token/@VPOS   div $maxh
	    let $hpos   := $token/@HPOS   div $maxw
	    let $height := $token/@HEIGHT div $maxh
	    let $width  := $token/@WIDTH  div $maxw
	    let $string :=
	    (element span {
              attribute id {concat($hpos   ,",",
	                           $vpos   ,",",
				   $width  ,",",
				   $height )},
	      if($token/@WC cast as xs:double > 0.9) then 
		attribute class {"label"}
	      else 
		attribute class {"label label-important" }
		,
		let $text:=$token/@CONTENT/string()
		  return $text
            })
	    return $string
    return $htmltoken
  return $htmlblock
}
</div>


(:
Image from LOC
width 6738
height 8497
Size in alto coordinates
alto-height 25941
alto-width 20463
Image Size width x height : 1705x2161
432.0:534.0:6618.0:3261.0
@HEIGHT,":",@WIDTH,":",@HPOS,":",@VPOS

:)

