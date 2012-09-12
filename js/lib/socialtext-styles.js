(function ($) {
    $.fn.applySocialtextStyles = function () {

        $('body')
                .css({
                    'margin-top':'225px'
                });

        $('#socialtext-wrapper')
                .css({'text-align':'center',
                    'width':'100%',
                    'position':'fixed',
                    'opacity':'1',
                    'line-height':'200%',
                    'z-index':'100000',
                    'font-size':'15px',
                    'background-color':'white',
                    'top':'210px'
                });

        $('#socialtext-header')
                .css({
                    'color':'black',
                    'background-color':'white',
                    'width':'600px',
                    'margin':'-210px auto 50px auto',
                    'font-family':"'Gill Sans','Helvetica Neue', 'Arial'",
                    'font-size':'15px',
                    'height':'150px',
                    'padding':'1em 1em 1em 1em',
                    'opacity':'.95',

                    'border':'10px solid #8bc',
                    'border-radius':'1em',
                    '-webkit-box-shadow':'11px 11px 19px rgba(50, 50, 50, 0.3)',
                    '-moz-box-shadow':'11px 11px 19px rgba(50, 50, 50, 0.3)',
                    'box-shadow':'11px 11px 19px rgba(50, 50, 50, 0.3)'
                });

        $('.socialtext-checkbox')
                .css({
                    'cursor':'pointer'
                });

        $('.socialtext-checkbox:input')
                .css({
                    'cursor':'pointer'
                });

        $('#socialtext-reset')
                .css({
                    'text-align':'right',
                    'margin':'-1em -.5em 0 0'

                });

        $('#socialtext-wrapper')
                .css({
                    'color':'#ccc',
                    'text-decoration':'none'
                });

        $('#socialtext-slider')
                .css({
                    'width':'100%',
                    '-webkit-box-shadow':'2px 5px 10px rgba(50, 50, 50, 0.3)',
                    '-moz-box-shadow':'2px 2px 10px rgba(50, 50, 50, 0.3)',
                    'box-shadow':'2px 2px 10px rgba(50, 50, 50, 0.3)'

                });

        $('#socialtext-header h1')
                .css({
                    'font-size':'20px',
                    'text-transform':'uppercase',
                    'letter-spacing':'1em',
                    'font-weight':'100',
                    'margin-top':'-10px',
                    'text-align':'center',
                    'color':'#678c9a'
                });

        $('#socialtext-footer')
                .css({
                    'font-size':'80%',
                    'border-top':'1px dotted #bbb',
                    'padding-top':'3px'
                });

        $('a.socialtext-show')
                .css({
                    'background':'yellow',
                    'color':'#0000cd',
                    'margin-right':'.5em',
                    'border-bottom':'1px solid white',
                    'text-decoration':'none'
                });

        $('a.socialtext-show:after')
                .css({
                    'content':'"\2605"'
                });

        $('a.socialtext-hide')
                .css({
                    'text-decoration':'none',
                    'background':'white',
                    'color':'silver',
                    'margin-right':'.5em'
                });

        $('.socialtext-scored')
                .css({
                    'color':'#dc143c'
                });
    }
})(jQuery);