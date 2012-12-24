= ->
    console.log 'SavePublishing.com bookmarklet'
    insert = (jsfile) ->
        s = document.createElement 'script'
        s.type = 'text/javascript'
        s.src = jsfile
        h.appendChild s

    u = 'http://www.savepublishing.com/js/lib/'
    h = document.getElementsByTagName('body')[0]
    x """#{u}jquery.js"""
    x """#{u}main.js"""
       
