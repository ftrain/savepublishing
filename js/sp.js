var dbg = (typeof console !== 'undefined') ? function(s) {
    console.log("SavePublishing: " + s);
} : function() {};

/*
 * SavePublishing
 * Website: http://www.savepublishing.com
 * Source:  http://github.com/savepublishing
 *
 * "Savepublishing" is a trademark of Unscroll Inc. and may not be used without permission.
 *
 * Copyright (c) 2012 Paul Ford
 *
**/

jQuery(document).ready(function ($) {

    var global_max = 140; // The maximum length of a tweet
    var global_min = 10; // The minimum length of a tweet
    var global_sentence_length = 120;
    var global_shortened = false;
    var global_disemvoweled = false;

    function keys(o) {
        var keys = [];
        for (var i in o) if (o.hasOwnProperty(i)) {
            keys.push(i);
        }
        return keys;
    }


    /* BEGIN Replacement routines. */

    /* Lowercase terms that match at word boundaries */


    /* Take all of the above and turn them into a single
     * regexp. And now you have len(keys) problems! */

    /* Compile that regexp. */

    /* END Replacement routines. */

    /* Here we go... */

    $('p').each(function () {
        elToSentences($(this))
    });

    /* And we're done... */

    function elToSentences(el) {

        /* we just give up on bold and formatting right now
         * and go for sentences. */
        var text = $(el).text().trim();
        texxt = text + "|";
        // var reg = /([^\.]+\.)'/;
        var sentences_in = text.split(".");
        var sentences_now = [];
        statements = []
        for (var i = 0; i < sentences_in.length; i++) {
            var h = {}
            var s = sentences_in[i];
            var shrank = shrink(s);
            h['sentence'] = s;
            h['length'] = s.length;
            if (h['length'] > 1) {
                h['shortened'] = shrank;
                h['shortenedlength'] = shrank.length;

                var arr = keys(h);
                var atts = [];

                for (key in arr) {
                    var k = arr[key];
                    atts.push(k + '="' + h[k] + '"');
                }

                sentences_now.push('<span class="sentence" '
                        + atts.join(" ")
                        + '>'
                        + h['sentence']
                        + '.</span>');
            }
        }

        var sentences_out = sentences_now.join('');
        el.html(sentences_out);
    }

    function pickSentences(char_count) {

        var count = 0;


        $('.sentence').each(function () {

            var len = parseInt($(this).attr('shortenedlength'));

            if (len <= char_count) {
                count++;
                $(this).css({'display':'inline', 'color':'black'});
            }

            else if ($('#hide').is(':checked')) {
                $(this).css({'display':'none', 'color':'silver'});
            }

            else {
                $(this).css({'display':'inline', 'color':'silver'});
            }
        });
        var plural = (count == 1) ? '' : 's';
        var statement = 'Found <b>' + count + '</b> sentence' + plural + ' of fewer than <b>' + char_count + '</b> characters'
        return statement;
    }

    /* I'm a global var short and stout here is my handle here is my spout. */

    var untweetable = $('<span><input type="checkbox" id="hide"/>hide the untweetable</span>')
                .click(function () {
                    $('.sentence').filter(function (index) {
                        $(this).attr();
                    });
                    $('#info').html(pickSentences(global_sentence_length));
                });

    var shrunk = false;

    var shrinkable =
            $('<span>...<input type="checkbox" id="shrink"/>shrink the shrinkable</span>')
                    .click(function () {
                        shrunk = shrunk ? false : true;
                        console.log(shrunk);
                        $('.sentence').each(function () {
                            if (shrunk) {
                                $(this).html($(this).attr('shortened'));
                            }
                            else {
                                $(this).html($(this).attr('sentence'));
                            }

                        });
                    });

    var disemvowel =
            $('<span>...<input type="checkbox" id="disemvowel"/>disemvowel</span>')
                    .click(function () {
                    });

    var slider = $("<div id='slider'></div>")
            .slider(
            {
                min:global_min,
                max:global_max,
                step:1,
                animate:true,
                value:120,
                slide:function (event, ui) {
                    global_sentence_length = ui.value;
                    $('#info').html(pickSentences(global_sentence_length));
                }
            }
    );


    var sliderBox = $('<div id="sliderbox"/>')
            .append('<div id="ta">save publishing</div><br/>')
            .append(untweetable)
            .append(shrinkable)
            .append(disemvowel)
            .append('<div id="info">120 characters</div>')
            .append(slider)
            .append($('<div id="credit">From your fine friend <a href="http://twitter.com/ftrain">@ftrain</a></div>'));


    $('body').prepend(sliderBox);

    $('#info').html(pickSentences(120));


    /* END CSS-only declarations for inserted elements. */


});
