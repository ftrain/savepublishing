# ** Program execution section
SECTION = 'run.coffee'

debug """"JQ" is assigned as:\n\t#{JQ}"""

JQ(document).ready ->
    debug 'Document ready'
    debug 'Inserting CSS'
    document.loadCSS(JQUERY_UI_CSS);
    
    document.body.unwrap()

    debug 'Adding CSS styles'
    JQ('.true').css {color:'red','text-decoration':'none', background:'white'}
    JQ('.false').css {color:'#bbbbbb','text-decoration':'none'}
    JQ('a').css {'text-decoration':'none'}
