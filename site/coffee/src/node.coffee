SECTION = 'node.coffee'

# Basic things
Node::isText       = -> @nodeType is TEXT_NODE
Node::isElement    = -> @nodeType is ELEMENT_NODE and not(@nodeName in TEXTUAL_ELEMENTS)

# Textual things
Node::isTextual    = -> @isElement() and @nodeName in TEXTUAL_ELEMENTS
Node::isTextish    = -> @? and (@isText() or @isTextual())
Node::isBR         = -> @isElement() and @nodeName is 'BR'

# Irrelevant things
Node::isIrrelevant = -> @nodeName in IRRELEVANT_ELEMENTS
Node::isComment    = -> @nodeType is 8
Node::isWhitespace = -> /^[\t\n\r ]+$/.test(@data)
Node::isUseful     = -> not(@isWhitespace) or not(@isComment)
Node::isNavLike    = -> @isElement() and @nodeName in NAV_CONTAINING_ELEMENTS and @className.isNavClass()

# Text things that check for irrelevant things
Node::getLinkChars = -> JQ(@).children('a').text().length
Node::getAllChars  = ->  JQ(@).text().length
Node::isLinkish    = -> if @isNavLike then NAV_RATIO > (@getAllChars())/(@getLinkChars())

# Block things
Node::isBlockLike  = -> JQ(@).css('display')? in BLOCKS or @nodeName in BLOCK_ELEMENTS

Node::isIgnorable = ->
    debug """nodename:     #{@nodeName}"""
    debug """nodetype:     #{@nodeType}"""    
    debug """isElement:     #{@nodeType is ELEMENT_NODE}"""    
    debug """isIrrelevant: #{@isIrrelevant()}"""
    debug """isNavLike:    #{@isNavLike()}"""
    debug """isLinkish:    #{@isLinkish()}"""
    result = @isIrrelevant() or @isNavLike() or @isLinkish()
    if result
        debug """#{@nodeName} ******THIS IS AN IGNORABLE ELEMENT***********************************"""
    @isIrrelevant() or @isNavLike() or @isLinkish()

    
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
    # and not (@isBlockLike())
    # and not (@isIgnorable() or @isLinkish())
    #
    debug "----------------------------------------"
    debug """Unwrapping: #{@}, #{@.data}"""
    if (@isTextish() and @isUseful())
        JQ(@).replaceWith(JQ('<span class="socialtext-set"/>') \
            .append(("""<span class="socialtext"><a class="#{statement.length < 120}" href="https://twitter.com/intent/tweet?text=#{statement.clean()} #{location.href}">#{statement.clean()}</a></span>""" \
                for statement in @findStatements()).join("")))

    else if not(@isIgnorable())
        node.unwrap() for node in @childNodes
