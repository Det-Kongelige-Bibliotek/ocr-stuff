xquery version "3.0" encoding "UTF-8";


declare namespace ft="http://exist-db.org/xquery/lucene";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace mts="http://www.loc.gov/METS/";
declare namespace mds="http://www.loc.gov/mods/v3";

declare option exist:serialize "method=xml media-type=text/html encoding=UTF-8";           

let $id  := request:get-parameter("id","")
let $query  := request:get-parameter("q","placette")

return
<html>
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
	  let $notes := 
	  for $n in $r//mds:note
	  return <span>{$n/string()}<br/></span>
	  return <p><strong>Author:</strong> {$author}<br/><strong>Title:</strong> {$tit}<br/><strong>Record:</strong> {$did}<br/><strong>Note:</strong>{$notes}</p>
}
</div>
</body>
</html>
