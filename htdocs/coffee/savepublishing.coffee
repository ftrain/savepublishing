# # SavePublishing Bookmarklet
# Version v0.4a
# 
# ## License
# This code is released under the MIT License
# and is available on GitHub here:
# 
# [https://github.com/ftrain/savepublishing](https://github.com/ftrain/savepublishing)
#
# ## Introduction
# 
# This is a simple application, invoked via bookmarklet and executed
# against the currently loaded DOM on a page, that finds many of the
# Tweetable elements on a page and turns them into tweet links.
#
# To accomplish this the code:
#
# 1. Traverses the DOM and determines (using a very simple method)
# which elements are most likely to contain actual narrative text
# content.
#
# 2. Extracts the text from those elements, removing certain types of
# formatting like hrefs and links, and concatenating them into single
# text nodes.
#
# 3. Cuts that text into lengths, optionally shortening the text.
#
# 4. Upon clicking on selected text, sends the link to Twitter via web
# intent.
# 
# ## Application Variables
# 
# There are a number of variables that are "global" in the scope of
# the application (CoffeeScript executes within a closure).
#
# ## Basic initialization variables and utility functions
# 
# **SECTION**—the COBOLesque `SECTION` variable appears on the top of
# each coffeescript file. When the `*.coffee` files are concatenated
# for expansion into JavaScript this eases debugging.
# 
SECTION = "init.coffee"

# **debug**—utility debug function
DEBUG   = true
debug   = (message) ->
    console.log """#{SECTION}: #{message}""" if DEBUG

# **ELEMENT_NODE**, etc.—convenience globals to ease readability of
# code as we dance around the DOM.
# 
ELEMENT_NODE = 1
TEXT_NODE = 3
COMMENT_NODE = 8

# **MIN\_LINK\_RATIO**—describes the minimum ratio of all the text in a
# text block to the amount of text contained within links (`<a
# href...`). Thus:
#
# `<a href="http://example.com">This</a>`
#
# by itself has a LINK_RATIO ratio 4/4, reducing to 1. Whereas
#
# `<a href="http://example.com">This</a> is quite the sentence.`
#
# has a LINK_RATIO ratio 27/4, or 6.75.
#
# We can use this ratio to make smarter guesses about whether a piece
# of content contains narrative content, or if it contains only links.
# 
MIN_LINK_RATIO = 2

# **JQUERY\_UI\_CSS**—The source for the CSS for jQuery UI
JQUERY_UI_CSS = 'https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/ui-lightness/jquery-ui.css'

# This code runs all over the place, on top of already propagated,
# live DOMs, and everywhere it runs the `$` variable has already been
# defined.
#
# After much futzing (there was much futzing) it seems that the least
# painful, calmest, most obvious approach is to load a fresh jQuery
# when the bookmarklet is invoked then pass it into the SavePublishing
# function as the variable JQ.
#
# This also serves as a sort of anti-mnemonic--it reminds you that you
# are messing around in someone else's DOM, and should keep that in
# mind because who knows what in God's green earth they've gone and
# got up to.
 
JQ = window.JQ

if $?
    debug """"$" is assigned as:\n#{$}"""
else
    debug """"$" is not assigned"""


# ## Document types
#
# Various classes of documents that we wish to ignore (or not) based on style, name, etc.
BLOCKS                   = ['block', 'inline-block', 'table-cell', 'table-caption', 'list-item', 'none']
BLOCK_ELEMENTS           = ['H1','H2','H3','H4','H5','H6', 'BODY']
TEXTISH_ELEMENTS         = ['SPAN','EM','B','STRONG','I','TT','ABBR','ACRONYM','BIG','CITE','CODE','DFN','LABEL','Q','SAMP','SMALL','SUB','SUP','VAR','DEL','INS', 'BR']
IRRELEVANT_ELEMENTS      = ['IMG','OBJECT','EMBED','IFRAME','SCRIPT','INPUT','FORM','HEAD','H1','H2','H3','H4','H5','H6','STYLE','LINK']
NAV_CONTAINING_ELEMENTS  = ['DIV','UL','OL','LI','P']
PUNCTUATION              = ['.','?','!','(',')','[',']','{','}']
QUOTES                   = ['"', '“', '”'] 

