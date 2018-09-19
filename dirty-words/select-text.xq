xquery version "3.1" encoding "UTF-8";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace fn="http://www.w3.org/2005/xpath-functions";
declare namespace file="http://exist-db.org/xquery/file";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace ft="http://exist-db.org/xquery/lucene";
declare namespace alto="http://schema.ccs-gmbh.com/ALTO";

declare variable $file := request:get-parameter("file","den-kbd-all-110304010217-001-0014L") cast as xs:string;
declare variable $coll := "/db/dirtytext";
(:
let $garbage := "den-kbd-all"
let $stuff   := substring-after($file,$garbage)
let $number  := replace($stuff,"(\d{3}).(\d{4}R|L)$","")
let $part    := replace($stuff,"^($garbage).(\d{11})\-(\d{3}).(\d{4}R|L)","$3")
let $pg      := replace($file,"^($garbage).(\d{11}).(\d{3}).","")

let $book    := string-join(($garbage,$number),"-")
let $volume  := string-join(($book,$part),"-")
let $page    := string-join(($volume,$pg),"-")
:)
let $doc :=
for $d in collection($coll)
where contains(util:document-name($d),$file)
return $d

let $id  := request:get-parameter("id","P269_TB00001") cast as xs:string

(: According to the IIIF server the image have this dimension :)

let $maxh := 3291
let $maxw := 3024

(: Page size according to the alto file :)

let $alto_ht := 2090
let $alto_wd := 1920

return
<div>
{
for $block in $doc//alto:TextBlock
  let $blid := $block/@ID
  let $htmlblock:=
	<p id="{$blid}">  {

	 for $line in $block/alto:TextLine
	     return
		for $token in $line/alto:SP|$line/alto:String
		let $tokid := $token/@ID
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
		   let $data_source := concat("http://kb-images.kb.dk/public/pq/den-kbd-all-110304010217/den-kbd-all-110304010217-001/den-kbd-all-110304010217-001-0014L/",$posid,"/full/0/default.jpg")

		   let $string := 
		       (
			comment{
				concat($vpos ," ", $hpos ," ", $height ," ", $width ) },element span {
				attribute id {$tokid},
				if($token/@WC cast as xs:double > 0.9) then 
				attribute class {"label"}
				else 
				attribute class {"label label-important" }
				,
				let $text:=$token/@CONTENT/string()
				return $text
				},
			<img id="{concat("img",$tokid)}" class="image"
			     src="{$data_source}"
			     style="display:none"/>)
  		    return $string
	return $htmltoken
	} </p>
  return ($htmlblock)
}
</div>

