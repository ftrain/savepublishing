# Tree walker
# 
TEXT_NODE = 3
ELEMENT_NODE = 1

# Extensions to String
console.log 'called parse.js'

String::shrink = ->
    @

entities = /[&\"><]/g;
String::entities = ->
    replace = (char) -> 
        switch char
            when '&' then '&amp;'
            when '"' then '&quot;'
            when '>' then '&gt;'
            when '<' then '&lt;'
    @.replace(entities, (a) -> replace(a))

Node::isEmpty = ->
    if @.isText()
        @.nodeValue.clean().length is 0
    else
        false

String::clean = ->
    str = @.replace(/\s+/g, ' ').replace(/\n+/g, ' ')
    str = str.replace(/^\s*$/,'')
    str = str.entities()
    str


# Identify block elements

Element::display = -> $(@).css('display');

blocks = ['block', 'inline-block', 'table-cell', 'table-caption', 'list-item', 'none']
blockEls = ['H1','H2','H3','H4','H5','H6', 'BODY', 'BR']
textuals = ['SPAN','A','EM','B','STRONG','I']

Element::isBlockLike = -> @.display() in blocks or @.nodeName in blockEls



Element::toText = ->
    text = $(@).text()
    n = @.nodeName
    
    if n is 'B' or n is 'STRONG'
        "*#{text}*"

    else if n is 'EM' or n is 'I'
        "_#{text}_"

    text
        

Object::isBlockLike = -> false;

Array::concatenate = ->
    if this.length > 0
        """<span class="socialtext">[#{this.join(" ")}]</span>"""

Node::append = (str) -> 
    @.nodeValue = @.nodeValue + str;
Node::isBlockLike = -> false;
Node::isText = -> @.nodeType is TEXT_NODE
Node::isTextual = -> (@.nodeType is ELEMENT_NODE) and (@.nodeName in textuals)
Node::isTextish = -> @.isText or @.isTextual
Node::isElement = -> (@.nodeType is ELEMENT_NODE) and (@.nodeName not in textuals)
Node::isIgnorable = ->
    not @ or @.nodeType is 8 or /^[\t\n\r ]+$/.test(@.data)

                
wrap = (text) ->
    """<span class="socialtext-text">#{text}</span>"""

$.fn.dress = -> @.addClass("socialtext-text")

textNodes = (node, array) ->
    if node?
        nextIsTextish = node.nextSibling?.isTextish()
        if node.isTextish()
            array.push($(node).text())
        if nextIsTextish
            textNodes(node.nextSibling, array)
            
        array.join("")
    
unwrap = (node) ->

    seentext = false
    
    if node.isElement()
        unwrap(node) for node in node.childNodes

    else if node.isTextish()
        prev = node.previousSibling
        if not prev and not (prev.isText() or prev.isTextual())
            console.log textNodes(node, [])
        seentext = true
            
        
    

$ -> unwrap(document.body)
                
# Do it!
#$ -> 
#    walk(document.body)
#    $('.socialtext-text').css({display:'block',border:'1 px dotted red'})

#     ignore = not el or el.isIgnorable()
#     text = el?.isText()
#     textual = el?.isTextual()
#     element = el?.isElement()
#     console.log el?.nodeType, el
    
#     if ignore

#     else if text
#         parent?.removeChild(el)
        
#     else if textual
#         parent?.removeChild(el)    

#     else if element
#         parent?.removeChild(el)        
# #        $(el).css({color:'red'})
#        for node in el.childNodes
#            walk(node)
#           do (node) ->
# ntype = node?.nodeType
# if node? and node.isIgnorable()
                # else if ntype is TEXT_NODE
                #     text = "#{text}#{$(node).text()}"
                #     $(node).remove()
                # else if node? and node.isTextual()
                #     text = "#{text}#{node.getWrapped}"
                #     $(node).remove()
                # else if node?
                #     $(node).css({color:'blue'})
                #     if text.length > 0
                #         $(wrap text).insertBefore(node)
                #         text=""


# # Treewalker
# walk = (el, parent, count, lastText) ->

#     if el.isText() and el.isEmpty()
#         parent.removeChild(el)

#     else if el.isText()
#         lastText = $(el).wrap("<span class="socialtext-text"></span>")

#     else if el.isTextual()
#         text = $(el).text()
#         if lastText
#             parent.removeChild(el)
#             lastText.
        
#     else if el.isElement()
#         i = 0
#         walk(node, el, i++, lastText) for node in el.childNodes
