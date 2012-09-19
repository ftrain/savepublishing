javascript:(function () {
    var u = 'http://www.savepublishing.com/';
    var s = document.createElement('script');
    s.type = 'text/javascript';
    s.src = u + 'js/lib/require-jquery.js';
    s.setAttribute('data-main', u + 'js/lib/main.js');
    document.getElementsByTagName('head')[0].appendChild(s)
})();

javascript:(function () {
    console.log('bookmarklet v2');
    var u = 'http://www.savepublishing.com/js/lib/';
    var h = document.getElementsByTagName('body')[0];

    function x(jsfile) {
        var s = document.createElement('script');
        s.type = 'text/javascript';
        s.src = jsfile;
        h.appendChild(s);
    }

    x(u+'jquery.js');
    x('http://platform.twitter.com/widgets.js');
    x('http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js');
    x(u+'socialtext.js');
    x(u+'main.js');
})();


javascript:(function () {
    var u = 'http://10.0.2.2';
    var s = document.createElement('script');
    s.type = 'text/javascript';
    s.src = u + '/js/lib/require-jquery.js';
    s.setAttribute('data-main', u + '/js/lib/main.js');
    document.getElementsByTagName('head')[0].appendChild(s)
})();
