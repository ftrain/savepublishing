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
        unwrap(node) for node in node.childNodes

    else if node.isTextish()
        unless node.previousSibling?.isTextish()
            text = textNodes(node, [])
            node.nodeValue = text
