// ==UserScript==
// @name reddit
// @version 0.1
// @description try to take over the world!
// @author You
// @match https://www.reddit.com/*
// @require https://ajax.googleapis.com/ajax/libs/jquery/3.3.0/jquery.min.js 
// @grand none
// ==/UserScript==

(function() {


    $(document).scroll(function () {
    console.log("scroll");        
  $('.promotedlink').style.display = "none";
    
    });
    
    
})();
