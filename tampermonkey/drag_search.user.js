// ==UserScript==
// @name         drag_search
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  drag some text to search in google or baidu
// @author       an9wer
// @match        *://*/*
// @grant        as following
// ==/UserScript==

// Q: the difference between clientX, screenX
// thx: http://www.jacklmoore.com/notes/mouse-position/
// thx: https://stackoverflow.com/a/21452887

// Q: url regex
// thx: https://www.regextester.com/93652
// thx: https://gist.github.com/dperini/729294

(function() {
    'use strict';
    var moveX = { startX: 0, endX: 0, };

    document.addEventListener("dragstart", function(event) {
        moveX.startX = event.screenX;
    }, false);

    document.addEventListener("dragend", function(event) {
        // Q: the value of event.clientX always is 0 in firefox,
        //    but it works fine in chrome. (so we use event.screenX here)
        var text = event.dataTransfer.getData("text");

        var urlRegex = new RegExp(/^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/gm);
        if (text.match(urlRegex)) {
            window.open(text)
        } else {
            moveX.endX = event.screenX;
            if (moveX.endX > moveX.startX) {
                window.open("https://www.google.com/search?gl=us&hl=en&pws=0&num=30&gws_rd=cr&q=" + text)
            } else {
                window.open("https://www.baidu.com/s?wd=" + text)
            }
        }
    }, false);
})();
