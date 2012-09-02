require(["jquery", "jquery-ui", "socialtext"], function ($) {
    //the jquery.alpha.js and jquery.beta.js plugins have been loaded.

    function loadCss(url) {
        var link = document.createElement("link");
        link.type = "text/css";
        link.rel = "stylesheet";
        link.href = url;
        document.getElementsByTagName("head")[0].appendChild(link);
    }

    $(function () {

        loadCss('http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css');
        loadCss('http://www.savepublishing.com:8888/css/bookmarklet.css');


        //$('*').css({'background':'white', 'color':'silver'});

        $('a,abbr,cite,ins,del,q,s').replaceWith(function () {
            return $(this).contents();
        });
        $('b,strong').replaceWith(function () {
            return '*' + $(this).text().trim() + '*';
        });
        $('i,em').replaceWith(function () {
            return '_' + $(this).text().trim() + '_';
        });
        $('img,object,iframe').fadeTo('fast', 0.3);

        $('body *').contents().filter(function () {
            return (this.nodeType == 3) && this.nodeValue.match(/\S/);
        }).parent().socialtext();
        //wrap('<span class="socialtext">');

//        $('p,div:not(:has(div) :has(script)),h1,h2,h3,h4,h5,h6,pre').socialtext({'squeeze':false});

        $('body').prepend(
                $('<div id="socialtext-header">')
                        .append($('<form>')
                            .append($('<span>hide</span>')
                                .prepend($('<input type="checkbox" id="socialtext-hide"/>')
                                    .click(function() {
                                        $('')
                                    })
                                )
                            )
                        )
                        .append(
                            $('<div id="socialtext-slider"></div>')
                            .slider({ min:0,
                                max:140,
                                value:120,
                                slide:function (event, ui) {
                                    console.log(ui.value);
                                    $('.socialtext-statement').lengthfilter(ui.value);
                                }
                            })
                        )
                        .append($('<div id="socialtext-footer">Footer</div>'))
        );


    });
});
