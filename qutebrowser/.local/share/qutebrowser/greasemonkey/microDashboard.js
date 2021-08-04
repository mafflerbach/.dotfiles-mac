
// ==UserScript==
// @name Micro dashboard service selector
// @namespace http://tampermonkey.net/
// @version 0.1
// @match https://web-dev.goorange.sixt.com/dashboard/query
// @match https://web-stage.goorange.sixt.com/dashboard/query
// @match https://web-prod.goorange.sixt.com/dashboard/query
// @require http://code.jquery.com/jquery-3.3.1.min.js
// ==/UserScript==

var style = "";
var mouseClickEvents = [ 'mousedown', 'click', 'mouseup' ];

// to add new button just add an element to the below list with the service and
// the method name
var myButtons = {
  "setValue" :
      [ 'com.sixt.service.configuration', 'Configuration.GetValue' ],
  "UpsertValue" :
      [ 'com.sixt.service.configuration', 'Configuration.UpsertValue' ],
};

injectcss();

var content =
    '<div style="position: fixed; bottom: 10px; left:10px; background-color:#FF7D19;border-radius: 8px;" id="FlagBox"><div class="switcher" style="color:#fff;">';

for (var key in myButtons) {
  content += "<button class='actionButton' id=" + key + ">" + key + "</button>"
}
content += "</div></div>";
$('body').append(content);

$('.actionButton').click(function() {
  var buttonId = $(this).attr('id');
  var service = myButtons[buttonId][0];
  var method = myButtons[buttonId][1];
  setTimeout(function() {
    clickOnDesiredService(service);
    setTimeout(function() {
      clickOnDesiredMethod(method);
    }, 2500);
  }, 150);
});

function clickOnDesiredService(service) {
  clickOnElement('[data-reactid=".0.2.$/=10.0.0.0.0.2.1"] > div', service)
}

function clickOnDesiredMethod(method) {
  clickOnElement('[data-reactid=".0.2.$/=10.0.0.0.1.2.1"] > div', method)
}

function clickOnElement(container, item) {
  var servicesList = document.querySelectorAll(container);
  servicesList.forEach(function(searchedItem) {
    if (searchedItem.innerText == item) {
      simulateMouseClick(searchedItem);
      return true;
    }
  });
  return false;
}

function simulateMouseClick(element) {
  mouseClickEvents.forEach(
      mouseEventType => element.dispatchEvent(new MouseEvent(
          mouseEventType, {bubbles : true, cancelable : true, buttons : 1})));
}

function injectcss() {

  style =
      "<style type='text/css'> .switcher button {border:1px solid #ccc;border-radius: 5px;box-shadow: 1px 1px 18px #333;padding:0.5em;margin:0.5em 1em;" +
      "background: rgb(255,255,255);" +
      "background: -moz-linear-gradient(top, rgba(255,255,255,1) 0%, rgba(229,229,229,1) 100%);" +
      "background: -webkit-linear-gradient(top, rgba(255,255,255,1) 0%,rgba(229,229,229,1) 100%);" +
      "background: linear-gradient(to bottom, rgba(255,255,255,1) 0%,rgba(229,229,229,1) 100%);" +
      "filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#e5e5e5',GradientType=0 );" +
      "}";

  style += ".config {" +
           "display:none;" +
           "font-size:0.5em;" +
           "text-align:left;" +
           "margin-left:1em;" +
           "}";

  style += "#configLable {" +
           "font-size:0.5em;" +
           "}";

  style += ".config input {" +
           "width:30%;" +
           "}";

  style += ".show {" +
           "display:block;" +
           "}";

  style += "</style>";

  $('head').append(style);
}

