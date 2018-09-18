xquery version "1.0" encoding "UTF-8";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace fn="http://www.w3.org/2005/xpath-functions";
declare namespace file="http://exist-db.org/xquery/file";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace ft="http://exist-db.org/xquery/lucene";
declare namespace alto="http://schema.ccs-gmbh.com/ALTO";

declare variable $id := request:get-parameter("id","P269_TB00001") cast as xs:string;

(: According to the IIIF server the image have this dimension :)

declare variable $maxh := 3291;
declare variable $maxw := 3024;

(: Page size according to the alto file :)

let $alto_ht := 2090
let $alto_wd := 1920

return
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

	    let $reso := 400
	    let $x := $reso * number($hpos)   div 254
	    let $y := $reso * number($vpos)   div 254
	    let $h := $reso * number($height) div 254
	    let $w := $reso * number($width)  div 254

	    let $posid := string-join((xs:integer($x),xs:integer($y),xs:integer($w),xs:integer($h)),",")

	    let $string := 
	    (comment{ concat($vpos ," ", $hpos ," ", $height ," ", $width ) },element span {
              attribute id {$posid},
	      if($token/@WC cast as xs:double > 0.9) then 
		attribute class {"label"}
	      else 
		attribute class {"label label-important" }
		,
		let $text:=$token/@CONTENT/string()
		  return $text
	       
            },<img id="{concat("img",$posid)}" class="image"
		style="display:none"  
		src="http://kb-images.kb.dk/public/pq/den-kbd-all-110304010217/den-kbd-all-110304010217-001/den-kbd-all-110304010217-001-0014L/{$posid}/full/0/default.jpg"/>)
	    return $string
    return $htmltoken
  return ($htmlblock,<br/>)
}
</div>

