$(document).ready ->
    document.loadCSS('https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/ui-lightness/jquery-ui.css');
    document.body.unwrap()
    $(".socialtext").css({color:'red',cursor:'pointer'})
    $(".socialtext").click () -> console.log 'clicked'

