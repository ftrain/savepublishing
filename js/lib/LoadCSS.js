function loadCss(url) {
    /**
     *
     * @type {HTMLElement}
     *
     * Inserts stylesheet into source.
     */
    var link = document.createElement("link");
    link.type = "text/css";
    link.rel = "stylesheet";
    link.href = url + '?bust=' + (new Date()).getTime()
    if (document.createStyleSheet) {
        document.createStyleSheet(url);
    }
    else {
        document.getElementsByTagName("body")[0].appendChild(link);
    }
}