# **SHORTENABLE_WORDS**—a list of words that can be abbreviated,
# should we go that route.
# 
SHORTENABLE_WORDS        =
    'one': 1
    'first': "1st"
    'two': 2
    'second': "2nd"
    'three': 3
    'third': "3rd"
    'four': 4
    'fourth': "4th"
    'five': 5
    'fifth': "5th"
    'six': 6
    'sixth': "6th"
    'seven': 7
    'seventh': "7th"
    'eight': 8
    'eighth': "8th"
    'nine': 9
    'ninth': "9th"
    'ten': 10
    'tenth': "10th"
    'eleven': 11
    'twelve': 12
    'thirteen': 13
    'fourteen': 14
    'fifteen': 15
    'sixteen': 16
    'seventeen': 17
    'eighteen': 18
    'nineteen': 19
    'twenty': 20
    'thirty': 30
    'forty': 40
    'fifty': 50
    'sixty': 60
    'seventy': 70
    'eighty': 80
    'ninety': 90
    'hundred': 100
    'thousand': "1k"
    'million': "mm"
    'billion': "bn"
    'trillion': "trln"
    'monday': "Mon"
    'tuesday': "Tue"
    'wednesday': "Wed"
    'thursday': "Thu"
    'friday': "Fri"
    'saturday': "Sat"
    'sunday': "Sun"
    'january': "Jan"
    'february': "Feb"
    'march': "Mar"
    'april': "Apr"
    'may': "May"
    'june': "Jun"
    'july': "Jul"
    'august': "Aug"
    'september': "Sep"
    'october': "Oct"
    'november': "Nov"
    'december': "Dec"
    'every': "vry"
    'see': "C"
    'cool': "k"
    'overheard': "OH"
    'whatever': "wtv"
    'your': "Ur"
    'you': "U"
    'about': "abt"
    'because': "b/c"
    'before': "b4"
    'chk': "chk"
    'to': "2"
    'and': "&"
    'their': "thr"
    'from': "frm"
    'them': "thm"
    'be': "B"
    'large': "lrg"
    'absolute': "abs."
    'becomes': "bcms"
    'equal': "="
    'which': "whch"
    'for': "4"
    'are': "R"
    'great': "gr8"
    'at': "@"
    'that': "th@"
    'quarter': "1/4"
    'half': "1/2"
    'Alabama': "AL"
    'Alaska': "AK"
    'Arizona': "AZ"
    'Arkansas': "AR"
    'California': "CA"
    'Colorado': "CO"
    'Connecticut': "CT"
    'Delaware': "DE"
    'District of Columbia': "DC"
    'Florida': "FL"
    'Georgia': "GA"
    'Hawaii': "HI"
    'Idaho': "ID"
    'Illinois': "IL"
    'Indiana': "IN"
    'Iowa': "IA"
    'Kansas': "KS"
    'Kentucky': "KY"
    'Louisiana': "LA"
    'Maine': "ME"
    'Maryland': "MD"
    'Massachusetts': "MA"
    'Michigan': "MI"
    'Minnesota': "MN"
    'Mississippi': "MS"
    'Missouri': "MO"
    'Montana': "MT"
    'Nebraska': "NE"
    'Nevada': "NV"
    "New Hampshire": "NH"
    "New Jersey": "NJ"
    "New Mexico": "NM"
    "New York": "NY"
    "North Carolina": "NC"
    "North Dakota": "ND"
    'Ohio': "OH"
    'Oklahoma': "OK"
    'Oregon': "OR"
    'Pennsylvania': "PA"
    "Rhode Island": "RI"
    "South Carolina": "SC"
    "South Dakota": "SD"
    'Tennessee': "TN"
    'Texas': "TX"
    'Utah': "UT"
    'Vermont': "VT"
    'Virginia': "VA"
    'Washington': "WA"
    "West Virginia": "WV"
    'Wisconsin': "WI"
    'Wyoming': "WY"
    "American Samoa": "AS"
    'Guam': "GU"
    "Northern Mariana Islands": "MP"
    "Puerto Rico": "PR"
    "Virgin Islands": "VI"

