// ==UserScript==
// @name         VideoId scraper
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.tele5.de/*
// @require http://code.jquery.com/jquery-3.3.1.min.js
// ==/UserScript==

(function() {
    'use strict';

    setTimeout(addLink, 3000);


})();

function addLink(){
    console.log("TRGERRRR");
    jQuery(document).ready(function (){
        var videoId = jQuery(jQuery("*[data-video-id]").get(0)).data("video-id");
        console.log(videoId);
        var menuEntry ='<li id="menu-item-210474" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-210474"><a href="https://cdn.jwplayer.com/v2/media/'+videoId+'">Open in mpv</a></li>';

        jQuery(".menu").append(menuEntry)

    })

}
