require.config({
    urlArgs: "bust=" +  (new Date()).getTime(),
    paths:{
        'twidgets':'http://platform.twitter.com/widgets'
    }
});

require(["jquery", "jquery-ui", "twidgets", "socialtext"], function ($) {
            $(function () {


                        function loadCss(url) {
                            var link = document.createElement("link");
                            link.type = "text/css";
                            link.rel = "stylesheet";
                            link.href = url;
                            document.getElementsByTagName("head")[0].appendChild(link);
                        }

                        $.when(
                                loadCss('http://www.savepublishing.com/css/jquery-ui-1.8.23.custom.css'),
                                loadCss('http://www.savepublishing.com/css/bookmarklet.css'),
                                loadCss('http://www.savepublishing.com/css/jtweetsanywhere.css')
                        ).done(
                                function () {
                                    var credit = true;
                                    var hide = false;
                                    var shrink = false;

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

                                    $('body').prepend(
                                            $('<div id="socialtext-wrapper">')
                                                    .append(
                                                    $('<div id="socialtext-header"/>')
                                                            .append('<div id="socialtext-reset"><a href="' + location.href + '">[Reset]</a></div>')
                                                            .append($('<h1>Save Publishing</h1>'))
                                                            .append(
                                                            $('<form>')
                                                                    .append(
                                                                    $('<a href="#"><input type="checkbox" id="socialtext-hide"/> hide the untweetable</a>')
                                                                            .click(
                                                                            function () {
                                                                                hide = hide ? false : true;
                                                                                console.log("Clicked hide");
                                                                            }
                                                                    )
                                                            )
                                                                    .append(
                                                                    $('<a href="#"> <input type="checkbox" id="socialtext-shrink"/> shrink the shrinkable</a>')
                                                                            .click(
                                                                            function () {
                                                                                shrink = shrink ? false : true;
                                                                                console.log("Clicked shrink");
                                                                            }
                                                                    )
                                                            )
                                                                    .append(
                                                                    $('<a href="#"> <input type="checkbox" id="socialtext-promote"/> credit @savepub</a>')
                                                                            .click(
                                                                            function () {
                                                                                credit = credit ? false : true;
                                                                                console.log("Clicked add via");
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
                                                            .append($('<div id="socialtext-footer">From your fine friend <a href="http://twitter.com/ftrain">@ftrain</a></div>')
                                                    )
                                            )
                                    );

                                }
                        );
                    }
            );

        }
);
