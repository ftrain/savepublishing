console.log "walker.coffee"

Node::concatenatedText = (array) ->
    if @isTextish()
        if @isUseful()            
            array.push($(@).text())
        @empty()
        @nextSibling?.concatenatedText(array)
    array.join("")


Node::unwrap = ->
    if @isElement()
        @score
        node.unwrap() for node in @childNodes

    else if @isTextish()
        unless @previousSibling?.isTextish()
            @nodeValue = @concatenatedText([])
            @


unwrap = (node) ->
    textNodes = (node, array) ->
        if node?
            if node.isTextish()
                if node.isUseful()            
                    array.push($(node).text())
                node.empty()
                textNodes(node.nextSibling, array)
        array.join("")

    if node.isElement()
        @score
        unwrap(node) for node in node.childNodes

    else if node.isTextish()
        unless node.previousSibling?.isTextish()
            text = textNodes(node, [])
            node.nodeValue = text
