PUNCTUATION = ['.','?','!']
QUOTES = ['"', '“', '”'] 
PARENS = ['(',')']
BRACKETS = ['[',']']
QPB = QUOTES.concat PARENS.concat BRACKETS

String::getStatements = ->

    findStatements = (chars, current, statements, closing, lastCap) ->
        statements ?= statements or []
        current ?= current or []
        closing ?= closing or "."

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

        while chars.length > 0
            findStatements(chars, current, statements, closing, lastCap)

        statements

        
    findStatements @split("")
            
            
    # _glue = (statement_type) ->
    #     statement_type = (if statement_type then statement_type else "NEUTRAL")
    #     if accum.length > 0
    #     new_string = accum.join("")
    #       statements.push
    #         statement: new_string
    #         size: size
    #         statement_type: statement_type
    #       accum = []
    #       size = 0
    #   _really = (string, i, lastcap) ->
    #     return false  if string.charAt(i + 1).match(/[\w\)"”]/) or string.charAt(i + 2).match(/[a-z]/) or string.charAt(i + 1).match(/[^\s]/)
    #     return false  if string.charAt(i - 1) is "."
    #     return false  if (i - lastcap) < 4
    #     true
    #   string = @replace(RegExp(" +", "g"), " ")
    #   statements = []
    #   accum = []
    #   size = 0
    #   in_quote = false
    #   in_parenthesis = false
    #   in_bracket = false
    #   lastcap = undefined
    #   lastspace = 0
    #   i = 0

    #   while i < string.length
    #     char = string.charAt(i)
    #     size++
    #     accum.push char
    #     lastcap = i  if char.match(/[A-Z]/)
    #     switch char
    #       when "."
    #         break  unless _really(string, i, lastcap)
    #         _glue "PERIOD"
    #       when "!"
    #         break  unless _really(string, i)
    #         _glue "EXCLAMATION"
    #       when "?"
    #         break  unless _really(string, i)
    #         _glue "QUESTION"
    #       when ";", "\""
    #     , "“"
    #         in_quote = true
    #       when "”"
    #         break  unless _really(string, i)
    #         _glue "QUOTE" and $this.settings.quotes
    #         in_quote = false
    #       when ","
    #         break  if string.charAt(i + 1).match(/[”"]/)
    #       when "—", "("
    #         in_parenthesis = true
    #       when ")"
    #         in_parenthesis = false
    #       when "["
    #         in_bracket = true
    #       when "]"
    #         in_bracket = false
    #       when " "
    #         lastspace = i
    #       else
    #     i++
    #   _glue()
    #   statements
