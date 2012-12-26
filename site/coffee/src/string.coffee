# ## Methods added to the `String` class
SECTION = "string.coffee"

# Does this look like masthead or navigation?
String::isNavLike = ->
    match = @match /head|breadcrumb|addthis|share|nav|mast|social|twitter|reddit|facebook|fb/i
    debug "Match: #{match}"
    if match then true else false

# Tidy up entities, for when we rewrite text
String::entities = ->
    replace = (char) -> 
        switch char
            when '&' then '&amp;'
            when '"' then '&quot;'
            when '>' then '&gt;'
            when '<' then '&lt;'
    @.replace(/[&\"><]/, (a) -> replace(a))

# Get rid of spaces
String::clean = ->
    @.replace(/\s+/g, ' ').replace(/\n+/g, ' ').replace(/^\s*$/,'').entities()

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

String::textToLink = ->
    # TK Regexp here to parcel out spaces
    JQ("""<a href="http://twitter.com#{encodeURI(@)}">#{@}#</a>""")

String::compareLength = (comparison) ->
    @length < comparison


# **String::enTweeten()**
# 
String::enTweeten = ->
    length = @length
    short = length < 120
    span = JQ("""<span class="socialtext #{short}"></span>""")
    span.data('length', length)
    span.html("""#{@}""")
    span.attr('title',@)
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

        if (char in QUOTES and closing in QUOTES) or
           (char in PUNCTUATION and closing in PUNCTUATION) or
           (chars.length is 0)
            # "Great news," he said.
            isContinuation = (/\s/.test(chars?[0]) and /[a-z]/.test(chars?[1]))
            lastCapDelta = if lastCap then currentLast - lastCap else null
            isCloseToCap = (lastCapDelta < 5)
            isVeryShort = (currentLast < 15)
            doBreak = not(isContinuation or isVeryShort or isCloseToCap)
            
            if chars.length is 0 or doBreak
                if current.length > 0
                    statements.push current.join("")
                    current = []
                    closing = "."
                    lastCap = null
            else
                closing = "."
                
        
                
        else if (char in QUOTES)
            closing = char

        
    statements
    
