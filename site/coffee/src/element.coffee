Element::toText = ->
    text = JQ(@).text()
    n = @.nodeName
    
    if n is 'B' or n is 'STRONG'
        "*#{text}*"

    else if n is 'EM' or n is 'I'
        "_#{text}_"

    text
