# Observations

## Size of data set

4286 mets and 1506876 alto files. With one mets per book, the average one should be about 350 pages. 

## Encoding problems 

The text in at least some mets' files have been XML escaped using a simple string search and replace & -> &amp;. Meaning that we have 

Univers&amp;#xE6; theologi&amp;#xE6; systema in quo omnes ac singuli religionis Christian&amp;#xE6; articuli ita pertractantur; ut Prim&amp;#xF2;; vera sententia afferatur &amp; asseratur. Secund&amp;#xF2;; cotroversi&amp;#xE6; prisc&amp;#xE6; et recentes expediantur. Terti&amp;#xF2;; pr&amp;#xE6;cipui conscienti&amp;#xE6; casus &amp;#xE8; verbo divino decidantur authore Casparo Erasmo Brochmand

Instead of

Universæ theologiæ systema in quo omnes ac singuli religionis Christianæ articuli ita pertractantur; ut Primò; vera sententia afferatur &amp; asseratur. Secundò; cotroversiæ priscæ et recentes expediantur. Tertiò; præcipui conscientiæ casus è verbo divino decidantur authore Casparo Erasmo Brochmand

Fixable using simple scripting

 perl -ne 's/&amp;amp;#/&#/g;print;' damaged_file.xml > fixed_file.xml

which should not damage the encoding further.

## Hypertext & References

Each METS file seem to contain a &lt;fileSec> ... &lt;/fileSec> with two &lt;fileGrp>...&lt;/fileGrp> which have USE="Image" and USE="Text". I am certain but it might not be possible to sort OCR or images in document order based on file name. Rather it has to be done based on &lt;structMap TYPE="PHYSICAL"> &lt;/structMap> where each &lt;div> ... &lt;/div> has an ORDER attribute containing a natural an integer which is zero for cover and spine etc but contains the ordering for the content.

1. File names seem to be unique in the whole corpus, not only per directory.

2. On each &lt;div> ... &lt;/div> there is also a LABEL attribute "Chapter page" or "None"

## damaged xml

To limit myself, I decided I'll go for Disk-017. In that subset I found the following damaged xml files. Given one file, I deleted the whole object.

Disk-017/den-kbd-all-110604000364/den-kbd-all-110604000364-001/ocr/den-kbd-all-110604000364-001-0017L.xml
Disk-017/den-kbd-all-130018106842/den-kbd-all-130018106842-001/den-kbd-all-130018106842-001.xml
Disk-017/den-kbd-all-130018106842/den-kbd-all-130018106842-001/ocr/den-kbd-all-130018106842-001-0119L.xml
Disk-017/den-kbd-all-110508043358/den-kbd-all-110508043358-001/ocr/den-kbd-all-110508043358-001-0200R.xml
Disk-017/den-kbd-all-110304000759/den-kbd-all-110304000759-001/ocr/den-kbd-all-110304000759-001-1254R.xml
Disk-017/den-kbd-all-110408012155/den-kbd-all-110408012155-001/ocr/den-kbd-all-110408012155-001-0229L.xml

## Volumes to work with

Selected four volumes

| Language | "ID" |
| Danish | den-kbd-all-110304010217 | 
| French | den-kbd-all-110308027669 |
| Latin  | den-kbd-all-110308039908 |
| Unknown| den-kbd-all-110308050622 |
