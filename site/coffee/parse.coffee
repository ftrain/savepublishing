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



Element::getWrapped = ->
    text = $(@).text()
    n = @.nodeName
    console.log n

    if n is 'B' or n is 'STRONG'
        "*#{text}*"

    else if n is 'EM' or n is 'I'
        "_#{text}_"

    text
        

Text::append = (str) -> 
    @.nodeValue = @.nodeValue + str;

Text::isBlockLike = -> false;

Object::isBlockLike = -> false;

Array::concatenate = ->
    if this.length > 0
        """<span class="socialtext">[#{this.join(" ")}]</span>"""

Node::isTextual = -> (@.nodeType is ELEMENT_NODE and @.nodeName in textuals) or @.nodeType is TEXT_NODE

Node::isIgnorable = ->
    @.nodeType is 8 or @ is undefined or /^[\t\n\r ]+$/.test(@.data)

 
wrap = (text) ->
    """<span class="socialtext-text">#{text}</span>"""

$.fn.dress = -> @.addClass("sociatext-text")


# Treewalker
walk = (el, textnode) ->
    console.log(textnode)
    textnode ?= textnode
    eltype = el?.nodeType

    if el.isIgnorable()
        
    else if eltype is TEXT_NODE
        console.log(textnode)
        if textnode?
            textnode.nodeValue = "#{textnode.nodeValue}[[[#{el.nodeValue}]]]"
            el.nodeValue=""
        else
            console.log(textnode)
            textnode = el
            console.log(textnode)

    else if eltype is ELEMENT_NODE and el.isTextual()
        txt = $(el).text()
        el.nodeValue = "TEXTUAL NODE: [[[#{txt}]]]"        
                
    else if eltype is ELEMENT_NODE
        console.log(textnode)
        $(el).dress()

    walk(node, textnode) for node in el.childNodes
        
# Do it!
$ -> 
    walk(document.body)
    $('.socialtext-text').css({display:'block',border:'1 px dotted red'})






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
