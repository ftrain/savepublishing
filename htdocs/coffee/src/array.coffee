# ## Methods added to the `Window` class
SECTION = "array.coffee"

# **Array::merge()**—an array of `node`s.
# 
Array::merge = ->
    strings = (node.toText() for node in @)
    # Empty everything out
    node.emptyNode() for node in @
    text = strings.join("")
    spans = JQ("""<span class="socialtext-set"></span>""")
    for tweet in text.getStatements()
        t = tweet.enTweeten()
        spans.append(t)
    spans
