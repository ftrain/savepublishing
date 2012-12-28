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
    JQ('.true').css {color:'#F00','border-bottom':'none','text-decoration':'none', background:'white'}
    JQ('.true') \
        .mouseenter(-> JQ(@).css {background:'#FAA'}) \
        .mouseleave(-> JQ(@).css {background:'white'})
        

    JQ('.false').css {color:'#bbbbbb','border-bottom':'none','text-decoration':'none'}

    JQ('a').css {'text-decoration':'none'}

# - Add the toolbar
# 
    styles =
# Positioning
        'z-index':9999999
        'position':'fixed'
        'top':'10px'
        'height':'120px'
        'line-height':'200%'
        'width':'600px'
        'margin':'0px'
        'padding':'10px 0px 0px 10px'
        'text-align':'left'
# Color
        'color':'#6AC'
        'background-color':'white'
# Fonts
        'font-family':'"Gill Sans","Helvetica Neue","Arial",sans-serif'
        'font-weight':'normal'        
# Border and rounded corners
        'border':'1px solid #ccc'
        '-webkit-border-radius': '3px'
        '-moz-border-radius': '3px'
        'border-radius': '3px'
# Drop shadows
        '-webkit-background-clip':'padding-box'
        'background-clip':'padding-box'
        '-moz-box-shadow':'3px 3px 9px #888888'
        '-webkit-box-shadow':'1px 0px 15px rgba(0, 0, 0, 0.2)'
        'box-shadow':'3px 3px 9px #888888'
        '-ms-filter':"progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#aaaaaa')"
        'filter': "progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#aaaaaa')"

    spTitle = JQ("""<div class="sp-title">SAVE PUBLISHING v.&alpha;</div>""") \
        .css({'font-size':'18px'})
    spSubTitle = JQ("""<div class="sp-subtitle">A JAVASCRIPT BOOKMARKLET<br/>BY <a href="">@FTRAIN</a></div>""") \
        .css({'font-size':'14px'})
    savePublishingDiv = JQ("""<div id="savepublishing"/>""") \
        .append(spTitle) \
        .append(spSubTitle) \
        .css(styles)
    savePublishingWrapper = JQ("""<div id="savepublishing-wrapper"/>""") \
        .append(savePublishingDiv) \
        .css({'margin-left':'auto','margin-right':'auto','width':'100%','text-align':'center'})
        
    JQ('body') \
        .append(savePublishingWrapper) \
        .css({'padding-top':'200px'})

