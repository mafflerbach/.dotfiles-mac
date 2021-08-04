// ==UserScript==
// @name         sixt integration activeMQ userscript
// @namespace    com.sixt.integration
// @version      1.3.2
// @description  Improve the activeMQ web frontend for daily support usage
// @author       Daniel Graf Hoyos
// @include      http://int-mq-d01.sixt.de:*/admin/*
// @include      http://int-mqfe-d01.sixt.de:*/admin/*
// @include      http://int-mq-d03.sixt.de:*/admin/*
// @include      http://int-mq-s01.sixt.de:*/admin/*
// @include      http://int-mq-s02.sixt.de:*/admin/*
// @include      http://int-mqfe-s01.sixt.de:*/admin/*
// @include      http://int-mqfe-s02.sixt.de:*/admin/*
// @include      http://int-mq-s03.sixt.de:*/admin/*
// @include      http://int-mq-s04.sixt.de:*/admin/*
// @include      http://int-mq-p01.sixt.de:*/admin/*
// @include      http://int-mq-p02.sixt.de:*/admin/*
// @include      http://int-mqfe-p01.sixt.de:*/admin/*
// @include      http://int-mqfe-p02.sixt.de:*/admin/*
// @include      http://int-mq-p03.sixt.de:*/admin/*
// @include      http://int-mq-p04.sixt.de:*/admin/*
// @grant        GM.setClipboard
// @grant        GM_addStyle
// @require      http://code.jquery.com/jquery-3.3.1.min.js
// @require      http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.15.6/highlight.min.js
// @require      https://greasemonkey.github.io/gm4-polyfill/gm4-polyfill.js
// ==/UserScript==

