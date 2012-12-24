# Extensions to the `Node` class
# SECTION = 'node.coffee'

# Basic things
Node::isText       = -> @nodeType is TEXT_NODE
Node::isElement    = -> @nodeType is ELEMENT_NODE and not(@nodeName in TEXTUAL_ELEMENTS)

# Textual things
Node::isTextual    = -> @isElement() and @nodeName in TEXTUAL_ELEMENTS
Node::isTextish    = -> @? and (@isText() or @isTextual())
Node::isBR         = -> @isElement() and @nodeName is 'BR'

# Irrelevant things
Node::isIrrelevant = -> @nodeName in IRRELEVANT_ELEMENTS
Node::isComment    = -> @nodeType is COMMENT_NODE
Node::isWhitespace = -> (@nodeType is TEXT_NODE) and (/^[\t\n\r ]+$/.test(@data))
Node::isNavLike    = -> (@nodeName in NAV_CONTAINING_ELEMENTS) and (@className.isNavLike() or @id.isNavLike())

# Text things that check for irrelevant things
Node::getLinkChars = ->
    total = 0
    links = JQ(@).children('a')    
    for link in links
        length = JQ(link).text().length
        total += length
    if total then total else 0
    
Node::getAllChars  = ->
    l = JQ(@).text().length
    debug "allchars: #{l}, #{JQ(@).text()}"
    l
    
Node::isLinkish    = ->
     @isNavLike() and (NAV_RATIO > (@getAllChars()/@getLinkChars()))

# Block things
Node::isBlockLike  = -> JQ(@).css('display')? in BLOCKS or @nodeName in BLOCK_ELEMENTS

Node::isUseful     = ->
    debug """
\tnodename:     #{@nodeName}
\tnodetype:     #{@nodeType}
\tisElement:    #{@nodeType is ELEMENT_NODE}
\tisIrrelevant: #{@isIrrelevant()}
\tisNavLike:    #{@isNavLike()}
\tisLinkish:    #{@isLinkish()}
\tisTextish:    #{@isTextish()}
\tisWhitespace: #{@isWhitespace()}
\tisComment:    #{@isComment()}
"""        
    not(@isIrrelevant() or @isWhitespace() or @isComment() or @isLinkish())

Node::empty         = -> if (@? and @isText()) then @.nodeValue="" else JQ(@).html("")

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
    debug """Unwrapping: #{@}"""
    if @isTextish()
        JQ(@).replaceWith(JQ('<span class="socialtext-set"/>') \
            .append(("""<span class="socialtext"><a class="#{statement.length < 120}" href="https://twitter.com/intent/tweet?text=#{statement.clean()} #{location.href}">#{statement.clean()}</a></span>""" \
                for statement in @findStatements()).join("")))

    else if @isUseful()
        node.unwrap() for node in @childNodes