# **WORD_REGEX** is a regular expression that takes all of the
# `SHORTENABLE_WORDS` in that variable and turns them into a single
# regex that will replace the keys with their values.
#
# The terms are sorted by length, longest first, to improve the
# quality of the matcher.
# 
WORD_REGEX               = new RegExp("(\\b)(" + \
    (key for key of SHORTENABLE_WORDS)
    .sort((a,b) -> return b.length - a.length)
    .join("\|") + \
    ")(\\b)", "gi")


# ## Methods added to the `Document` class

SECTION = 'document.coffee'

# Function to load CSS.
# TODO this may go if we don't need it. It seems that the 
HTMLDocument::loadCSS = (url) ->
    link = @createElement("link")
    link.type = "text/css";
    link.rel = "stylesheet";
    date =(new Date).getTime()
    link.href = "#{url}?bust=#{date}"
    if @createStyleSheet
       @createStyleSheet url
    else
       @getElementsByTagName("body")[0].appendChild(link)



# ## Methods added to the `Window` class
SECTION = "array.coffee"

# **Array::merge()**—an array of `node`s.
# 
Array::merge = ->
    strings = (node.toText() for node in @)
    # Empty everything out
    node.emptyNode() for node in @
    text = strings.join("")
    spans = JQ("""<span class="socialtext-set"></span>""")
    for tweet in text.getStatements()
        t = tweet.enTweeten()
        spans.append(t)
    spans


# ## Methods added to the `Node` class
SECTION = 'node.coffee'

# **Node::containsElements()**—checks if a given node contains elements
#
#  Returns boolean.    
Node::containsElements = -> true in (node.nodeType is ELEMENT_NODE for node in @childNodes)

# **Node::isGoodLink()**—TKTK
#
#  Returns boolean.
Node::isGoodLink    = ->
    (@nodeType is ELEMENT_NODE) \
    and (@nodeName is 'A')      \
    and (@isNavLike() is false) \
    and (@containsElements() is false)

# **Node::isTextish()**—is this raw text or an inline element like `<a>` or `<i>`?
#
#  Returns boolean.        
Node::isTextish     = -> @nodeType is TEXT_NODE \
    or (@nodeName in TEXTISH_ELEMENTS) \
    or @isGoodLink()

# **Node::isElementish()**—is this an element that isn't just for formatting?
# 
# Returns boolean.
Node::isElementish    = -> @nodeType is ELEMENT_NODE \
    and not(@nodeName in TEXTISH_ELEMENTS)

# **Node::isBR()**—is this a `<br>` or `<BR>` or `<br/>` or `<br      />` tag?
# 
# Returns boolean. 
Node::isBR         = -> @isElementish() and @nodeName is 'BR'

# ### Checking for irrelevant nodes
# **Node::isIrrelevant()**
# 
# Returns boolean. 
Node::isIrrelevant = -> @nodeName in IRRELEVANT_ELEMENTS

# **Node::isComment()**—is this a `<!--HTML/XML comment-->`?
# 
# Returns boolean. 
Node::isComment    = -> @nodeType is COMMENT_NODE

# **Node::isWhitespace()**—is this node all whitespace?
# 
# Returns boolean.
Node::isWhitespace = -> (@nodeType is TEXT_NODE) and (/^[\t\n\r ]+$/.test(@data))

# **Node::isNavLike()**—now we can check to see if an element is navlike or not.
# 
# Returns boolean. 
Node::isNavLike    = ->
    (@nodeName in NAV_CONTAINING_ELEMENTS) \
    and (@className.isNavLike() or @id.isNavLike())

# **Node::getAllChars()**—given a block of text, count the number of
# characters that appear within.
# 
# Returns integer.
Node::getAllChars  = ->
    JQ(@).text().length

# **Node::getLinkChars()**—given a block of text, count the number of
# characters that appear inside `<a>` tags.
#
# Note: Doesn't check if something is an href or an anchor link.
#
# Returns integer.
Node::getLinkChars = ->
    total = 0
    links = JQ(@).children('a')
    # Could be reduce
    for link in links
        length = JQ(link).text().length
        total += length
    total

# Check if a nav element is mostly link text or not
# 
# Returns boolean. 
Node::getLinkRatio    = ->
    link = @getLinkChars()
    if link > 0
        all  = @getAllChars()
        all/link
    
