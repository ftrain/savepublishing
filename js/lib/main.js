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
        document.getElementsByTagName("body")[0].appendChild(link);
    }
}

require(["jquery", "twidgets", "ui", "socialtext"], function ($) {

    $(function () {
        loadCss('https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/ui-lightness/jquery-ui.css');
        loadCss('http://www.savepublishing.com/css/bookmarklet.css');

        // Get rid of scripts

        window.onload = window.onunload = function() {};
        $('script').remove();


        // Fade stuff out
        $('img,object,iframe,script,ins').fadeTo('fast', 0.3);
        $('b,strong').replaceWith(function () {
            return '*' + $(this).text().trim() + '*';
        });
        $('i,em').replaceWith(function () {
            return '_' + $(this).text().trim() + '_';
        });
        $('span, a,abbr,cite,ins,del,q,s,code').replaceWith(function () {
            return $(this).contents();
        });
        var html = $('body').html();
        html = html.replace(/([^<>]+)<br[^>]?>\s*<br[^>]?>/gim, '<p>\$1</p>');
        html = html.replace(/([^<>]+)<br[^>]?>/gim, '<div class="socialtext-break">\$1</div>');
        $('body').html(html);
        $('body').score(400);
        $('.socialtext-scored').socialtext();
        $('body').header();


    });
});
