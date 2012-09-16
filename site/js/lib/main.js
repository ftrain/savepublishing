require.config({
    urlArgs:"bust=" + (new Date()).getTime(),
    paths:{
        'twidgets':'http://platform.twitter.com/widgets',
        'ui':'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min'
    }
});

require(["jquery",
    "twidgets",
    "ui",
    "ExtendString",
    "LoadCSS",
    "socialtext",
    "socialtext-styles"], function ($) {


    $(function () {
        loadCss('https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/ui-lightness/jquery-ui.css');

        // Get rid of scripts

        window.onload = window.onunload = function () {
        };
        $('script').remove();

        var findContent = function (node) {
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
                $(node).parents('div,p,pre,br').each(function () {
                    var t = $(this);
                    var score = t.data(key) ? t.data(key) : 0;
                    var cumulative = score + num;
                    t.data(key, cumulative);
                    t.attr(key, cumulative);
                    var s = t.data();
                    var score = t.data('lowers') / t.data('A');
                    score = score ? score : 2000;
                    t.attr('score', score);
                    if (score > 100) {
                        t.css({'background':'pink'});
                    }


                });
            }

            function reTreeWalker(node) {
                if (node.nodeType == 1) {
                    if (node.childNodes) {
                        for (var i = 0; i < node.childNodes.length; i++) {
                            treeWalker(node.childNodes[i]);
                        }
                    }
                    console.log($(node), $(node).data());
                }
            }

            function treeWalker(node) {
                if (node.parentNode) {
                    if (node.nodeType == 3) {
                        var str = node.nodeValue;
                        var caps = _countMatches(str.match(/[A-Z]/g));
                        var lowers = _countMatches(str.match(/[a-z]/g));
                        addToAncestors(node, 'caps', caps);
                        addToAncestors(node, 'lowers', lowers);
                    }
                    else if (node.nodeType == 1) {
                        addToAncestors(node, node.nodeName, 1);
                        if (node.childNodes) {
                            for (var i = 0; i < node.childNodes.length; i++) {
                                treeWalker(node.childNodes[i]);
                            }
                        }
                    }
                }
            }

            treeWalker(document.body);
        }

        var removeUntweetableHTML = function () {

            $('div,p,span').filter(function () {
                return $(this).data('lowers') / $(this).data('A') > 100;
            });
            $('span,a').filter(function () {
                return false;
            }).replaceWith(function () {
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
