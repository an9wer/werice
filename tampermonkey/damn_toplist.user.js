// ==UserScript==
// @name         damn_toplist
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Hide baidu toplist
// @author       an9wer
// @match        *://www.baidu.com/*
// @grant        https://gist.github.com/icodejs/3183154
// ==/UserScript==

(function() {
    'use strict';

    // hide toplist after GET request
    var toplists = document.querySelectorAll("[tpl=right_toplist]");
    for (var toplist of toplists) {
        toplist.style.display = "none";
    }

    // thx: https://gist.github.com/icodejs/3183154
    var open = window.XMLHttpRequest.prototype.open,
        send = window.XMLHttpRequest.prototype.send,
        onReadyStateChange;

    // prepare HTTP request
    function openReplacement(method, url, async, user, password) {
        return open.apply(this, arguments);
    }

    // send HTTP request
    function sendReplacement(data) {
        if(this.onreadystatechange) {
            this._onreadystatechange = this.onreadystatechange;
        }
        this.onreadystatechange = onReadyStateChangeReplacement;

        // hide toplist after ajax request
        var toplists = document.querySelectorAll("[tpl=right_toplist]");
        for (var toplist of toplists) {
            toplist.style.display = "none";
        }

        return send.apply(this, arguments);
    }

    // change HTTP request ready state
    function onReadyStateChangeReplacement() {
        if(this._onreadystatechange) {
            return this._onreadystatechange.apply(this, arguments);
        }
    }

    window.XMLHttpRequest.prototype.open = openReplacement;
    window.XMLHttpRequest.prototype.send = sendReplacement;

})();
