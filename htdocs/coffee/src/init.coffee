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
# I could always do this sorting ahead of time here inline but it's
# easier to just let thousands of machines do it over and over all
# around the world. Especially when you consider that this function is
# never actually used.
# 
WORD_REGEX               = new RegExp("(\\b)(" + \
    (key for key of SHORTENABLE_WORDS)
    .sort((a,b) -> return b.length - a.length)
    .join("\|") + \
    ")(\\b)", "gi")

# `getBestURL()`—Set URL, and then replace it with canonical URL if one is
# available

# TODO Move this into window.coffee? Or some util function thingy?
# 
getBestURL = ->
    url = location.href
    canonical = JQ('link[rel="canonical"]')
    if canonical
        url = canonical.attr('href') if canonical.attr('href')
        if not url.match(/^http/)
            url = "#{location.protocol}//#{host}/#{url}"
    debug "The best URL for this page is: #{url}"
    url

BEST_URL = getBestURL()

