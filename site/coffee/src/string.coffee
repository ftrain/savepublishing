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
