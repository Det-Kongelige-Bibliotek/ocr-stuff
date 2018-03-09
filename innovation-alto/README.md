# Observations

## Encoding problems 

The text in at least some mets' files have been XML escaped using a simple string search and replace & -> &amp;. Meaning that we have 

Univers&amp;#xE6; theologi&amp;#xE6; systema in quo omnes ac singuli religionis Christian&amp;#xE6; articuli ita pertractantur; ut Prim&amp;#xF2;; vera sententia afferatur &amp; asseratur. Secund&amp;#xF2;; cotroversi&amp;#xE6; prisc&amp;#xE6; et recentes expediantur. Terti&amp;#xF2;; pr&amp;#xE6;cipui conscienti&amp;#xE6; casus &amp;#xE8; verbo divino decidantur authore Casparo Erasmo Brochmand

Instead of

Universæ theologiæ systema in quo omnes ac singuli religionis Christianæ articuli ita pertractantur; ut Primò; vera sententia afferatur &amp; asseratur. Secundò; cotroversiæ priscæ et recentes expediantur. Tertiò; præcipui conscientiæ casus è verbo divino decidantur authore Casparo Erasmo Brochmand
