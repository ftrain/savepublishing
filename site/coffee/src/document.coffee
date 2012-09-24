HTMLDocument::loadCSS = (url) ->
    link = @createElement("link")
    link.type = "text/css";
    link.rel = "stylesheet";
    link.href = "#{url}?bust=#{new Date() getTime()}"
    if @createStyleSheet
       @createStyleSheet url
    else
       @getElementsByTagName("body")[0].appendChild(link)

