# Observations

## Size of data set

4286 mets and 1506876 alto files. With one mets per book, the average one should be about 350 pages. 

## Encoding problems 

The text in at least some mets' files have been XML escaped using a simple string search and replace & -> &amp;. Meaning that we have 

Univers&amp;#xE6; theologi&amp;#xE6; systema in quo omnes ac singuli religionis Christian&amp;#xE6; articuli ita pertractantur; ut Prim&amp;#xF2;; vera sententia afferatur &amp; asseratur. Secund&amp;#xF2;; cotroversi&amp;#xE6; prisc&amp;#xE6; et recentes expediantur. Terti&amp;#xF2;; pr&amp;#xE6;cipui conscienti&amp;#xE6; casus &amp;#xE8; verbo divino decidantur authore Casparo Erasmo Brochmand

Instead of

Universæ theologiæ systema in quo omnes ac singuli religionis Christianæ articuli ita pertractantur; ut Primò; vera sententia afferatur &amp; asseratur. Secundò; cotroversiæ priscæ et recentes expediantur. Tertiò; præcipui conscientiæ casus è verbo divino decidantur authore Casparo Erasmo Brochmand

Fixable using simple scripting

 perl -ne 's/&amp;#/&#/g;print;' damaged_file.xml > fixed_file.xml

which should not damage the encoding further.

## Hypertext & References

Each METS file seem to contain a <fileSec> ... </fileSec> with two <fileGrp>...</fileGrp> which have USE="Image" and USE="Text". I am certain but it might not be possible to sort OCR or images in document order based on file name. Rather it has to be done based on <structMap TYPE="PHYSICAL"> </structMap> where each <div> ... </div> has an ORDER attribute containing a natural an integer which is zero for cover and spine etc but contains the ordering for the content.

1. File names seem to be unique in the whole corpus, not only per directory.

2. On each <div> ... </div> there is also a LABEL attribute "Chapter page" or "None"