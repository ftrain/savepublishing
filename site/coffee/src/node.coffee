Node::isText      = -> @nodeType is TEXT_NODE
Node::isElement   = -> @nodeType is ELEMENT_NODE
Node::isIgnorable = -> @isElement and @nodeName in IGNORABLE_ELEMENTS
Node::isTextual   = -> @isElement and @nodeName in TEXTUAL_ELEMENTS
Node::isElement   = -> @isElement and not @nodeName in TEXTUAL_ELEMENTS
Node::isTextish   = -> @? and (@isText() or @isTextual())
Node::isBR        = -> @isElement and @nodeName is 'BR'
Node::isUseful    = -> not (@nodeType is 8 or /^[\t\n\r ]+$/.test(@data))
Node::isBlockLike = -> JQ(@).css('display')? in BLOCKS or @nodeName in BLOCK_ELEMENTS
Node::isLinkish   = ->
    if @? and (@nodeName in NAV_CONTAINING_ELEMENTS)
        as = JQ(@).children('a')
        if as.length > 0
            as_len = as.text().length
            node_len = JQ(@).text().length
            rat = node_len/as_len
            return NAV_RATIO > rat
    false

Node::empty       = -> if (@? and @isText()) then @.nodeValue="" else JQ(@).html("")

Node::concatenateTextDestructively = (array) ->
    """
    Check for relevance.
    """
    array ?= []
    if @isTextish()
        if @isUseful()
            array.push(JQ(@).text())
        @empty()
        @nextSibling?.concatenateTextDestructively(array)
    String(array.join(""))

Node::findStatements = ->
    @concatenateTextDestructively().extractStatements()
        
Node::unwrap = ->
    # and not(@previousSibling?.isTextish())
    if @isTextish() and @isUseful() and not (@isIgnorable() or @isLinkish()) # and not (@isBlockLike())
        JQ(@).replaceWith(JQ('<span class="socialtext-set"/>') \
            .append(("""<span class="socialtext"><a class="#{statement.length < 120}" href="https://twitter.com/intent/tweet?text=#{statement.clean()} #{location.href}">#{statement.clean()}</a></span>""" \
                for statement in @findStatements()).join("")))

    else
        node.unwrap() for node in @childNodes
