# Methods added to the `Element` class
SECTION = 'element.coffee'

# Convert an element to text
Element::toString = ->
    text = JQ(@).text()
    n = @nodeName

    rtext = text
    rtext = "*#{text}*" if n in ['B', 'STRONG']
    rtext = "_#{text}_" if n in ['EM', 'I']
    rtext = "[#{text}]" if n in ['A']
    rtext = "<br/>" if n is 'BR'

    rtext
