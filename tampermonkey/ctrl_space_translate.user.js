// ==UserScript==
// @name         ctrl_space_translate
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  bind `ctrl-space` key to translate selected text
// @author       an9wer
// @match        *://*/*
// @grant        https://stackoverflow.com/a/3545105
// ==/UserScript==

(function() {
    'use strict';

    document.addEventListener("keypress", function(event) {
        var word = window.getSelection().toString();
        if (event.ctrlKey && event.key == " ") {
            window.open("https://dictionary.cambridge.org/search/english/direct/?source=gadgets&q=" + word);
        }
    }, false)

})();
