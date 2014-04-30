# ## Program execution
SECTION = 'run.coffee'

# We're finally back in jQuery-land.
#debug """The current document state:"""
#examinedoc = for key, value of JQ(document)
#    debug """\t#{key} is #{value}\n"""

# The styles that we'll add to the site    
Document::styles = ->
    debug 'Adding CSS styles'
    JQ('.true').css {color:'#F00','border-bottom':'none','text-decoration':'none', background:'white'}
    JQ('.true') \
        .mouseenter(-> JQ(@).css {background:'#FAA'}) \
        .mouseleave(-> JQ(@).css {background:'white'})
    JQ('.false').css {color:'#aaaaaa','border-bottom':'none','text-decoration':'none'}
    JQ('a').css {'text-decoration':'none'}

# The widget for the top of the page.
# 
Document::widget = ->

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
        'height':'85px'
        'margin-left':'auto'
        'margin-right':'auto'
        'padding':'10px 0px 0px 10px'
        'text-align':'left'
        'font-size':'14px'
        'line-height':'20px'        
    
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
        '-ms-filter':"progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#888888')"
        'filter': "progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#888888')"


    spTitle = JQ("""<div class="sp-title"><a href="http://savepublishing.com">SavePublishing.com</a> version 0&alpha;</div>""") \
        .css({'font-size':'18px'})
    
    spSubTitle = JQ("""<div class="sp-subtitle">A bookmarklet by <a href="https://twitter.com/intent/user?screen_name=ftrain" style="color:red">@ftrain</a>
        &middot; <a href="https://twitter.com/intent/user?screen_name=ftrain" style="color:red">follow on Twitter</a>
        &middot; <a href="http://github.com/ftrain/savepublishing" style="color:red">get the source</a> &middot;
        <br/>
        <a href="https://github.com/ftrain/savepublishing/issues/new?title=#{encodeURI 'Parse error: '+ location.href}" style="color:red">Report parse problems on github</a>
        or <a href="mailto:ford+savepublishing@ftrain.com" style="color:red">email bugs</a>
        &middot; <a href="http://savepublishing.com/credits.html" style="color:red">Credits</a></div>""") \
        .css({'font-size':'14px'})


    savePublishingDiv = JQ("""<div id="savepublishing"/>""") \
        .append(spTitle)    \
        .append(spSubTitle) \
        .css(boxStyles)

    savePublishingWrapper = JQ("""<div id="savepublishing-wrapper"/>""") \
        .append(savePublishingDiv) \
        .css(wrapperStyles)
        
    JQ('body')                         \
        .append(savePublishingWrapper) \
        .css({'margin-top':'100px'})


Document::run = ->
    debug 'Document ready'
    
    # - Call the main "unwrap" function.
    document.body.unwrap()
    
    # - After the DOM has been traversed and modified, update some styles.
    @styles()

    # - And finally, insert the widget
    @widget()
    
    true

if document.hasOwnProperty('body') and document.hasOwnProperty('run')
    document.run()
else
    JQ(document).ready(Document::run)