(function () {
    'use strict';


    $(document).ready(function () {

        if(document.monkeyHunter){
            return;
        }
        document.monkeyHunter = true;

        const environments = {d:'dev',s:'stage',p:'prod'};
        const colors = {
            red: 'red',
            lightred: 'palevioletred',
            lightgreen: 'lightgreen',
            errorQueue: 'lightgrey',
            noneErrorQueue: 'white',
            queueHover: 'lightslategray',
            mirrorTR: 'lightblue',
            dev: '#595959',
            stage: '#C55A11',
            prod: '#C00000'
        };

        function reverse(str){
          return str.split("").reverse().join("");
        }

        const brokerName = document.title.split(' : ')[0];
        const isFrontendBroker = brokerName == "mq-frontend";
        const mqMachine = location.hostname.replace('.sixt.de','');
        const env = environments[reverse(mqMachine)[2]];
        const locationName = location.pathname.split(".jsp")[0];
        const urlParams = new URLSearchParams(location.search);
        const queueName = urlParams.get('JMSDestination');
        //add css styles :)
        GM_addStyle(`
            body {
                background-color: ${colors[env]};
            }
            .hljs{display:block;overflow-x:auto;padding:.5em;color:#333;background:#f8f8f8}.hljs-comment,.hljs-quote{color:#998;font-style:italic}.hljs-keyword,.hljs-selector-tag,.hljs-subst{color:#333;font-weight:bold}.hljs-number,.hljs-literal,.hljs-variable,.hljs-template-variable,.hljs-tag .hljs-attr{color:#008080}.hljs-string,.hljs-doctag{color:#d14}.hljs-title,.hljs-section,.hljs-selector-id{color:#900;font-weight:bold}.hljs-subst{font-weight:normal}.hljs-type,.hljs-class .hljs-title{color:#458;font-weight:bold}.hljs-tag,.hljs-name,.hljs-attribute{color:#000080;font-weight:normal}.hljs-regexp,.hljs-link{color:#009926}.hljs-symbol,.hljs-bullet{color:#990073}.hljs-built_in,.hljs-builtin-name{color:#0086b3}.hljs-meta{color:#999;font-weight:bold}.hljs-deletion{background:#fdd}.hljs-addition{background:#dfd}.hljs-emphasis{font-style:italic}.hljs-strong{font-weight:bold}
            .queue {
                background-color: ${colors.noneErrorQueue};
                transition:background-color .4s ease;
            }
            .mirror.queue {
                background-color: ${colors.mirrorTR};
            }
            .error.queue,
            .deadletter.queue {
                background-color: ${colors.errorQueue};
            }
            .queue:hover,
            .topic:hover {
                background-color: ${colors.queueHover};
            }
            .queue.has-consumers:not(.error):not(.deadletter) .consumers {
                background-color: ${colors.lightgreen};
            }
            .queue.no-consumers:not(.error):not(.deadletter) .consumers,
            .topic.no-consumers .consumers {
                background-color: ${colors.lightred}
            }
            .error.queue.has-consumers,
            .deadletter.queue.has-consumers {
                background-color: ${colors.red};
            }
            .queue.has-pending.no-comsumers:not(.error):not(.deadletter) {
                background-color: ${colors.red};
            }
            .queue.has-pending .pending,
            .subscriber.has-pending .pending {
                background-color: ${colors.lightred};
            }
            .error.queue.has-pending .pending,
            .deadletter.queue.has-pending .pending {
                background-color: ${colors.lightred};
            }
            #queues button,
            #topics button {
                cursor: pointer;
            }
            .topic.advisory {
                display:none;
            }
        `);



        $('.tooltip').each(function () {
            $(this).html($(this).find('span').html());
        });

        var port = window.location.port;

        var d01 = `http://int-mqfe-d01.sixt.de:${port}/admin/${isFrontendBroker ? 'topics' : 'queues'}.jsp`
        var s01 = `http://int-mqfe-s01.sixt.de:${port}/admin/${isFrontendBroker ? 'topics' : 'queues'}.jsp`
        var s02 = `http://int-mqfe-s02.sixt.de:${port}/admin/${isFrontendBroker ? 'topics' : 'queues'}.jsp`
        var p01 = `http://int-mqfe-p01.sixt.de:${port}/admin/${isFrontendBroker ? 'topics' : 'queues'}.jsp`
        var p02 = `http://int-mqfe-p02.sixt.de:${port}/admin/${isFrontendBroker ? 'topics' : 'queues'}.jsp`

        var monitoring = `http://int-mon-${reverse(mqMachine)[2]}01.sixt.de/grafana/d/brokers-detailed/brokers-detailed?var-component=${brokerName}`;
        $('#site-quicklinks').html(`<p>
            <a href="${monitoring}" target="_blank">Monitoring</a> |
            <a href="${d01}" target="_blank">DEV</a> (<a href="${d01.replace('fe','')}" target="_blank">old</a>) |
            <a href="${s01}" target="_blank" onclick="window.open(\'${s02}\');return true;">STAGE</a> (<a href="${s01.replace('fe','')}" target="_blank" onclick="window.open(\'${s02.replace('fe','')}\');return true;">old</a>) |
            <a href="${p01}" target="_blank" onclick="window.open(\'${p02}\');return true;">PROD</a> (<a href="${p01.replace('fe','')}" target="_blank" onclick="window.open(\'${p02.replace('fe','')}\');return true;">old</a>) |
        </p>`);


        // rewire logo link to topics/queues page

        if(isFrontendBroker){
            $('#activemq_logo a').attr("href", "/admin/topics.jsp");
        }else{
            $('#activemq_logo a').attr("href", "/admin/queues.jsp");
        }

        switch (locationName) {

            case "/admin/queues":

                // adjust table headings
                $("#queues th a").each(function (i) {
                    switch (i) {
                        case 1:
                            $(this).html("Pending");
                            break;
                        case 2:
                            $(this).html("Consumers");
                            break;
                        case 3:
                            $(this).html("Enqueued");
                            break;
                        case 4:
                            $(this).html("Dequeued");
                            break;
                    }
                });

                $("#queues th:nth-child(6)").hide();

                $("#queues tbody tr").each(function (i) {
                    $(this).addClass('queue');

                    var queue = $(this).find('td:first-child a span').html();
                    if(!queue) {
                        queue = $(this).find('td:first-child a').html();
                    }
                    queue = queue.trim();

                    // adjust table colors
                    var isError = queue.endsWith('.error') || queue == "ActiveMQ.DLQ";
                    if (queue.endsWith('.error'))
                        $(this).addClass('error');
                    if (queue.includes('.mirror'))
                        $(this).addClass('mirror');
                    if (queue == "ActiveMQ.DLQ")
                        $(this).addClass('deadletter');

                    var pendingCell = $(this).find("td:nth-child(2)")
                    var pending = parseInt(pendingCell.html());
                    pendingCell.addClass('pending');
                    if (pending > 0)
                        $(this).addClass('has-pending');
                    else
                        $(this).addClass('no-pending');

                    var consumersCell = $(this).find("td:nth-child(3)");
                    var consumers = parseInt(consumersCell.html());
                    consumersCell.addClass('consumers');
                    if(consumers > 0)
                        $(this).addClass('has-consumers');
                    else
                        $(this).addClass('no-consumers');

                    // clean up links
                    var viewsCell = $(this).find("td:nth-child(6)").first();
                    var copy = viewsCell.find("a:nth-child(2)");
                    consumersCell.html(copy.html(consumers));
                    viewsCell.hide();

                    // add copy button for queue name
                    $(this).find("td:first-child").prepend("<button>copy</button>&nbsp;")
                            .find("button")
                            .click(() => GM.setClipboard(queue));

                    // add confirmation alert for queue purge & queue delete
                    $(this).find("td:last-child a:nth-child(2)")
                        .click(() => confirm('Are you sure you want to purge this queue?'));


                    $(this).find("td:last-child a:nth-child(3)")
                        .click(() => confirm('Are you sure you want to delete this queue?'));

                });

                // restore table order
                $('th:last a')[0].click();
                $('th:first a')[0].click();

                break;

            case "/admin/send":

                // make textarea content an actual placeholder (enables fast paste)

                $('textarea').each(function () {
                    $(this).attr("placeholder", $(this).html())
                        .html("")
                        .css("width", "100%");
                });

                // add Queue Name to top of page heading

                $("h2").each(function () {
                    $(this).html($(this).html() + " to " + queueName);
                });

                // disable queue Name input field, and Queue/Topic select field
                var JMSDestinationInput = $("input[name='JMSDestination']");
                JMSDestinationInput.attr("placeholder", "foo.bar");

                var JMSDestinationTypeSelect = $("select[name='JMSDestinationType']");
                if (queueName) {

                    JMSDestinationInput.clone().appendTo(JMSDestinationInput.parent()).hide();
                    JMSDestinationInput.prop('disabled', true);
                    JMSDestinationTypeSelect.clone().appendTo(JMSDestinationTypeSelect.parent()).hide();
                    JMSDestinationTypeSelect.prop('disabled', true);
                } else {
                    JMSDestinationInput.val('');
                }
                break;

            case "/admin/browse":
                $("#messages thead th:nth-child(7) a")[0].click();

                var isError = queueName.endsWith(".error");

                // add replay button
                var targetQueue = queueName.substring(0, queueName.length - '.error'.length);
                var secret = $("#messages tbody tr td:last-child a").attr("href")
                    .split("secret=")[1]
                    .split("&")[0]

                $('#messages thead tr').each(function() {
                    $(this).find("th:nth-child(3) a").html("Transaction ID");
                    $(this).find("th:nth-child(4),th:nth-child(5),th:nth-child(6),th:nth-child(8)").hide();
                });


                $('#messages tbody tr').each(function() {
                    var firstCell = $(this).find("td:nth-child(1)");

                    if(firstCell.html().includes("&gt")){
                        var headerString = /title="{([\w\W]*)(?=}"&gt)/.exec(firstCell.html())[1];
                        firstCell.html(firstCell.html().replace(/\stitle="[\w\W]*&gt;/, ">"));
                    }else{
                        var headerString = $(this).find("td:nth-child(1) a").attr("title").slice(1,-1);
                    }

                    var headers = headerString.split(", ").filter(a=>a.includes("=")).map(keyValue => keyValue.split("=")).reduce((result, headerArray)=>{result[headerArray[0]] = headerArray[1]; return result;},{});
                    $(this).find("td:nth-child(2)").html(headers["X_HYPHEN_Correlation_HYPHEN_ID"]);
                    $(this).find("td:nth-child(3)").html(headers["X_HYPHEN_Transaction_HYPHEN_ID"]);
                    $(this).find("td:nth-child(4),td:nth-child(5),td:nth-child(6),td:nth-child(8)").hide();

                    if(isError){
                        var messageId = $(this).find('td:first-child a').html().split(':').join('%3A')
                        var moveHref = `moveMessage.action?destination=${targetQueue}&JMSDestination=${queueName}&messageId=${messageId}&JMSDestinationType=queue&secret=${secret}`;
                        $(this).find('td:last-child').append(`<a href="${moveHref}">Replay</a>`);
                    }
                });

                break;

            case "/admin/message":

                // pre-select matching error queue for moving messages

                if (queueName.endsWith('.error')) {
                    var targetQueue = queueName.substring(0, queueName.length - '.error'.length);
                    $("#queue").val(targetQueue).change()
                }

                // replace shortened queueNames
                $("#queue option").each(function(){
                    $(this).html($(this).attr("value"));
                });

                var originalMessage = $(".prettyprint").html();

                $("#body").append("<br/><br/><button>copy to clipboard</button>&nbsp;")
                    .find("button")
                    .click(() => GM.setClipboard(originalMessage));

                try{
                    $(".prettyprint").html(JSON.stringify(JSON.parse(originalMessage), null, 2));
                }catch(e) {
                    console.warn(e,"Message is not JSON");
                }


                $("#properties tbody tr").each(function(i){
                    if($(this).find(".label").html() == "failureCause"){
                        $(this).addClass("failureCause");
                        var contentCell = $(this).find("td:nth-child(2)").addClass("prettyprint");
                        var failureCause = contentCell.html();

                        contentCell.html("<pre>" + JSON.stringify(JSON.parse(failureCause), null, 2) + "</pre>");
                    }
                })

                $(".prettyprint").each((i, block)=>hljs.highlightBlock(block));

                break;

            case "/admin/topics":
                // adjust table headings
                $("#topics th a").each(function (i) {
                    switch (i) {
                        case 1:
                            $(this).html("Consumers");
                            break;
                        case 2:
                            $(this).html("Enqueued");
                            break;
                        case 3:
                            $(this).html("Dequeued");
                            break;
                    }
                });

                $("#topics tbody tr").each(function(i){
                    // add topic class to each row
                    $(this).addClass('topic');

                    var topicName = $(this).find('td:first-child a span').html();
                    if(!topicName) {
                        topicName = $(this).find('td:first-child a').html();
                    }
                    topicName = topicName.trim();

                    // tag advisory topics for hiding
                    if(topicName.startsWith("ActiveMQ.Advisory")){
                        $(this).addClass('advisory');
                    }

                    // highlight non-consumed topics
                    var consumersCell = $(this).find("td:nth-child(2)");
                    var consumers = parseInt(consumersCell.html());
                    consumersCell.addClass('consumers');
                    if(consumers > 0)
                        $(this).addClass('has-consumers');
                    else
                        $(this).addClass('no-consumers');

                    // add copy button for topic name
                    $(this).find("td:first-child")
                            .prepend("<button>copy</button>&nbsp;")
                            .find("button")
                            .click(() => GM.setClipboard(topicName));

                    // clean up topic links
                    var topicLink = $(this).find("td:first-child a");
                    var subscriberLink = $(this).find("td:last-child a:nth-child(2)");
                    var producersLink = $(this).find("td:last-child a:nth-child(4)");
                    topicLink.attr('href', subscriberLink.attr('href'));

                    subscriberLink.hide();
                    producersLink.hide();
                    $(this).find("td:last-child br:nth-child(3)").hide();

                    // ask before deletion
                    $(this).find("td:last-child a:nth-child(6)")
                        .click(() => confirm('Are you sure you want to delete this topic?'));

                });

                // restore table order
                $('th:last a')[0].click();
                $('th:first a')[0].click();

                break;

            case "/admin/topicSubscribers":
                    $("#producers tbody tr").each(function () {
                        $(this).addClass('subscriber');

                        var pendingCell = $(this).find("td:nth-child(7)")
                        var pending = parseInt(pendingCell.html());
                        pendingCell.addClass('pending');
                        if (pending > 0)
                            $(this).addClass('has-pending');
                        else
                            $(this).addClass('no-pending');
                        });
                break;

            case "/admin/subscribers":
                //clean up tables
                $("body > div > div.content > div > div > div > table > tbody > tr > td:nth-child(1) > div")
                    .prop("id", "content-container");

                $("#content-container > h2:nth-of-type(1)")
                    .prop("id", "active-durable-subscribers-heading");
                $("#content-container > table:nth-of-type(1)")
                    .prop("id", "active-durable-subscribers")
                    .addClass("subscribers durable active");

                $("#content-container > h2:nth-of-type(2)")
                    .prop("id", "offline-durable-subscribers-heading");
                $("#content-container > table:nth-of-type(2)")
                    .prop("id", "offline-durable-subscribers")
                    .addClass("subscribers durable offline");

                $("#content-container > h2:nth-of-type(3)")
                    .prop("id", "active-non-durable-subscribers-heading")
                $("#content-container > table:nth-of-type(3)")
                    .prop("id", "active-non-durable-subscribers")
                    .addClass("subscribers non-durable active");


                $(".subscribers thead tr").each(function(){
                    $(this).find("th:nth-child(5)").hide();
                });



                $(".subscribers tbody tr").each(function() {
                    $(this).addClass("subscriber");
                    $(this).find("td:nth-child(5)").hide();

                    // Hide advisory subscriptions
                    var destination = $(this).find("td:nth-child(4) span").html();
                    if(destination.startsWith("ActiveMQ.Advisory")){
                        $(this).hide();
                    }

                    // highlight pending queue sizes above 0
                    var pendingCell = $(this).find("td:nth-child(6)");
                    var pending = parseInt(pendingCell.html());
                    pendingCell.addClass("pending");
                    $(this).addClass(pending > 0 ? "has-pending" : "no-pending");
                });

                // rearrange sections
                $("#active-durable-subscribers-heading").insertAfter("#active-non-durable-subscribers");
                $("#active-durable-subscribers").insertAfter("#active-durable-subscribers-heading");

                break;
        }
    });


})();

