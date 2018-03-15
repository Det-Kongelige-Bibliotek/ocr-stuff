xquery version "3.0" encoding "UTF-8";


declare namespace ft="http://exist-db.org/xquery/lucene";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace mts="http://www.loc.gov/METS/";
declare namespace mds="http://www.loc.gov/mods/v3";

declare option exist:serialize "method=xml media-type=text/html encoding=UTF-8";
           

let $query  := request:get-parameter("q","")
let $from   := xs:integer(request:get-parameter("start",1))
let $to     := xs:integer(request:get-parameter("number",10)) + $from

return
<html>
<head><title>{$query}</title><meta http-equiv="Content-Type" content="text/html;charset:UTF-8"/></head>
<body>
<div>
<h1>{$query}</h1>
<form action="metadata-search.xq" method="get"><p>[<a href="start.xml">Start</a>]|[<input name="q" value="{$query}"/><input type="submit" value="search"/>]</p></form>
{
	for $doc at $count in collection("/db/pq")/mts:mets[ft:query(.,$query)]
	let $author := 
	for $a in $doc//mts:dmdSec[@ID="MODSMD_PRINT"]//mds:mods/mds:name[@type="personal" and contains(./mds:role/mds:roleTerm,"author")]
	return $a/mds:namePart/string()
	let $did := $doc//mts:dmdSec[@ID="MODSMD_PRINT"]//mds:mods/mds:recordInfo/mds:recordIdentifier/string()
	let $tit := $doc//mts:dmdSec[@ID="MODSMD_PRINT"][1]//mds:mods//mds:title/string()
	let $href := <a href="./get-volume.xq?id={$did}&amp;q={$query}">{$doc//mds:mods//mds:title/string()}</a>
	return <p><strong>Author:</strong> {$author}<br/><strong>Title:</strong> {$href}<br/><strong>Record:</strong> {$did}</p>
}
</div>
</body>
</html>
