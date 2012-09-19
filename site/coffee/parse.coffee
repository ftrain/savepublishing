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

Element::isBlockLike = ->
    disp = @.display()
    blocks.indexOf(disp) != -1

textuals = ['SPAN','A','EM','B','STRONG','I']
Element::isTextual = ->
    name = @.nodeName
    textuals.indexOf(name) != -1

Element::getWrapper = (text) ->
    n = @.nodeName

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
    
# Treewalker
walk = (el) ->
    if el? and el.nodeType?

        if el.nodeType is ELEMENT_NODE and el.isBlockLike()
            kids = el.childNodes
            nodes = ({type:node.nodeType, node:node} for node in kids when not node.isBlockLike())
            prev=-1;
            texts = []
            
            for n in nodes
                do (n) ->

                    if n.type is ELEMENT_NODE and n.node.isTextual()
                        text = n.node.getWrapper $(n.node).text()
                        texts.push(text)
                        $(n.node).remove()

                    else if n.type is TEXT_NODE
                        text = n.node.nodeValue.clean()
                        texts.push(text)
                        $(n.node).remove()

                    justChanged = prev isnt -1 and nodes[prev].type is TEXT_NODE
                    onlyOne = prev is -1 and nodes.length is 1
                    lastOne = prev is nodes.length - 1

                    if justChanged or onlyOne or lastOne
                        text = texts.concatenate()
                        

                            if text
                            console.log(text)
                        texts = []
                prev++

        walk(kid) for kid in kids when kid.isBlockLike()
    

        


# Do it!
$ -> 
    walk(document.body)






# joined = texts.join(' ')
# text = "<span class=\"socialtext\">#{joined}</span>"
# $(text).insertBefore($(el));
