
// ==UserScript==
// @name         Error Queues scraper
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match https://www.lidl-kochen.de/rezeptwelt/*
(function() {
    $(document).ready(function () {

        content = getContent();
        console.log(content);
        button="<div class=\"toMarkdownButton\" style=\"position:absolute; top:0px; right:0; height:50px; z-index:9999;\">Markdown</div>";

        wrapper="<div class=\"toMarkdownBox\" style=\"display:none;position:absolute; top:50px; right:0;z-index:9999; background-color:rgba(0,0,0,0.8); width:60%; color:white;\"><pre style=\"white-space:pre-wrap\"></pre></div>";
        $("body").append(button);
        $("body").append(wrapper);

        $(".toMarkdownButton").click(function (){

        $(".toMarkdownBox pre").empty();
        content = getContent();
        $(".toMarkdownBox pre").text(content);
            $(".toMarkdownBox").css("display","block");

        })
    });


})();

function getContent () {


    let baseUrl = "https://www.lidl-kochen.de"
    let title = $(".recipe__header").text().trim().replace(/ /gi, "_");
    let ingredience = $(".ingredients-table").text();
    let image = $("div.recipe-slider > div.slider__slides > div > img").attr("src");
    let content='# '+$(".recipe__header").text().trim()+' #' + "\n"+
        '<div style="display:grid;grid-template-columns: auto auto; ">'+"\n"+
        '<div>'+"\n\n"+
        "```\n";

    content += ingredience;
    content+="```\n\n";
    content+='</div>'+"\n";
    content+='<div style="">'+"\n\n";
    content+="![Tag](../tags/"+title+".png)\n";

    content+='</div>'+"\n";
    content+='</div>'+"\n";
    content+="!["+title+"]("+baseUrl+image+")";

    $(".preparation__step").each(function (i) {
        content+="\n";
        content+= $(this).find(".preparation__step-number").text();
        content+="\n";
        content+= $(this).find(".preparation__step-content-text").text();
        content+="\n";

    });

    return content

}
