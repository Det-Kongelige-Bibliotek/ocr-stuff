xquery version "3.0" encoding "UTF-8";


declare namespace ft="http://exist-db.org/xquery/lucene";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace mts="http://www.loc.gov/METS/";
declare namespace mds="http://www.loc.gov/mods/v3";
           

let $query  := request:get-parameter("q","placette")
let $from   := xs:integer(request:get-parameter("start",1))
let $to     := xs:integer(request:get-parameter("number",10)) + $from

return
<div>
<h1>{$query}</h1>
{
	for $doc at $count in collection("/db/pq")/mts:mets[ft:query(.,$query)]
	let $author := 
	for $a in $doc//mds:mods/mds:name[@type="personal" and contains(./mds:role/mds:roleTerm,"author")]
	return $a/mds:namePart/string()
	let $did := $doc//mds:mods/mds:recordInfo/mds:recordIdentifier/string()
	let $tit := $doc//mds:mods//mds:title/string()
	return <p>Author: {$author}<br/>Title: {$tit}<br/>Record: {$did}</p>
}
</div>


(:[position() = ($from to $to)]:)