/**
 * Created with IntelliJ IDEA.
 * User: romc
 * Date: 21-05-13
 * Time: 09:42
 * To change this template use File | Settings | File Templates.
 */
$(document).ready( function() {

    fetchDocument();

});

//make text field editable on click
$(document).on("click", "span", function() {
    $(this).attr('contenteditable', true);
    $(this).focus();
    $(this).addClass('label-active');
    startContent = $(this).text();
    var url = "http://viewer-test-01.kb.dk/fcgi-bin/iipsrv.fcgi?FIF=seq-1.jp2&WID=3000&RGN=0.3277437261477969,0.4088843278111714,0.025802668230464742,0.021741644500983&CVT=jpeg";
    var img = $.get(url);

    console.debug(img);
});

//remove highlight when focus leaves
$(document).on("focusout", "span", function() {
    updatedContent = $(this).text();
    $(this).removeClass('label-active');
    $(this).attr('contenteditable', false);
    //if text has been updated, remove label
    if (updatedContent != startContent) {
        $(this).removeClass('label');
        $(this).removeClass('label-important');
    }

    updateProgressBar();
});

function fetchDocument() {
    $.ajax({
        url : 'http://xstorage-test-01.kb.dk:8080/exist/rest/db/dirtytext/select-text.xq?id=ID10',
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