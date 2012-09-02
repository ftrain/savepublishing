javascript:(function () {
            console.log("called");
            var s = document.createElement('script');
            s.type = 'text/javascript';
            s.src = 'http://www.savepublishing.com:8888/js/lib/require-jquery.js';
            s.setAttribute('data-main', 'http://www.savepublishing.com:8888/js/lib/main.js');
            document.getElementsByTagName("head")[0].appendChild(s)

        })();
