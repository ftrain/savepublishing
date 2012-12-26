# ## Methods added to the `Document` class

SECTION = 'document.coffee'

# Function to load CSS.
# TODO this may go if we don't need it. It seems that the 
HTMLDocument::loadCSS = (url) ->
    link = @createElement("link")
    link.type = "text/css";
    link.rel = "stylesheet";
    date =(new Date).getTime()
    link.href = "#{url}?bust=#{date}"
    if @createStyleSheet
       @createStyleSheet url
    else
       @getElementsByTagName("body")[0].appendChild(link)

