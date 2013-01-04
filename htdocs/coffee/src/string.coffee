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
    # Funtime weeping-nights discovery: [\s\S] is how JavaScript says "."
    [orig, before, after] = @match(/^([\s\r\n]*)([\s\S]+)/)

    length = after.length
    short = length < 120
    afterNoBR = after.replace(/__BR__/g,' ')
    afterWithBR = after.replace(/__BR__/g,'<br/>')
    href = """text=%E2%80%9C#{encodeURI afterNoBR}%E2%80%9D&url=#{encodeURI location.href}"""
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
    
