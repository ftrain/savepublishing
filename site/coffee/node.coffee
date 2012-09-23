
Node::isBlockLike = -> false;
Node::isText = -> @.nodeType is TEXT_NODE
Node::isTextual = -> (@.nodeType is ELEMENT_NODE) and (@.nodeName in textualElements)
Node::isTextish = -> @? and (@.isText() or @.isTextual())
Node::isElement = -> (@.nodeType is ELEMENT_NODE) and (@.nodeName not in textualElements)
Node::isUseful = -> not (@.nodeType is 8 or /^[\t\n\r ]+$/.test(@.data))
Node::empty = -> if @.isText() then @.nodeValue="" else $(@).html("")
Node::isBlockLike = -> $(@).css('display') in blocks or @.nodeName in blockElements