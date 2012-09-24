Node::isBlockLike = -> false;

Node::isText = -> @nodeType is TEXT_NODE

Node::isTextual = -> (@nodeType is ELEMENT_NODE) and (@nodeName in TEXTUAL_ELEMENTS)

Node::isTextish = -> @? and (@isText() or @isTextual())

Node::isElement = -> (@nodeType is ELEMENT_NODE) and (@nodeName not in TEXTUAL_ELEMENTS)

Node::isBR = -> (@nodeType is ELEMENT_NODE) and (@nodeName is 'BR')

Node::isUseful = -> not (@nodeType is 8 or /^[\t\n\r ]+$/.test(@data))

Node::empty = -> if @isText() then @.nodeValue="" else $(@).html("")

Node::isBlockLike = -> $(@).css('display') in blocks or @nodeName in BLOCK_ELEMENTS

Node::concatenateTextDestructively = (array) ->
    array ?= []
    if @isTextish()
        if @isUseful()
            array.push($(@).text())
        @empty()
        @nextSibling?.concatenateTextDestructively(array)
    String(array.join(""))

Node::getStatements = ->
    @concatenateTextDestructively().getStatements()
    
Node::unwrap = ->
    if @isTextish() and @isUseful() and not(@previousSibling?.isTextish())
        $(@).replaceWith($('<span class="socialtext-set"/>') \
            .append(("""<span class="socialtext">#{statement}#</span>""" \
                for statement in @getStatements()).join("")))

    else
        node.unwrap() for node in @childNodes