Node::isLinkish    = ->
    ratio = @getLinkRatio()
    MIN_LINK_RATIO > ratio
    
# Block things
# 
# Returns boolean. 
Node::isBlockLike  = -> JQ(@).css('display')? in BLOCKS or @nodeName in BLOCK_ELEMENTS

# Convert an element to text
Node::toText = ->
    if @nodeType is ELEMENT_NODE
        text = JQ(@).text()
        n = @nodeName

        rtext = text
        if n is 'A'
            rtext = "#{text}" 
        else if n in ['B', 'STRONG']
            rtext = "*#{text}*"
        else if n in ['EM', 'I']        
            rtext = "_#{text}_" 

        else if n is 'BR'
            rtext = "__BR__"

        rtext = rtext.clean()
        rtext = null if rtext.isWhitespace()
        rtext

    else
        @nodeValue

# **Node::isUseful()**—TKTK
# 
# Returns boolean.  
Node::isUseful     = ->
    debug """

\tnodename......#{@nodeName}
\tclassName.....#{@className}
\tid............#{@id}
\tnodetype......#{@nodeType}
\tisElement.....#{@nodeType is ELEMENT_NODE}
\tisIrrelevant..#{@isIrrelevant()}
\tisNavLike.....#{@isNavLike()}
\tisLinkish.....#{@isLinkish()}
\tisTextish.....#{@isTextish()}
\tisWhitespace..#{@isWhitespace()}
\tisComment.....#{@isComment()}
"""
    not(@isWhitespace() or @isComment() or @isIrrelevant() or @isLinkish() or @isGoodLink())
    

# **Node::emptyNode**—"empty out" the content in a node, leaving it
# within the DOM.
#
# When concatenating text nodes into single text node the issue
# remains: What to do with the remaining tags? If you simply strip
# them out, things can get weird very quickly as all sorts of
# interdependencies and code expectations, as well as stylesheet rules
# surface. It's better to leave the shell of the tag in place.
# 
# Returns boolean
Node::emptyNode = ->
    if (@nodeType is TEXT_NODE)
        @nodeValue=""
        true        
    else
        JQ(@).html("")
        true

# ### ``Node::unwrap()``
# 
# This is the main function for this bookmarklet. It is a recursive
# function that steps through the DOM hierarchy starting with the
# specified node object, and looks for the first "textish" child.
#
# What happens is 

Node::unwrap = ->
    texts    = []
    for node in @childNodes
        if node.isTextish()
            texts.push(node)
        else
            JQ(texts[0]).replaceWith(texts.merge())
            texts = []
            node.unwrap() if node.isUseful()
                
    JQ(texts[0]).replaceWith(texts.merge())


# ## Methods added to the `String` class
SECTION = "string.coffee"

# Does this look like masthead or navigation?
String::isNavLike = ->
    match = @match /head|breadcrumb|addthis|share|nav|mast|social|twitter|reddit|facebook|fb/i
    if match then true else false

