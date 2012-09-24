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
