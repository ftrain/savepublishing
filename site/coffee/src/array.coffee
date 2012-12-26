# ## Methods added to the `Window` class
SECTION = "array.coffee"

# **Array::merge()**
# 
Array::merge = ->
    [first, rest...] = @

    strings = (node.toString() for node in @)
    # Empty everything out
    node.emptyNode() for node in @
    text = strings.join(" ")
    spans = JQ("""<span class="socialtext-set"/>""")
    for tweet in text.getStatements()
        spans.append(tweet.enTweeten())
    JQ(first).replaceWith(spans)
    []
