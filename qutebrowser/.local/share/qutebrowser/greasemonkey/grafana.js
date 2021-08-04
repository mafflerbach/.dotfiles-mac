// ==UserScript==
// @name         Error Queues scraper
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://int-mon-d01.sixt.de/grafana/d/queue-errors/queue-errors-test*
// @match https://int-mon-s01.sixt.de/grafana/d/queue-errors/queue-errors*
// @match https://int-mon-p01.sixt.de/grafana/d/queue-errors/queue-errors*
// @match https://int-mon-d01.sixt.de/grafana/d/queue-errors/queue-errors*
// @require http://code.jquery.com/jquery-3.3.1.min.js

// ==/UserScript==



(function() {
    $(document).ready(function () {

        setTimeout(() => {
            getDumpCommand()
        }, 4000);

    });

})();


function getDumpCommand() {
    button="<div class=\"toMarkdownButton\" style=\"position:absolute;padding:1em; color:black;background-color:white; top:0px; right:50%; height:25px; z-index:9999;\">Markdown</div>";
    wrapper="<div class=\"toMarkdownBox\" style=\"display:none;position:absolute; top:50px; right:0;z-index:9999; background-color:rgba(0,0,0,0.4); width:100%; color:white;\"><pre style=\"white-space:pre-wrap; background-color:inherit\"></pre></div>";

    $("body").append(button);
    $("body").append(wrapper);

    $(".toMarkdownButton").click(function (){

        if ($(".toMarkdownBox:visible").length == 1) {
            $(".toMarkdownBox").css("display","none");
        }else {
            command = fillContent()
            $(".toMarkdownBox pre").text(command);
            $(".toMarkdownBox").css("display","block");
        }

    })

}


function fillContent (){

    var tableTr = $('#panel-1 > div > div:nth-child(1) > div > div.panel-content.panel-content--no-padding.table-panel-content > div > plugin-component > panel-plugin-table-old > grafana-panel > ng-transclude > div.table-panel-container > div.table-panel-scroll > table > tbody > tr');
    var command = "";
    $(tableTr).each(function () {
        var brokerName = $(this).find('td:nth-child(1)').text().trim().replace("mq-", "").replace("Broker Name", "").replace(/\-/g, "_");
        var queueName = "com.sixt."+$(this).find('td:nth-child(2)').text().trim().replace("Queue Name", "");
        var eventCount = $(this).find('td:nth-child(3)').text().trim().replace("Events", "").replace(" K", "000");

        command += "dumpAndReplaySolution "+brokerName+" "+queueName+ " "+ eventCount  + "\n";

    });


    command += "\n\n";
    $(tableTr).each(function () {
        var brokerName = $(this).find('td:nth-child(1)').text().trim().replace("mq-", "").replace("Broker Name", "").replace(/\-/g, "_");
        var queueName = "com.sixt."+$(this).find('td:nth-child(2)').text().trim().replace("Queue Name", "");
        var eventCount = $(this).find('td:nth-child(3)').text().trim().replace("Events", "").replace(" K", "000");

        command += "yes Yes | solution-support dump "+brokerName+" "+queueName+ " "+ eventCount  + "\n";

    });
    return command;

}
