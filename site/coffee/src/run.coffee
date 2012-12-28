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
    wrapperStyles =
        'z-index':9999999
        'position':'fixed'
        'top':'10px'
        'width':'100%'
    boxStyles =
# Positioning
        'width':'600px'
        'height':'75px'
        'margin-left':'auto'
        'margin-right':'auto'
        'padding':'10px 0px 0px 10px'
        'text-align':'left'
        'font-size':'12pt'
        'line-height':'1.25em'        
        
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

    spTitle = JQ("""<div class="sp-title"><a href="http://savepublishing.com">SavePublishing.com</a> v.&alpha;</div>""") \
        .css({'font-size':'18px'})
        
    spSubTitle = JQ("""<div class="sp-subtitle">A bookmarklet by <a href="https://twitter.com/intent/user?screen_name=ftrain" style="color:red">@ftrain</a> &middot; <a href="https://twitter.com/intent/user?screen_name=ftrain" style="color:red">follow me</a> &middot; <a href="http://github.com/ftrain/savepublishing">get the source</a> &middot; <a href="mailto:ford+savepublishing@ftrain.com">report bugs</a></div>""") \
        .css({'font-size':'14px'})

    
    #sliderWrapper = JQ("""<div id="savepublishing-wrapper"/>""") \
    #    .css({'padding:20px 0 0 20%','width':'60%'})
    #sliderDiv = JQ("""<div id="savepublishing-slider"/>""").slider();
    #sliderWrapper.append(sliderDiv)
    #    .append(sliderWrapper)  \    

    savePublishingDiv = JQ("""<div id="savepublishing"/>""") \
        .append(spTitle)    \
        .append(spSubTitle) \
        .css(boxStyles)

    savePublishingWrapper = JQ("""<div id="savepublishing-wrapper"/>""") \
        .append(savePublishingDiv) \
        .css(wrapperStyles)
        
    JQ('body')                         \
        .append(savePublishingWrapper) \
        .css({'padding-top':'100px'})

