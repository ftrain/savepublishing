# ## Methods added to the `Node` class
SECTION = 'node.coffee'

# **Node::containsElements()**—checks if a given node contains elements
#
#  Returns boolean.    
Node::containsElements = -> true in (node.nodeType is ELEMENT_NODE for node in @childNodes)

# **Node::isGoodLink()**—TKTK
#
#  Returns boolean.
Node::isGoodLink    = ->
    (@nodeType is ELEMENT_NODE) \
    and (@nodeName is 'A')      \
    and (@isNavLike() is false) \
    and (@containsElements() is false)

# **Node::isTextish()**—is this raw text or an inline element like `<a>` or `<i>`?
#
#  Returns boolean.        
Node::isTextish     = -> @nodeType is TEXT_NODE \
    or (@nodeName in TEXTISH_ELEMENTS) \
    or @isGoodLink()

# **Node::isElementish()**—is this an element that isn't just for formatting?
# 
# Returns boolean.
Node::isElementish    = -> @nodeType is ELEMENT_NODE \
    and not(@nodeName in TEXTISH_ELEMENTS)

# **Node::isBR()**—is this a `<br>` or `<BR>` or `<br/>` or `<br      />` tag?
# 
# Returns boolean. 
Node::isBR         = -> @isElementish() and @nodeName is 'BR'

# ### Checking for irrelevant nodes
# **Node::isIrrelevant()**
# 
# Returns boolean. 
Node::isIrrelevant = -> @nodeName in IRRELEVANT_ELEMENTS

# **Node::isComment()**—is this a `<!--HTML/XML comment-->`?
# 
# Returns boolean. 
Node::isComment    = -> @nodeType is COMMENT_NODE

# **Node::isWhitespace()**—is this node all whitespace?
# 
# Returns boolean.
Node::isWhitespace = -> (@nodeType is TEXT_NODE) and (/^[\t\n\r ]+$/.test(@data))

# **Node::isNavLike()**—now we can check to see if an element is navlike or not.
# 
# Returns boolean. 
Node::isNavLike    = ->
    (@nodeName in NAV_CONTAINING_ELEMENTS) \
    and (@className.isNavLike() or @id.isNavLike())

# **Node::getAllChars()**—given a block of text, count the number of
# characters that appear within.
# 
# Returns integer.
Node::getAllChars  = ->
    JQ(@).text().length

# **Node::getLinkChars()**—given a block of text, count the number of
# characters that appear inside `<a>` tags.
#
# Note: Doesn't check if something is an href or an anchor link.
#
# Returns integer.
Node::getLinkChars = ->
    total = 0
    links = JQ(@).children('a')
    # Could be reduce
    for link in links
        length = JQ(link).text().length
        total += length
    total

# Check if a nav element is mostly link text or not
# 
# Returns boolean. 
Node::getLinkRatio    = ->
    link = @getLinkChars()
    if link > 0
        all  = @getAllChars()
        all/link
    
Node::isLinkish    = ->
    ratio = @getLinkRatio()
    MIN_LINK_RATIO > ratio
    
# Block things
# 
# Returns boolean. 
Node::isBlockLike  = -> JQ(@).css('display')? in BLOCKS or @nodeName in BLOCK_ELEMENTS

# Convert an element to text
Node::toText = ->
    if @nodeType is ELEMENT_NODE
        text = JQ(@).text()
        n = @nodeName

        rtext = text
        if n is 'A'
            rtext = "#{text}" 
        else if n in ['B', 'STRONG']
            rtext = "*#{text}*"
        else if n in ['EM', 'I']        
            rtext = "_#{text}_" 

        else if n is 'BR'
            rtext = "__BR__"

        rtext = rtext.clean()
        rtext = null if rtext.isWhitespace()
        rtext

    else
        @nodeValue

# **Node::isUseful()**—TKTK
# 
# Returns boolean.  
Node::isUseful     = ->
    debug """

\tnodename......#{@nodeName}
\tclassName.....#{@className}
\tid............#{@id}
\tnodetype......#{@nodeType}
\tisElement.....#{@nodeType is ELEMENT_NODE}
\tisIrrelevant..#{@isIrrelevant()}
\tisNavLike.....#{@isNavLike()}
\tisLinkish.....#{@isLinkish()}
\tisTextish.....#{@isTextish()}
\tisWhitespace..#{@isWhitespace()}
\tisComment.....#{@isComment()}
"""
    not(@isWhitespace() or @isComment() or @isIrrelevant() or @isLinkish() or @isGoodLink())
    

# **Node::emptyNode**—"empty out" the content in a node, leaving it
# within the DOM.
#
# When concatenating text nodes into single text node the issue
# remains: What to do with the remaining tags? If you simply strip
# them out, things can get weird very quickly as all sorts of
# interdependencies and code expectations, as well as stylesheet rules
# surface. It's better to leave the shell of the tag in place.
# 
# Returns boolean
Node::emptyNode = ->
    if (@nodeType is TEXT_NODE)
        @nodeValue=""
        true        
    else
        JQ(@).html("")
        true

# ### ``Node::unwrap()``
# 
# This is the main function for this bookmarklet. It is a recursive
# function that steps through the DOM hierarchy starting with the
# specified node object, and looks for the first "textish" child.
#
# What happens is 

Node::unwrap = ->
    texts    = []
    for node in @childNodes
        if node.isTextish()
            texts.push(node)
        else
            JQ(texts[0]).replaceWith(texts.merge())
            texts = []
            node.unwrap() if node.isUseful()
                
    JQ(texts[0]).replaceWith(texts.merge())
