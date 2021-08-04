// ==UserScript==
// @name Jenkins Search
// @version 0.1
// @description try to take over the world!
// @author You
// @match https://localhost/*
// @match http://localhost/*
// @grand all
// @require      http://code.jquery.com/jquery-3.3.1.min.js
// ==/UserScript==



(function() {
$('body').css("background-color", "#fff");
    injectInputField();
    injectEventHandler();



})();



function injectInputField(){

    var content='<input type="text" value="" id="fqsnSearch"/>';
    $("#description > div:nth-child(1)").append(content);

}
function injectEventHandler() {

    $('#fqsnSearch').on('keyup', function (e) {
        var lenght = $(this).val().length;
        if (length >= 3) {

        }
    })



}

