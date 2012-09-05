require.config({
    urlArgs:"bust=" + (new Date()).getTime(),
    paths:{
        'twidgets':'http://platform.twitter.com/widgets',
        'ui':'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min'
    }
});

function loadCss(url) {
    var link = document.createElement("link");
    link.type = "text/css";
    link.rel = "stylesheet";
    link.href = url + '?bust=' + (new Date()).getTime()
    if (document.createStyleSheet) {
        document.createStyleSheet(url);
    }
    else {
        document.getElementsByTagName("head")[0].appendChild(link);
    }
}

require(["jquery", "twidgets", "ui", "socialtext"], function ($) {
            $(function () {


                        loadCss('https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/ui-lightness/jquery-ui.css');
                        loadCss('http://www.savepublishing.com/css/bookmarklet.css');

                        var hide = false;
                        var shrink = false;


                        $('img,object,iframe,script,ins').fadeTo('fast', 0.3);

                        function tidy() {
                            $('b,strong').replaceWith(function () {
                                return '*' + $(this).text().trim() + '*';
                            });
                            $('i,em').replaceWith(function () {
                                return '_' + $(this).text().trim() + '_';
                            });
                            $('a,abbr,cite,ins,del,q,s,code').replaceWith(function () {
                                return $(this).contents();
                            });
                            $('br').parent().each(function () {
                                var html = $(this).html();
                                html = html.replace(/([^>]+)<br[^>]?>\s?<br[^>]?>/gi, '<p>\$1</p>');
                                html = html.replace(/([^>]+)<br[^>]?>/gi, '<div class="socialtext-break">\$1</div>');
                                html = html.replace(/^(.+)$/gi, '<div class="socialtext-break">\$1</div>');
                                $(this).html(html);
                            });

                        }
                        //body *:not(img,object,iframe,script,ins)

                        function doIt(params) {


                            $('span,h1,h2,h3,h4,h5,h6,p,blockquote,li,pre,td')
                                    .contents()
                                    .filter(function () {
                                        return (this.nodeType == 3) && this.nodeValue.match(/\S/);
                                    })
                                    .parent()
                                    .socialtext(params);
                        }

                        $.when(tidy).done(doIt);


                            // via http://stackoverflow.com/questions/298750/how-do-i-select-text-nodes-with-jquery
                        function getTextNodesIn(node, includeWhitespaceNodes) {
                            var textNodes = [], whitespace = /^\s*$/;

                            function getTextNodes(node) {
                                if (node.nodeType == 3) {
                                    if (includeWhitespaceNodes || !whitespace.test(node.nodeValue)) {
                                        textNodes.push(node);
                                    }
                                } else {
                                    for (var i = 0, len = node.childNodes.length; i < len; ++i) {
                                        getTextNodes(node.childNodes[i]);
                                    }
                                }
                            }

                            getTextNodes(node);
                            return textNodes;
                        }

                        //   console.log(getTextNodesIn(document.body));

                        //doIt({'squeeze':false});

                        $('body').prepend(
                                $('<div id="socialtext-wrapper">')
                                        .append(
                                        $('<div id="socialtext-header"/>')
                                                .append('<div id="socialtext-reset"><a href="' + location.href + '">Dismiss</a></div>')
                                                .append($('<h1><a href="http://www.savepublishing.com">Save Publishing</a></h1>'))
                                                .append(
                                                $('<form>')
                                                        .append(
                                                        $('<span class="socialtext-checkbox"><input type="checkbox" id="socialtext-hide"/> hide untweetable text</span>')
                                                                .click(
                                                                function () {
                                                                    hide = hide ? false : true;
                                                                    $('#socialtext-hide').attr('checked', hide);
                                                                    if (hide) {
                                                                        $('img,.socialtext-hide').css({'display':'none'});


                                                                    }
                                                                    else {
                                                                        $('img,.socialtext-hide').css({'display':'inline'});
                                                                    }
                                                                }
                                                        )

                                                )
                                                        .append(
                                                        $('<span class="socialtext-checkbox"> <input type="checkbox" id="socialtext-shrink"/> shrink the shrinkable</span>')
                                                                .click(
                                                                function () {
                                                                    shrink = shrink ? false : true;
                                                                    $('#socialtext-shrink').attr('checked', shrink);
                                                                    if (shrink) {
                                                                        doIt({'squeeze':true});
                                                                    }
                                                                    else {
                                                                        doIt({'squeeze':false});

                                                                    }

                                                                }
                                                        )
                                                )

                                        )
                                                .append('<div id="slider-status">Found TK tweetable sentences under 118 characters or less.</div>')
                                                // TURN INTO FUNCTION PLEASE
                                                .append(
                                                $('<div id="socialtext-slider"/>')
                                                        .slider({ min:0,
                                                            max:140,
                                                            value:118,
                                                            slide:function (event, ui) {

                                                                var value = $('.socialtext-statement').lengthfilter(ui.value);

                                                                $('#slider-status').html("Found <b>" + value + "</b> statements of " + ui.value + " characters or less.");
                                                            }
                                                        })

                                        )
                                                .append($('<div id="socialtext-footer">From your fine friend <a href="http://twitter.com/ftrain">@ftrain</a> &middot; <a href="http://savepublishing.com/faq">Need help?</a> &middot; <a href="mailto:ford+savepublishing@ftrain.com?subject=[SavePublishing.com] My suggestions">Have suggestions?</a></div>')
                                        )
                                )
                        );

                    }
            );
        }
);
