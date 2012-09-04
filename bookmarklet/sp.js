javascript:(function () {
    var u = 'http://www.savepublishing.com/';
    var s = document.createElement('script');
    s.type = 'text/javascript';
    s.src = u+'js/lib/require-jquery.js';
    s.setAttribute('data-main', u+'js/lib/main.js');
    document.getElementsByTagName('head')[0].appendChild(s)
})();


javascript:(function () {
    var u = 'http://10.0.2.2';
    var s = document.createElement('script');
    s.type = 'text/javascript';
    s.src = u+'/js/lib/require-jquery.js';
    s.setAttribute('data-main', u+'/js/lib/main.js');
    document.getElementsByTagName('head')[0].appendChild(s)
})();
