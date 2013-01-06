#!/bin/bash
# Grep for referers that show how the JavaScript is being called

THE_DATE=`date +"%Y-%m-%d"`   # "2012-01-06"
THE_GREP_DATE=`date +"%d/%h"` # "Jan/06"
THE_LOG='/home/ford/sites/savepublishing.com/logs/access_log'
THE_OUTFILE="/home/ford/sites/savepublishing.com/htdocs/usage/${THE_DATE}.html"
THE_JS_FILE='GET /js/lib/savepublishing.js ' # Note space
THE_PERL_MATCHER='/([^"]+)/; print qq{<br/><a href="$1">$1</a>\n}'

tail -100000 "${THE_LOG}"                                        \
    | grep "${THE_JS_FILE}"                                      \
    | grep "${THE_GREP_DATE}"                                    \
    | cut -d" " -f11                                             \
    | tac                                                        \
    | grep -v savepublishing                                     \
    | perl -ne "${THE_PERL_MATCHER}"                             \
    > "${THE_OUTFILE}"

