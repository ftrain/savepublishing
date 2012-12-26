# ## Program execution
SECTION = 'run.coffee'

debug """"JQ" is assigned as:\n\t#{JQ}"""

# We're finally back in jQuery-land.
JQ(document).ready ->
    debug 'Document ready'
    debug 'Inserting CSS'

# - Load the CSS.
    document.loadCSS(JQUERY_UI_CSS);

# - Call the main "unwrap" function.
    document.body.unwrap()

# - After the DOM has been traversed and modified, update some styles.

    debug 'Adding CSS styles'
    JQ('.true').css {color:'red','text-decoration':'none', background:'white'}
    JQ('.false').css {color:'#bbbbbb','text-decoration':'none'}
    JQ('a').css {'text-decoration':'none'}
