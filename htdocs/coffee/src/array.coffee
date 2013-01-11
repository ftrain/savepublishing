# ## Methods added to the `Window` class
SECTION = "array.coffee"

# **Array::merge()**—an array of `node`s.
# 
Array::merge = ->
    debug """Merging text array..."""
    strings = (node.toText() for node in @)
    # Empty everything out
    node.emptyNode() for node in @
    text = strings.join("")
    debug """Full merged string is #{string}"""
    spans = JQ("""<span class="socialtext-set"></span>""")
    for tweet in text.getStatements()
        debug """This tweet is apparently: #{tweet}"""
        t = tweet.enTweeten()
        spans.append(t)
    spans
