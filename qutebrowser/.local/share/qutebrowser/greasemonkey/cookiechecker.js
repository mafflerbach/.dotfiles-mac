// ==UserScript==
// @name Cookie checker
// @version 0.1
// @description try to take over the world!
// @author You
// @match https://www.sixt.de/*
// @match http://www.sixt.de/*
// @match https://www.sixt.com/*
// @match http://www.sixt.com/*
// @match http://business.sixt.com/*
// @match https://business.sixt.com/*
// @match https://partner.sixt.de/*
// @match https://partner.sixt.com/*
// @grand all
//
// @require      http://code.jquery.com/jquery-3.3.1.min.js
// ==/UserScript==

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}


function setCookie(name,value,days) {
    if (value === undefined || value === '') {
        alert('please fill the config');
        return false;
    }

    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days*24*60*60*1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
    return true;
}

function deleteCookie(name) {
    // This function will attempt to remove a cookie from all paths.
    var pathBits = location.pathname.split('/');
    var pathCurrent = ' path=';

    // do a simple pathless delete first.
    document.cookie = name + '=; expires=Thu, 01-Jan-1970 00:00:01 GMT;';

    for (var i = 0; i < pathBits.length; i++) {
        pathCurrent += ((pathCurrent.substr(-1) != '/') ? '/' : '') + pathBits[i];
        document.cookie = name + '=; expires=Thu, 01-Jan-1970 00:00:01 GMT;' + pathCurrent + ';';
    }
}

function deleteAllCookies() {
    deleteCookie('mmcs');
    deleteCookie('mmca');
    deleteCookie('sx_developer');
    deleteCookie('mmdv');
    deleteCookie('mmvm');
}


function setSixtCookie(type){
    var result = true;
    switch (type) {
        case 'mmcs':
            setCookie(type, 'lee2Shu3');
            break;
        case 'mmca':
            setCookie(type, 'di9puB4s');
            break;
        case 'mmdv':
            setCookie(type, 'rac-Yie5kae9');
            result = setCookie('sx_developer', localStorage.developer);
            break;
        case 'mmvm':
            result = setCookie(type, localStorage.laptop);
            break;
        case 'debug':
            
            if (getCookie("XDEBUG_SESSION") === '') {
                result = setCookie(type, localStorage.lapp);
                result = setCookie('XDEBUG_SESSION', 'PHPSTORM');
            } else {
                deleteCookie('XDEBUG_SESSION');
            } 
            break;
        default:
            break;
    }
    return result;
}


function appendFlagBox(type, lable) {
    var content='<div id="FlagBox">';
    content += "<p>" + lable + "</p>";
    content +="<div class='switcher' style='color:#000;'>"+
        "<button id='mmcs'>stage</button>"+
        "<button id='mmca'>acceptance</button>"+
        "<button id='mmdv'>dev</button>"+
        "<button id='mmvm'>vm</button>"+
        "<button id=''>Prod</button>"+
        "<button id='debug'>Debug</button>"+
        "</div>";

    content+="<span id='configLable'>Config</span>"+
        "<div class='config' style='color:#000;'>"+
        "<lable for='laptop'>PC-Nr. Or Hostname</lable>:&nbsp"+
        "<input type='text' name='laptop' id='laptop' value='"+localStorage.laptop+"'/><br/>"+
        "<lable for='developer'>ldap Userr</lable>:&nbsp"+
        "<input type='text' name='developer' id='developer' value='"+localStorage.developer+"'/><br/>"+
        "<button id='saveConf'>Save</button>"+
        "</div>";

    content+="</div>";
    if (jQuery('#FlagBox').length == 0) {
        console.log(window.parent);
        jQuery('body').prepend(content);
    }

}

function injectcss() {

    var head = document.getElementsByTagName('head')[0];

    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = "https://code.jquery.com/jquery-3.3.1.min.js";
    head.appendChild(script);

    style="<style type='text/css'>";

    style+=".switcher button, .config button {"+
        "border:1px solid black;"+
        "padding:0.5em;"+
        "margin:0.5em 1em;"+
        "background: rgb(255,255,255);"+
        "background: -moz-linear-gradient(top, rgba(255,255,255,1) 0%, rgba(229,229,229,1) 100%);"+
        "background: -webkit-linear-gradient(top, rgba(255,255,255,1) 0%,rgba(229,229,229,1) 100%);"+
        "background: linear-gradient(to bottom, rgba(255,255,255,1) 0%,rgba(229,229,229,1) 100%);"+
        "filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#e5e5e5',GradientType=0 );"+
        "}";

    style+=".config {"+
        "display:none;"+
        "}";

    style+=".config input {"+
        "width:30%;"+
        "}";

    style+="#FlagBox {"+
        "display:block;"+
        "z-index:9999;"+
        "position: absolute;"+
        "width: 300px;"+
        "left: 0;"+
        "bottom: 33px;"+
        "}";

    style+=".show {"+
        "display:block;"+
        "}";

    style+="</style>";

    jQuery('head').append(style);
    jQuery('head').append('<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"></link>');

}

function checkFlag() {
    if (getCookie('mmca') !== '') {
        appendFlagBox('mmca', "WE ARE ON ACCEPTANCE");
    }
    if (getCookie('mmcs') !== '') {
        appendFlagBox('mmcs', "WE ARE ON STAGE");
    }
    if (getCookie('mmvm') !== '' || location.hostname === "localhost") {
        if (getCookie('XDEBUG_SESSION') !== '') {
            appendFlagBox('debug', "Debug ON VM");
        } else  {
            appendFlagBox('mmvm', "Debug OFF VM");
        }
    }
    if (getCookie('mmdv') !== '') {
         appendFlagBox('mmdv', "WE ARE ON DEV");
    }
    if (getCookie('mmca') === '' && getCookie('mmdv') === '' && getCookie('mmcs') === '' && getCookie('mmvm') === '' && location.hostname !== "localhost") {
        appendFlagBox('', "WE ARE ON PROD");
    }
}

(function() {

alert("sdfasdf");
    jQuery.noConflict();
    injectcss();
    checkFlag();

    jQuery(document).ready(function () {

        jQuery('.switcher button').click(function() {
            deleteAllCookies();
            if(setSixtCookie(jQuery(this).attr('id'))) {
                location.reload();
            };
        });
        jQuery('.config button').click(function() {
            localStorage.developer = jQuery('#developer').val();
            localStorage.laptop = jQuery('#laptop').val();
        });
    
        jQuery('#configLable').click(function() {
            jQuery('.config').toggleClass('show');
        });

        //jQuery('#FlagBox').dialog();
    });
    
})();
