
// ==UserScript==
// @name         sixt integration confluence userscript
// @namespace    com.sixt.integration
// @version      1.1.2
// @description  Improve confluence to update two pages on a single click
// @author       Daniel Graf Hoyos
// @include      https://confluence.sixt.com/pages/viewpage.action?spaceKey=II&title=Broker+Overview
// @include      https://confluence.sixt.com/display/II/Broker+Overview
// @require      https://greasemonkey.github.io/gm4-polyfill/gm4-polyfill.js
// ==/UserScript==

(function () {
    'use strict';

    $("#main-content .confluenceTable tbody tr").each(function() {

        // link topics instead fo queues for the frontend broker
        var brokerName = $(this).find(".confluenceTd:nth-child(1)").html();

        // combine environment links and alwaysopen windows in new tabs
        var devCell = $(this).find(".confluenceTd:nth-child(2)");
        var d01 = devCell.find("a:first-child")
        var d03 = devCell.find("a:nth-child(3)")
        var d01Link = d01.attr("href");
        var d03Link = d03.attr("href");
        if(brokerName != "mq-frontend" && d01 != "d01") {
            d01.attr("href","#");
            d01.click((e)=>{e.preventDefault();window.open(d01Link);window.open(d03Link);return true;});
            d01.html("d03");
            d03.hide()
        }
        var stageCell = $(this).find(".confluenceTd:nth-child(3)");
        var s03 = stageCell.find("a:first-child")
        var s04 = stageCell.find("a:nth-child(3)")
        var s03Link = s03.attr("href");
        var s04Link = s04.attr("href");
        if(brokerName != "mq-frontend") {
            s03.attr("href","#");
            s03.click((e)=>{e.preventDefault();window.open(s03Link);window.open(s04Link);return true;});
            s03.html("s03 & s04");
            s04.hide()
        }
        var prodCell = $(this).find(".confluenceTd:nth-child(4)");
        var p03 = prodCell.find("a:first-child")
        var p04 = prodCell.find("a:nth-child(3)")
        var p03Link = p03.attr("href");
        var p04Link = p04.attr("href");
        if(brokerName != "mq-frontend") {
            p03.attr("href","#");
            p03.click((e)=>{e.preventDefault();window.open(p03Link);window.open(p04Link);return true;});
            p03.html("p03 & p04");
            p04.hide()
        }
    });
})();

