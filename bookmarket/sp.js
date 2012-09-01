javascript:(function (e, a, g, h, f, c, b, d) {
    if (!(f = e.jQuery) || g > f.fn.jquery || h(f)) {
        c = a.createElement("script");
        c.type = "text/javascript";
        c.src = "http://ajax.googleapis.com/ajax/libs/jquery/" + g + "/jquery.min.js";
        c.onload = c.onreadystatechange = function () {
            if (!b && (!(d = this.readyState) || d == "loaded" || d == "complete")) {
                h((f = e.jQuery).noConflict(1), b = 1);
                f(c).remove()
            }
        };
        a.documentElement.childNodes[0].appendChild(c);

        x = a.createElement("script");
        x.type = "text/javascript";
        x.src = "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js";
        a.documentElement.childNodes[0].appendChild(x);

        x = a.createElement("link");
        x.type = "text/css";
        x.rel = "stylesheet";
        x.href = "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css";
        a.documentElement.childNodes[0].appendChild(x);

        x = a.createElement("script");
        x.type = "text/javascript";
        x.src = "../js/lib/socialtext/socialtext.js";
        a.documentElement.childNodes[0].appendChild(x);
    }
})(window, document, "1.3.2", function ($, L) {
    jQuery(document).ready(function ($) {
        jQuery('p,div,blockquote,pre,h1,h2,h3,h4,h5,h6').socialtext({'commas':0, 'squeeze':true, 'disemvowel':true});
        jQuery('.socialtext-hide').css({'color':'silver'});
        jQuery('.socialtext-show').css({'color':'black', 'text-decoration':'underline'});
    })
});