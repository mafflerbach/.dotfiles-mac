
// ==UserScript==
// @name         Error Queues scraper
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @require https://code.jquery.com/jquery-3.6.0.min.js 
// @match https://www.chefkoch.de/rezepte/*
// @grant    all
//
//
//
(function() {


    'use strict';
    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = "https://code.jquery.com/jquery-3.3.1.min.js";
    head.appendChild(script);
    setTimeout(addLink, 2000);


})();

function addLink() {


        let title = jQuery("h1").text().trim().replace(/ /gi, "_");
        let content='# '+title+' #' + "\n"+
            '<div style="display:grid;grid-template-columns: auto auto; ">'+"\n"+
                    '<div>'+"\n\n"+
                    "```\n";

    jQuery(".ingredients tbody tr").each(function (i) {
        let tmpContent = ""
        tmpContent+= jQuery(this).find("td:first span").text().replace(/\s\s/g, '');
tmpContent+=" ";
tmpContent+= jQuery(this).find("td:last span").text().replace(/\s\s/g, ''); 
tmpContent+="\n";


        content+=tmpContent;
        });
        content+="```\n\n";
        content+='</div>'+"\n";
        content+='<div style="">'+"\n\n";
        content+="![Tag](../tags/"+title+".png)\n";

        content+='</div>'+"\n";
        content+='</div>'+"\n";

    content+= jQuery("body > main > article.ds-box.ds-grid-float.ds-col-12.ds-col-m-8.ds-or-3 > div:nth-child(3)").text();




    console.log(content);
button="<div class=\"toMarkdownButton\" style=\"position:absolute; top:120px; right:0; height:50px; z-index:9999;\">Markdown</div>";

wrapper="<div class=\"toMarkdownBox\" style=\"display:none;position:absolute; top:150px; right:0;z-index:9999; background-color:rgba(0,0,0,0.8); width:60%; color:white;\"><pre style=\"white-space:pre-wrap\"></pre></div>";
jQuery("body").append(button);
jQuery("body").append(wrapper);
jQuery(".toMarkdownBox pre").text(content);
jQuery(".toMarkdownButton").click(function (){

jQuery(".toMarkdownBox").css("display","block");

})


}

