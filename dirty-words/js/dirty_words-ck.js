/**
 * Created with IntelliJ IDEA.
 * User: romc
 * Date: 21-05-13
 * Time: 09:42
 * To change this template use File | Settings | File Templates.
 */function fetchDocument(){$.ajax({url:"http://disdev-01.kb.dk/storage/dirtytext/select-text.xq?id=ID10",success:function(e){$(".ocrContent").html(e);updateProgressBar()},dataType:"html"})}function updateProgressBar(){var e=$("span").length,t=$(".label-important").length,n=e-t,r=parseInt(100/e*n);$(".bar-success").css("width",r+"%");$(".bar-success").text(r+"%")}$(document).ready(function(){fetchDocument()});$(document).on("click","span",function(){$(this).attr("contenteditable",!0);$(this).focus();$(this).addClass("label-active");startContent=$(this).text()});$(document).on("focusout","span",function(){updatedContent=$(this).text();$(this).removeClass("label-active");$(this).attr("contenteditable",!1);if(updatedContent!=startContent){$(this).removeClass("label");$(this).removeClass("label-important")}updateProgressBar()});