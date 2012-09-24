String::entities = ->
    replace = (char) -> 
        switch char
            when '&' then '&amp;'
            when '"' then '&quot;'
            when '>' then '&gt;'
            when '<' then '&lt;'
    @.replace(/[&\"><]/, (a) -> replace(a))

String::clean = ->
    @.replace(/\s+/g, ' ').replace(/\n+/g, ' ').replace(/^\s*$/,'').entities()

# Using the table of abbreviations look up an
# abbreviation.
#
# @param left The left word boundary character
# @param word The captured term
# @param right The right word boundary
String::toAbbreviation = (left, word, right) -> "#{left}#{SHORTENABLE_WORDS[word.toLowerCase()]}#{right}"

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
    $("""<a href="http://twitter.com#{encodeURI(@)}">#{@}#</a>""")


PUNCTUATION = ['.','?','!']
QUOTES = ['"', '“', '”'] 
PARENS = ['(',')']
BRACKETS = ['[',']']
QPB = QUOTES.concat PARENS.concat BRACKETS

String::getStatements = ->

    chars = []
    current = []
    statements = []
    closing = "."
    lastCap = null
    
    chars = @split("")
    while chars.length > 0
        char = chars.shift()

        current.push(char)
        currentLast = current.length - 1
        lastCap = currentLast if /[A-Z]/.test(char)

        if (char in QUOTES and closing in QUOTES) or
           (char in PARENS and closing in PARENS) or
           (char in BRACKETS and closing in BRACKETS) or
           (char in PUNCTUATION and closing in PUNCTUATION) or
           (chars.length is 0)
            # "Great news," he said.
            isContinuation = (/\s/.test(chars?[0]) and /[a-z]/.test(chars?[1]))
            lastCapDelta = if lastCap then currentLast - lastCap else null
            isCloseToCap = (lastCapDelta < 5)
            dontBreak = not(isContinuation or isCloseToCap)
            
            if chars.length is 0 or dontBreak
                if current.length > 0
                    statements.push current.join("")
                    current = []
                    closing = null                
                    lastCap = null
            else
                closing = null
                
        else if (char in QPB)
            closing = char

    statements
    