
// ==UserScript==
// @name         Form filler
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @require http://code.jquery.com/jquery-3.3.1.min.js
// @match        https://outlook.office365.com/owa/calendar/*
// ==/UserScript==

(function() {
    'use strict';

    setTimeout(fill, 2000);


})();

function fill(){
        //Name
        jQuery("#mainContainer > div > form > div.section.customerSection > div > div:nth-child(1) > input[type=text]:nth-child(1)").val( "Maren Afflerbach")
        //email
        jQuery("#mainContainer > div > form > div.section.customerSection > div > div:nth-child(1) > input[type=email]:nth-child(2)").val( "maren.afflerbach@sixt.com")
        //tel
        jQuery("#mainContainer > div > form > div.section.customerSection > div > div:nth-child(1) > div > input[type=tel]").val( "+49 151 22719358")
    
        //firstname
        jQuery("#\\36 cd6cedb-0bf4-4e7e-9aa0-75dd979aa0fc").val( "Maren")
        //lastname
        jQuery("#\\30 e288df8-a5ae-40f5-95cf-5976659acdb5").val( "Afflerbach")
        //birthday
        jQuery("#\\36 f7feb12-fd55-444b-bfda-d6a9205cea91").val( "09/01/1984")

        //street
        jQuery("#\\37 ee97940-d5f0-472d-9832-f7377ed292bb").val( "Meilerweg")

        //housenumber
        jQuery("#ed1fff15-dc4e-4f4a-a56f-3f6364815e95").val( "7")
        //zip
        jQuery("#\\31 2b8314e-a391-4168-8d70-71be5abac26a").val( "82041")
        //city
        jQuery("#e663ebe1-dcfb-46d6-945d-dd71546a9221").val( "Oberhaching")


//relationship option
        jQuery("#f65ca62e-34a4-4ab2-af1e-e4a8f6a51f28").val( "Internal Sixt Employee").change()

        jQuery("#\\39 7508486-39c0-402c-9f05-53a760f93571").val( "female").change()
    }
