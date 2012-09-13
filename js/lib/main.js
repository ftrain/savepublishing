require.config({
    urlArgs:"bust=" + (new Date()).getTime(),
    paths:{
        'twidgets':'http://platform.twitter.com/widgets',
        'ui':'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min'
    }
});

function loadCss(url) {
    /**
     *
     * @type {HTMLElement}
     *
     * Inserts stylesheet into source.
     */
    var link = document.createElement("link");
    link.type = "text/css";
    link.rel = "stylesheet";
    link.href = url + '?bust=' + (new Date()).getTime()
    if (document.createStyleSheet) {
        document.createStyleSheet(url);
    }
    else {
        document.getElementsByTagName("body")[0].appendChild(link);
    }
}

/*

 Extensions to native string.

 */

var trim = /^\s*(.*)\s*$/g;
String.prototype.trimWhitespace = function () {
    /**
     * Trims whitespace.
     *
     * Depends on a regular expression in variable trim.
     *
     *  @return {String}
     */
    return this.replace(trim, '\$1');
}

var newlines = /[\n\r]/g;
String.prototype.stripNewlines = function () {
    /**
     * Replaces newline with spaces.
     *
     * Depends on a regular expression in variable newLines.
     */
    return this.replace(newlines, ' ');
}

var para = /(.+?)SOCIALTEXT_BR\s*SOCIALTEXT_BR/g;
String.prototype.twoBreaksToSocialtext = function () {
    /**
     * Wraps text before two occurrences of SOCIALTEXT_BR in a socialtext class.
     *
     * Depends on a regular expression in variable para.
     *
     *  @return {String}
     */

    return this.replace(para, '<span class="socialtext-line">\$1</span><br/><br/>\n\n');
}

var rebreak = /(.*?)SOCIALTEXT_BR/g;
String.prototype.oneBreakToSocialtext = function () {
    /**
     * Wraps text before a break in a socialtext class.
     *
     * @return {String}
     *
     * Depends on a regular expression in variable rebreak.
     */
    return this.replace(rebreak, '<span class="socialtext-line">\$1</span><br/>');
}

String.prototype.wrapInSpan = function () {
    /**
     * Wraps text in a socialtext class.
     *
     * @return {String}
     */

    return '<span class="socialtext-text">' + this + '</span>';
}

var entities = /[&"><]/g;
String.prototype.replaceEntities = function () {
    /**
     *
     * @param char
     * @return {String}
     */

    function replace(char) {
        /**
         * Inserts HTML entitities
         *
         * @param char a single character that is one of &"><
         */
        switch (char) {
            case '&':
                return '&amp';
            case '"':
                return '&quot;';
            case '>':
                return "&gt;"
            case '<':
                return "&lt;"
        }
    }

    return this.replace(entities, function (a) {
        return replace(a);
    });
}


require(["jquery", "twidgets", "ui", "socialtext", "socialtext-styles"], function ($) {


    $(function () {
        loadCss('https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/ui-lightness/jquery-ui.css');

        // Get rid of scripts

        window.onload = window.onunload = function () {
        };
        $('script').remove();

        var findContent = function(node) {
            console.log('Called findContent');
            function _countMatches(arr) {
                /**
                 * Returns the length of an array, if that array exists, or zero.
                 * Useful in the context of regular expression results arrays.
                 *
                 * @param arr {Array} the array under consideration
                 */
                return arr ? arr.length : 0;
            }


            function addToAncestors(node, key, num) {
                /**
                 * Walk up the chain, cumulatively adding things.
                 * 
                 * @param np {jQuery}
                 * @param key {String} What we're measuring (P, A, etc.)
                 * @param num {Integer}
                 *
                 */ 
                $(node).parents('div,p,pre,br').each(function(){
                    var t = $(this);
                    var score = t.data(key) ? t.data(key) : 0;
                    var cumulative = score + num;
                    t.data(key, cumulative);
                    t.attr(key, cumulative);
                    var s = t.data();
                    var score = t.data('lowers')/t.data('A');
                    score = score ? score : 2000;
                    t.attr('score',score);
                    if (score > 100) {
                        t.css({'background':'pink'});
                    }


                });
            }
            
            function reTreeWalker(node) {
                if (node.nodeType==1) {
                    if (node.childNodes) {
                        for (var i=0; i<node.childNodes.length; i++) {
                            treeWalker(node.childNodes[i]);
                        }
                    }
                    console.log($(node), $(node).data());
                }
            }

            function treeWalker(node) {
                if (node.parentNode) {
                    if (node.nodeType==3) {
                        var str = node.nodeValue;
                        var caps = _countMatches(str.match(/[A-Z]/g));
                        var lowers = _countMatches(str.match(/[a-z]/g));
                        addToAncestors(node, 'caps', caps);
                        addToAncestors(node, 'lowers', lowers);
                    }
                    else if (node.nodeType==1) {
                        addToAncestors(node, node.nodeName, 1);
                        if (node.childNodes) {
                            for (var i=0; i<node.childNodes.length; i++) {
                                treeWalker(node.childNodes[i]);
                            }
                        }
                    }
                }
            }
            treeWalker(document.body);
        }

        var removeUntweetableHTML = function () {

            $('div,p,span').filter(function(){
                return $(this).data('lowers')/$(this).data('A') > 100;
            });
            $('span,a').filter(function() {
                return false;
            }).replaceWith(function(){
                return $(this).contents();
            });

            /*
            $('font,abbr,cite,ins,del,q,s,code').replaceWith(function () {
                return $(this).contents();
            });
            $('b,strong').replaceWith(function () {
                return '*' + $(this).html() + '*';
            });
            $('i,em').replaceWith(function () {
                return '_' + $(this).html() + '_';
            });
            $('br').replaceWith(function () {
                return 'SOCIALTEXT_BR';

            });
*/

        }

        var reparseHTML = function () {
            console.log('Called reparseHTML');

            $('body').html($('body').html());
        }


        var allTextNodes = function () {

            console.log('Called allTextNodes');

            function getTextNodes(node) {

                function clean(str, nodeToCheck) {
                    var ret = str;

                    if (nodeToCheck.parentNode.nodeName != 'PRE') {
                        ret = ret.stripNewlines().trimWhitespace();
                    }

                    return ret.replaceEntities().twoBreaksToSocialtext().oneBreakToSocialtext().wrapInSpan();

                }

                if (node) {
                    if (node.nodeType == 3) {
                        var cleaned = clean(node.nodeValue, node);
                        var el = $(cleaned)[0];
                        node.parentNode.insertBefore(el, node);
                        node.parentNode.removeChild(node);
                    }
                    else {
                        for (var i = 0, len = node.childNodes.length; i < len; ++i) {
                            getTextNodes(node.childNodes[i]);

                        }
                    }
                }
            }

            getTextNodes(document.body);
        }


        var fadeSomeElements = function () {
            $('img,object,iframe,script,ins').fadeTo('fast', 0.3);
        }
        /* From Underscore */
        var compose = function () {
            var funcs = arguments;

            return function () {

                var args = arguments;
                for (var i = funcs.length - 1; i >= 0; i--) {
                    args = [funcs[i].apply(this, args)];
                }
                return args[0];
            };
        };

//        compose(fadeSomeElements, reparseHTML, allTextNodes, reparseHTML, removeUntweetableHTML, findContent)();
     
        compose(findContent)();
     
        

        

        // Fade stuff out
        /*

         $('body').html(html);
         $('body').score(400);
         $('.socialtext-scored').socialtext();
         $('body').header();

         $().applySocialtextStyles();

         */


    });
})
;
