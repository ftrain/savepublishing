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

                /* Get rid of other scripts */
                window.onload = window.onunload = function () {
                };
                $('script').remove();

                /*
                 Extensions to native string.

                 */
                var words = {
                    // Numerals

                    'one':1,
                    'first':'1st',
                    'two':2,
                    'second':'2nd',
                    'three':3,
                    'third':'3rd',
                    'four':4,
                    'fourth':'4th',
                    'five':5,
                    'fifth':'5th',
                    'six':6,
                    'sixth':'6th',
                    'seven':7,
                    'seventh':'7th',
                    'eight':8,
                    'eighth':'8th',
                    'nine':9,
                    'ninth':'9th',
                    'ten':10,
                    'tenth':'10th',
                    'eleven':11,
                    'twelve':12,
                    'thirteen':13,
                    'fourteen':14,
                    'fifteen':15,
                    'sixteen':16,
                    'seventeen':17,
                    'eighteen':18,
                    'nineteen':19,
                    'twenty':20,
                    'thirty':30,
                    'forty':40,
                    'fifty':50,
                    'sixty':60,
                    'seventy':70,
                    'eighty':80,
                    'ninety':90,
                    'hundred':100,
                    'thousand':'1k',
                    'million':'mm',
                    'billion':'bn',
                    'trillion':'trln',

                    // Days of week
                    'monday':'Mon',
                    'tuesday':'Tue',
                    'wednesday':'Wed',
                    'thursday':'Thu',
                    'friday':'Fri',
                    'saturday':'Sat',
                    'sunday':'Sun',

                    // Days of week
                    'january':'Jan',
                    'february':'Feb',
                    'march':'Mar',
                    'april':'Apr',
                    'may':'May',
                    'june':'Jun',
                    'july':'Jul',
                    'august':'Aug',
                    'september':'Sep',
                    'october':'Oct',
                    'november':'Nov',
                    'december':'Dec',

                    // Misc terms
                    'every':'vry',
                    'see':'C',
                    'cool':'k',
                    'overheard':'OH',
                    'whatever':'wtv',
                    'your':'Ur',
                    'you':'U',
                    'about':'abt',
                    'because':'b\/c',
                    'before':'b4',
                    'chk':'chk',
                    'to':'2',
                    'and':'&',
                    'their':'thr',
                    'from':'frm',
                    'them':'thm',
                    'be':'B',
                    'large':'lrg',
                    'absolute':'abs.',
                    'becomes':'bcms',
                    'equal':'=',
                    'which':'whch',
                    'for':'4',
                    'are':'R',
                    'great':'gr8',
                    'at':'@',
                    'that':'th@',
                    'quarter':'1\/4',
                    'half':'1\/2',

                    // States
                    'Alabama':'AL',
                    'Alaska':'AK',
                    'Arizona':'AZ',
                    'Arkansas':'AR',
                    'California':'CA',
                    'Colorado':'CO',
                    'Connecticut':'CT',
                    'Delaware':'DE',
                    'District of Columbia':'DC',
                    'Florida':'FL',
                    'Georgia':'GA',
                    'Hawaii':'HI',
                    'Idaho':'ID',
                    'Illinois':'IL',
                    'Indiana':'IN',
                    'Iowa':'IA',
                    'Kansas':'KS',
                    'Kentucky':'KY',
                    'Louisiana':'LA',
                    'Maine':'ME',
                    'Maryland':'MD',
                    'Massachusetts':'MA',
                    'Michigan':'MI',
                    'Minnesota':'MN',
                    'Mississippi':'MS',
                    'Missouri':'MO',
                    'Montana':'MT',
                    'Nebraska':'NE',
                    'Nevada':'NV',
                    'New Hampshire':'NH',
                    'New Jersey':'NJ',
                    'New Mexico':'NM',
                    'New York':'NY',
                    'North Carolina':'NC',
                    'North Dakota':'ND',
                    'Ohio':'OH',
                    'Oklahoma':'OK',
                    'Oregon':'OR',
                    'Pennsylvania':'PA',
                    'Rhode Island':'RI',
                    'South Carolina':'SC',
                    'South Dakota':'SD',
                    'Tennessee':'TN',
                    'Texas':'TX',
                    'Utah':'UT',
                    'Vermont':'VT',
                    'Virginia':'VA',
                    'Washington':'WA',
                    'West Virginia':'WV',
                    'Wisconsin':'WI',
                    'Wyoming':'WY',
                    'American Samoa':'AS',
                    'Guam':'GU',
                    'Northern Mariana Islands':'MP',
                    'Puerto Rico':'PR',
                    'Virgin Islands':'VI'
                };

                // Borrowed from underscore.js
                var keys = [];
                for (var key in words) keys[keys.length] = key;
                word_regex = new RegExp('(\\b)(' + keys.join("|") + ')(\\b)', 'gi');


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

                    String.prototype.squeeze = function () {

                        var new_text = this;

                        new_text = new_text.replace
                                (
                                        word_regex,
                                        function (a, b, c, d) {
                                            return $this._toAbbreviation(b, c, d);
                                        }
                                );
                        new_text = new_text.replace
                                (
                                        /(with|of)\W/g,
                                        function (m) {
                                            return $this._toFirstSlash(m);
                                        }
                                );
                        new_text = new_text.replace(/\s+the\s+/gi, ' ');
                        new_text = new_text.replace(/(without)/g, 'w/out');
                        new_text = new_text.replace(/e(r|d)(\W)/g, '\$1\$2');
                        new_text = new_text.replace(/ has/g, '\'s ');
                        new_text = new_text.replace(/est/g, 'st');
                        new_text = new_text.replace(/\sam\b/g, '’m');
                        new_text = new_text.replace(/\b(will|shall)/g, '’ll');
                        new_text = new_text.replace(/\bnot/g, 'n’t');
                        new_text = new_text.replace(/e(r|n)(\b)/g, '\$1\$2');
                        new_text = new_text.replace(/\sfor/g, ' 4');
                        new_text = new_text.replace(/ have/g, '\'ve');
                        new_text = new_text.replace(/(1[0-9]|20)/g, function (a) {
                            return '&#' + (parseInt(a) + 9311) + ';'
                        });
                        return new_text;
                    }

                    String.prototype.tokenize = function () {
                        return this;
                    }

                    String.prototype.statements = function () {
                        return this;
                    }

                }

                String.prototype.parse = function () {

                    var string = this.replace(/ +/gi, ' ');

                    var statements = [];
                    var accum = [];
                    var size = 0;
                    var in_quote = false;
                    var in_parenthesis = false;
                    var in_bracket = false;
                    var lastcap, lastspace = 0;

                    function _glue(statement_type) {
                        /**
                         * Glues together statements if it looks like we've reached the
                         * end of a sentence.
                         *
                         * @param {statement_type} One of NEUTRAL, QUESTION,
                         * EXCLAMATION, or QUOTE
                         *
                         */
                        var statement_type = statement_type ? statement_type : 'NEUTRAL';
                        if (accum.length > 0) {
                            var new_string = accum.join("");
                            new_string = new_string.replace(
                                    /([<>"&])/g,
                                    function (a) {
                                        if (a === '&') return '&amp;';
                                        if (a === '<') return '&lt;';
                                        if (a === '>') return '&gt;';
                                        if (a === '"') return '&quot;';
                                    });
                            statements.push({'statement':new_string, 'size':size, 'statement_type':statement_type});
                            accum = [];
                            size = 0;
                        }
                    }

                    function _really(string, i, lastcap) {
                        /**
                         *
                         * Is this really the end of a sentence?
                         *
                         * @param {string} string The string we're evaluating
                         * @param {integer} i The number
                         * @param {integer} lastcap The position of the last capital letter
                         *
                         */
                        if (string.charAt(i + 1).match(/[\w\)"”]/)
                                || string.charAt(i + 2).match(/[a-z]/)
                                || string.charAt(i + 1).match(/[^\s]/)
                                )
                            return false;
                        if (string.charAt(i - 1) === '.') return false;
                        if ((i - lastcap) < 4) return false;

                        return true;
                    }

                    for (var i = 0; i < string.length; i++) {
                        var char = string.charAt(i);
                        size++;
                        accum.push(char);

                        if (char.match(/[A-Z]/)) lastcap = i;

                        switch (char) {
                            case '.':
                                if (!_really(string, i, lastcap)) break;

                                _glue('PERIOD');
                                break;

                            case '!':
                                if (!_really(string, i)) break;
                                _glue('EXCLAMATION');
                                break;

                            case '?':
                                if (!_really(string, i)) break;
                                _glue('QUESTION');
                                break;

                            case ';':
                                /*if ($this.settings.semicolons > 0
                                 && accum.length > $this.settings.semicolons) {
                                 _glue('SEMICOLON');
                                 }*/
                                break;

                            case '"':
                                /*if (in_quote && $this.settings.quotes) {
                                 _glue('QUOTE');
                                 in_quote = false;
                                 }
                                 else {
                                 in_quote = true;
                                 }*/
                                break;

                            case '“':
                                in_quote = true;
                                break;

                            case '”':
                                if (!_really(string, i)) break;
                                _glue('QUOTE' && $this.settings.quotes);
                                in_quote = false;
                                break;

                            case ',':
                                if (string.charAt(i + 1).match(/[”"]/)) break;


                                break;

                            case '—':
                                /*if ($this.settings.emdashes > 0
                                 && accum.length < $this.settings.emdashes
                                 && accum.length > 80) {
                                 _glue('EMDASH');
                                 }*/
                                break;

                            case '(':
                                in_parenthesis = true;
                                break;
                            case ')':
                                in_parenthesis = false;
                                break;
                            case '[':
                                in_bracket = true;
                                break;
                            case ']':
                                in_bracket = false;
                                break;


                            case ' ':
                                lastspace = i;
                                break;

                            default:
                                break;
                        }
                    }
                    _glue(); //Catch remainder

                    return statements;
                }
                /* End string functions */

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

                Element.prototype.getTextNodes = function () {
                    var texts = [];
                    if (this.nodeType && this.nodeType == 1 && this.hasChildNodes()) {
                        for (var i = 0; i < this.childNodes.length; i++) {
                            if (this.childNodes[i].nodeType === 3) {
                                texts.push(this.childNodes[i])
                            }
                        }
                    }
                    return texts;
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


                $.fn.removeTag = function () {
                    $(this).replaceWith(function () {
                        return $(this).contents();
                    });

                }
                $.fn.likelyNavClass = function () {
                    var classes = this.className;
                    if (!classes) return false;
                    classes = classes.toLowerCase();
                    var matches = classes.match(/footer|popular|nav|nocontentads|ad$|feed|sponsor|adx/);
                    return _matchCount(matches) > 0;
                }

                var findBreaks = function () {
                    /**
                     * Find all occurences of linebreaks in the DOM and replace them with an ugly string that we can parse as text.
                     */
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
                $.fn.isNav = function () {
                    return $(this).hasClass('socialtext-nav');
                }

                var getBlocks = function () {
                    var walk = function (node) {
                        /**
                         *
                         * @param {el} Element or jQuery element
                         */
                        var name = node.nodeName;
                        var el = $(node);

                        if (!el.isNav()
                                &&
                                (el.css('display') == 'block'
                                        || el.css('display') == 'table-cell'
                                        || name == 'LI')) {
                            var is_nav = 0;

                            if (el.text().length <= 20) is_nav++;

                            var txt = el.text();
                            var ratio = (el.children('a').text().length
                                    / txt.length);
                            if (0.333 <= ratio) is_nav++;

                            var uc = _matchCount(txt.match(/[A-Z]/g));
                            var lc = _matchCount(txt.match(/[a-z]/g));

                            if (uc / lc > 0.333) is_nav++;
                            if (el.likelyNavClass()) is_nav++;


                            if (name == 'ASIDE') is_nav++;
                            if (name == 'H1' || name == 'H2' || name == 'H3') is_nav = 0;
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
                    walk($('body'));

                    //$('h1,h2,h3').css({'background':'yellow'});
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
                    $('a').replaceWith(function () {
                        return ' ' + $(this).html() + ' ';
                    });

                }

                var reparseHTML = function () {
                    $('.socialtext-text').removeTag();
                    $('body').html($('body').html());
                }

                var allTextNodes = function () {

//                    $('pre').each(function () {
//                        var t = $(this).text();
//                        if (t) {
//                            return $(t.replace(/(.+)\n/g, '<div class="socialtext-pre">\$1</div>' + "\n"));
//                        }
//                    });

                    function getTextNodes(node) {
                        function clean(node) {
                            var ret = node.nodeValue;
                            var np = node.parentElement;
                            if (np.nodeName != 'PRE') {
                                ret = ret.stripNewlines().trimWhitespace();
                            }
                            var ret = ret.replaceEntities();
                            if (ret) {
                                var ret = ret.twoBreaksToSocialtext().oneBreakToSocialtext().wrapInSpan();
                            }
                            return ret;
                        }


                        if (node) {
                            if (node.nodeType != 3) {
                                for (var i = 0, len = node.childNodes.length; i < len; ++i) {
                                    if (node.className.indexOf('socialtext-nav') < 0) {
                                        if (!$(node).hasClass('socialtext-content')) {
                                            $(node).addClass('socialtext-content')
                                        }
                                        getTextNodes(node.childNodes[i]);
                                    }

                                }
                            } else {

                                var cleaned = clean(node);

                                var el = $(cleaned);

                                var np = node.parentElement;
                                console.log(el,np,jNode);
                                $(np).insertBefore(el, jNode);
                                $(node).remove();
                                //$(np).removeChild(node);
                                //node.nodeValue = clean(node.nodeValue, node);
                            }
                        }
                    }

                    getTextNodes(document.body);
                }


                $.fn.statements = function () {

                    var _makeUrl = function (statement) {
                        statement = $.trim(statement);
                        return '<a class="socialtext-statement" style="text-decoration: none;" href="'
                                + 'https://twitter.com/intent/tweet?text='
                                + encodeURI("“" + statement + "”")
                                + '&related=ftrain,savepub'
                                + '&url='
                                + encodeURI(location.href)
                                + '">'
                                + statement
                                + '*</a>';
                    }


                    var _fetchText = function (el) {
                        var text = [];
                        var kids = el.childNodes;
                        if (kids) {
                            for (var j = 0; j < kids.length; j++) {
                                var node = kids[j];


                                if (node.nodeType == 3) {

                                    text.push(node.nodeValue);
                                }
                            }

                        }
                        return text;

                    }


                    this.each(function () {
                        var in_statement = $(this).hasClass('socialtext-statement');

                        if (!in_statement) {
                            var tns = this.getTextNodes();
                            var span = $('<span class="socialtext-statement-set"/>');

                            for (i in tns) {

                                var t = tns[i];

                                var statements = t.nodeValue.parse();

                                for (j in statements) {
                                    var statement = statements[j];
                                    if (statement && statement.size > 2) {
                                        var url = $(_makeUrl(statement.statement));
                                        span.append(url);
                                    }
                                }
                                $(t).replaceWith(span);
                            }

                        }


                    });
                    //                    if (!($(this).parent().hasClass('socialtext-statement'))) {
                    //                        var parsed = $this._parse(this.nodeValue);
                    //                        var newval = $('<span class="socialtext-statement-set"/>');
                    //                        for (i in parsed) {
                    //                            if (parsed[i] && parsed[i].size > 2) {
                    //                                newval.append($($this._makeUrl(parsed[i].statement)).data('size', parsed[i].size));
                    //                            }
                    //                        }
                    //                        $(this).replaceWith(newval);
                    //
                    //                    }


                    return this;
                }

                var addLinks = function () {



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


                loadCss('https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/ui-lightness/jquery-ui.css');

                var logit = function () {
                    console.log($('body'));
                }

//                getBlocks();
//                entweeten();
//                stripas();
//                $('.socialtext-content').statements();
//                reparseHTML();
//                allTextNodes();
//                logit();


                var strip = function () {
                    $()
                }
                //compose(logit, entweeten, stripas, allTextNodes, getBlocks);
//                compose(addLinks, reparseHTML, entweeten, stripas, allTextNodes, getBlocks)();


            }
    )
    ;

}
sp__f(jQuery.noConflict());
