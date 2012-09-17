/*
 console.log('got this far');

 r = st_require;

 r.config({
 urlArgs:"bust=" + (new Date()).getTime(),
 shim:{underscore:{exports:'_'}},
 paths:{
 'twidgets':'http://platform.twitter.com/widgets',
 'ui':'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min'
 }
 });

 r(["jquery", "twidgets", "ui", "ExtendString", "LoadCSS", "socialtext", "socialtext-styles"]);
 */

function sp__f($) {
    $(document).ready(function () {
        // Code that uses jQuery's $ can follow here.

        window.onload = window.onunload = function () {
        };
        $('script').remove();

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

        var para = /(.+?)SOCIALTEXT_BR\s*SOCIALTEXT_BR/gm;
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

        var rebreak = /(.*?)SOCIALTEXT_BR/gm;
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

            String.prototype.tokenize = function () {
                return this;
            }

            String.prototype.statements = function () {
                return this;
            }

        }


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
                document.body.appendChild(link);
            }
        }


        loadCss('https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/ui-lightness/jquery-ui.css');


        $.fn.removeTag = function () {
            $(this).replaceWith(function () {
                return $(this).contents();
            });

        }
        $.fn.likelyNavClass = function () {
            var classes = $(this).attr('class')
            if (!classes) return false;
            classes = classes.toLowerCase();
            var matches = classes.match(/footer|popular|nav|nocontent|link|meta|ads|ad$|feed|sponsor|adx/);
            console.log($(this)[0].nodeName, classes, matches);
            return _matchCount(matches) > 0;
        }
        Element.prototype.isHeading = function () {
            switch (this.nodeName) {
                case 'H1':
                    return true;
                case 'H2':
                    return true;
                case 'H3':
                    return true;
                case 'BIG':
                    return true;
                default:
                    return false;
            }

        }


        var findBreaks = function () {
            $('br').replaceWith(function () {
                return 'SOCIALTEXT_BR';
            });
        }


        var _matchCount = function (arr) {
            /**
             * Returns the length of an array, if that array exists, or zero.
             * Useful in the context of regular expression results arrays.
             *
             * @param arr the array under consideration
             */
            return arr ? arr.length : 0;
        }
        var color = function (el) {
            el.css({'background':'pink'});
        }
        var getBlocks = function () {
            var walk = function (node) {
                /**
                 *
                 * @param {el} Element or jQuery element
                 */
                var name = node.nodeName;
                var el = $(node);

                if (el.css('display') == 'block' || el.css('display') == 'table-cell' || name == 'LI') {
                    var is_nav = 0;

                    if (el.text().length <= 20) is_nav++;

                    var txt = el.text();
                    var ratio = (el.children('a').text().length
                            / txt.length);
                    if (0.333 <= ratio) is_nav++;

                    var uc = _matchCount(txt.match(/[A-Z]/g));
                    var lc = _matchCount(txt.match(/[a-z]/g));

                    if (uc / lc > 0.333) is_nav++;
                    // if (el.likelyNavClass()) is_nav++;


                    if (name == 'ASIDE') is_nav++;

                    if (is_nav) {
                        el.addClass('socialtext-nav');
                        el.find('*').addClass('socialtext-nav');
                    }
                    else {
                        el.children().each(function () {
                            walk(this);
                        });
                    }
                }


            }
            $('img,object').css({'opacity':'.2'});
            walk($('body'));
            $('h1,h2,h3').css({'background':'yellow'});
        }



        var entweeten = function () {
            $('font,abbr,cite,ins,del,q,s,code').removeTag();
            $('b,strong').replaceWith(function () {
                return '*' + $(this).html() + '*';
            });
            $('i,em').replaceWith(function () {
                return '_' + $(this).html() + '_';
            });

        }
        var stripas = function () {
            $('a').removeTag();
        }

        var reparseHTML = function () {
            console.log('Called reparseHTML');
            $('.socialtext-text').removeTag();
            $('body').html($('body').html());
        }

        var allTextNodes = function () {

            console.log('Called allTextNodes');

            $('pre').each(function() {
                var t = $(this).text();
                if (t) {
                return $(t.replace(/(.+)\n/g, '<div class="socialtext-pre">\$1XXX</div>' + "\n"));
                }
            });
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
                        //node.nodeValue = clean(node.nodeValue, node);
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
        compose(entweeten, reparseHTML, stripas, allTextNodes, getBlocks)();
        $('.socialtext-nav').css({'background':'pink'});
        $('*').not('.socialtext-nav').socialtext();
        $('.socialtext-hide').css({'color':'silver'});
    });

}
sp__f(jQuery.noConflict());
