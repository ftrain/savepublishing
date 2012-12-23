console.log JQ
JQ(window).load ->
    console.log '- inserting CSS'
    document.loadCSS('https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/ui-lightness/jquery-ui.css');

    console.log '- unwrapping document'            
    document.body.unwrap()

    console.log '- adding styles'                

    JQ(".socialtext").css({cursor:'pointer'})
    JQ(".socialtext").click () -> console.log 'clicked', this
    JQ(".true").css({color:'black'})
    JQ(".false").css({color:'#bbbbbb'})
