jQuery.noConflict()
(($) ->
  $ ->
    $(document).ready ->
        console.log '- assigning the "$" to ___jQuery'
        window.___jQuery = $
        
        console.log '- unloading onload'
        window.onload = window.onunload = () ->

        console.log '- removing scripts'        
        ___jQuery('script').remove()

        console.log '- inserting CSS'            
        document.loadCSS('https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/ui-lightness/jquery-ui.css');

        console.log '- unwrapping document'            
        document.body.unwrap()

        console.log '- adding styles'                
        ___jQuery(".socialtext").css({cursor:'pointer'})
        ___jQuery(".socialtext").click () -> console.log 'clicked', this

) jQuery
