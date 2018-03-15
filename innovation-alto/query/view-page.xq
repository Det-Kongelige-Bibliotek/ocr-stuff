xquery version "3.0" encoding "UTF-8";

declare namespace local="http://kb.dk/this/app";
declare namespace ft="http://exist-db.org/xquery/lucene";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace mts="http://www.loc.gov/METS/";
declare namespace mds="http://www.loc.gov/mods/v3";
declare namespace xlink="http://www.w3.org/1999/xlink";

declare option exist:serialize "method=xml media-type=text/html encoding=UTF-8";           


let $id  := request:get-parameter("id","")
let $query  := request:get-parameter("q","")
let $page := request:get-parameter("page","")


return
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>ID={$id}; PAGE={$page}</title><meta http-equiv="Content-Type" content="text/html;charset:UTF-8"/></head>
<body>
<h1>ID={$id}</h1>
<form action="metadata-search.xq" method="get"><p>[<a href="start.xml">Start</a>]|[<input name="q" value="{$query}"/><input type="submit" value="search"/>]</p></form>
<div>
{

}
</div>

</body>
</html>
