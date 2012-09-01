
jQuery(document).ready(function ($) {
    $.noConflict(true);
    function order() {
        jQuery('p,div,blockquote,pre,h1,h2,h3,h4,h5,h6').socialtext({'commas':0, 'squeeze':true, 'disemvowel':true});
        jQuery('.socialtext-hide').css({'color':'silver'});
        jQuery('.socialtext-show').css({'color':'black', 'text-decoration':'underline'});

    }
    order();


    /* END CSS-only declarations for inserted elements. */


});

