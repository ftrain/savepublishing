require.config({
    urlArgs:"bust=" + (new Date()).getTime(),
    paths:{
        'twidgets':'http://platform.twitter.com/widgets'
    }
});

function loadCss(url) {
    var link = document.createElement("link");
    link.type = "text/css";
    link.rel = "stylesheet";
    link.href = url + '?bust=' + (new Date()).getTime()
    document.getElementsByTagName("head")[0].appendChild(link);
}

require(["jquery", "twidgets", "jquery-ui", "socialtext"], function ($) {
            $(function () {


                        loadCss('http://www.savepublishing.com/css/jquery-ui-1.8.23.custom.css');
                        loadCss('http://www.savepublishing.com/css/bookmarklet.css');

                        var credit = false;
                        var hide = false;
                        var shrink = false;


                        $('img,object,iframe,script,ins').fadeTo('fast', 0.3);


                        /*
                        $('b,strong').replaceWith(function () {

                                            return '*' + $(this).text().trim() + '*';
                                        });
                                        $('i,em').replaceWith(function () {
                                            return '_' + $(this).text().trim() + '_';
                                        });
                                        $('a,abbr,cite,ins,del,q,s,code').replaceWith(function () {
                                            return $(this).contents();
                                        });

 */



                        $('br').parent().each(function () {
                            var html = $(this).html();
                            html = html.replace(/([^>]+)<br[^>]?>\s?<br[^>]?>/gi, '<p>\$1</p>');
                            html = html.replace(/([^>]+)<br[^>]?>/gi, '<div class="socialtext-break">\$1</div>');
                            html = html.replace(/^(.+)$/gi, '<div class="socialtext-break">\$1</div>');
                            $(this).html(html);
                        });
                        //body *:not(img,object,iframe,script,ins)
                        $('span,h1,h2,h3,h4,h5,h6,p,blockquote,li,pre,td')
                                .contents()
                                .filter(function () {
                                    return (this.nodeType == 3) && this.nodeValue.match(/\S/);
                                })
                                .parent()
                                .socialtext();


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

                                                                }
                                                        )
                                                )

                                        )
                                                .append(
                                                $('<div id="socialtext-slider"/>')
                                                        .slider({ min:0,
                                                            max:140,
                                                            value:120,
                                                            slide:function (event, ui) {
                                                                console.log(ui.value);
                                                                $('.socialtext-statement').lengthfilter(ui.value);
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
