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
	    let $vpos   := $token/@VPOS
	    let $hpos   := $token/@HPOS
	    let $height := $token/@HEIGHT
	    let $width  := $token/@WIDTH
	    let $string :=
	    (element span {
              attribute id {concat("span",$hpos   ,",",
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
	       
            },<img class="{concat("img",$hpos   ,",",
	                           $vpos   ,",",
				   $width  ,",",
				   $height )}"
		style="display:none"  src="http://kb-images.kb.dk/public/pq/den-kbd-all-110304010217/den-kbd-all-110304010217-001/den-kbd-all-110304010217-001-0014L/{$vpos},{$hpos},{$width},{$height}/full/0/default.jpg"/>)
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

