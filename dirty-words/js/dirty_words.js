/**
 * User: NKH
 * Date: 19-09-18
 */


$(document).ready( function() {
   fetchDocument();
});


var $imgid = "";

//make text field editable on click
$(document).on("click", "span", function(event) {
    if ($imgid){
       $(document.getElementById($imgid)).hide();
    }
    $(this).attr('contenteditable', true);
    $(this).focus();
    $(this).addClass('label-active');
    startContent = $(this).text();

    $imgid = "img"+$(this).attr('id');
       var sp = $(this);
       var position = sp.position();  
       $(document.getElementById($imgid)).css({"position":"absolute","left":10 ,"top":position.top+20}).show();    
});

//remove highlight when focus leaves
$(document).on("focusout", "span", function() {
    updatedContent = $(this).text();
    $(this).removeClass('label-active');
    $(this).attr('contenteditable', false);
    //if text has been updated, remove label
    if (updatedContent != startContent) {
        //$(this).removeClass('label');
        $(this).removeClass('label-important');
    }
    $spanid = $imgid.replace('img', '');
    $geturl = "http://xstorage-test-01.kb.dk:8080/exist/rest/db/dirtytext/receive-text.xq?id="+$spanid+"&text="+$(this).text()+"&file=den-kbd-all-110304010217-001-0014L.xml";
    var update = $.get( $geturl , function() {
       })
         .done(function() {
       })
         .fail(function() {
            console.log( "error" );
       });

    updateProgressBar();
});

function fetchDocument() {
    $.ajax({
        url : 'http://xstorage-test-01.kb.dk:8080/exist/rest/db/dirtytext/select-text.xq?file=den-kbd-all-110304010217-001-0014L.xml',
        //url: 'content.html',
        success: function(data) {
            $('.ocrContent').html(data);
            updateProgressBar();
        },
        dataType: "html"
        }
    );
}

function fetchPreview() {

}

//calculate current progress based on number of
//of problematic words
function updateProgressBar() {

    var numWords = $('span').length;
    var numErrors = $('.label-important').length;
    var numCorrect = numWords - numErrors;
    var progress = parseInt((100/numWords) * numCorrect);

    $('.bar-success').css("width", progress + "%");
    $('.bar-success').text(progress + "%");

}