# Tidy up entities, for when we rewrite text
String::addXMLEntities = ->
    replace = (char) -> 
        switch char
            when '&' then '&amp;'
            when '"' then '&quot;'
            when '>' then '&gt;'
            when '<' then '&lt;'
    @replace(/[&\"><]/g, (a) -> replace(a))

String::shrinkSpaces = -> @replace(/\s\s+/g, ' ')

String::stripNewlines = -> @replace(/[\n\r]+/g, ' ')

String::emptyWhitespace = -> @replace(/^[\s\r]*$/,'')
        
# Get rid of spaces
String::clean = -> @stripNewlines().emptyWhitespace().shrinkSpaces().addXMLEntities()

String::isWhitespace = -> /^[\t\n\r ]+$/.test(@)

# **String::toAbbreviation**—using the table of abbreviations look up an
# abbreviation.
#
# - `left`—the left word boundary character.
# - `word`—the captured term.
# - `right`—the right word boundary.
String::toAbbreviation = (left, word, right) ->
    "#{left}#{SHORTENABLE_WORDS[word.toLowerCase()]}#{right}"

# Turns "of" into "o/", etc.
#
# @param str The string to enslash
String::toFirstSlash = (str) -> "#{str.charAt(0)}/"

String::squeeze = ->
    @.replace(word_regex, (a, b, c, d) -> @toAbbreviation b, c, d)
    .replace(/(with|of)\W/g, (m) -> @toFirstSlash m)
    .replace(/\s+the\s+/g, " ")
    .replace(/(without)/g, "w/out")
    .replace(/e(r|d)(\W)/g, "$1$2")
    .replace(RegExp(" has", "g"), "'s ")
    .replace(/est/g, "st")
    .replace(/\sam\b/g, "’m")
    .replace(/\b(will|shall)/g, "’ll")
    .replace(/\bnot/g, "n’t")
    .replace(/e(r|n)(\b)/g, "$1$2")
    .replace(/\sfor/g, " 4")
    .replace(RegExp(" have", "g"), "'ve")
    .replace(/(1[0-9]|20)/g, (a) -> "&#" + (parseInt(a) + 9311) + ";" )

String::compareLength = (comparison) ->
    @length < comparison

    
# **String::enTweeten()**
#
# Returns node
String::enTweeten = ->
    [orig, before, after] = @match(/^([\s\n\r]*)(.+)/)
    length = after.length
    short = length < 120
    afterNoBR = after.replace(/__BR__/g,'')
    afterWithBR = after.replace(/__BR__/g,'<br/>')    
    href = encodeURI """text=“#{afterNoBR}”&url=#{location.href}"""
    span = JQ("""<span class="socialtext">#{before}<a href="https://twitter.com/intent/tweet?#{href}" class="socialtext #{short}">#{afterWithBR}</a></span>""")
    span.data('length', length)
    span.attr('title', length)
    span

# **String::getStatements()**—Parse out "statements"; i.e. sentences,
# from flattened text. This is not a parser, just a fairly dull
# matcher that meets the use case. Lots of room for more smarts.
            
String::getStatements = ->
    chars = []
    current = []
    statements = []
    closing = "."
    lastCap = null
    chars = @.split("")
    while chars.length > 0
        char = chars.shift()
        current.push(char)                    
        currentLast = current.length - 1
        lastCap = currentLast if /[A-Z]/.test(char)

        # This needs to be much smarter
        if (char in QUOTES and closing in QUOTES) \
        or (char in PUNCTUATION and closing in PUNCTUATION) \
        or (chars.length is 0)

            isContinuation = (/\s/.test(chars?[0]) and /[a-z]/.test(chars?[1]))

            lastCapDelta = if (lastCap > -1) then (currentLast - lastCap) else null

            # "I am calling you from the U.S.A."
            isCloseToCap = (lastCapDelta < 4)

            # "I cried."            
            isVeryShort = (currentLast < 15)

            # "The time is 10 p.m., so there are two hours to go."
            nextIsText = /\w/.test(chars?[0])

            # "“I have to be very honest,” he said."
            prevIsComma = /,/.test(current[current.length - 2])

#            console.log(char, current.join(""), isContinuation, isVeryShort, isCloseToCap, lastCapDelta, lastCap, currentLast, nextIsText, prevIsComma)

            doBreak = not(isContinuation or isVeryShort or isCloseToCap or nextIsText or prevIsComma)
            if chars.length is 0 or doBreak
                if current.length > 0
                    text = current.join("")
                    if not(text.isWhitespace())
                        statements.push(current.join(""))
                    current = []
                    closing = "."
                    lastCap = null
            else
                closing = "."
                
        else if (char in QUOTES)
            closing = char
    statements
    


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
        

    JQ('.false').css {color:'#aaaaaa','border-bottom':'none','text-decoration':'none'}

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
        'height':'55px'
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
        
    spSubTitle = JQ("""<div class="sp-subtitle">A bookmarklet by <a href="https://twitter.com/intent/user?screen_name=ftrain" style="color:red">@ftrain</a> &middot; <a href="https://twitter.com/intent/user?screen_name=ftrain" style="color:red">follow on Twitter</a> &middot; <a href="http://github.com/ftrain/savepublishing">get the source</a> &middot; <a href="mailto:ford+savepublishing@ftrain.com">report bugs</a> &middot; <a href="http://savepublishing.com/credits.html">credits</a></div>""") \
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
        .css({'margin-top':'100px'})

