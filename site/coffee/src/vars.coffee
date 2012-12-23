# ----------------
# SavePublishing
#
# This is a simple application that does the following:
#
# 1) Traverses the DOM and determines which elements are most likely
# to contain actual narrative text content.
#
# 2) Extracts the text from those elements, removing formatting, and
# concatenating them into single text nodes.
#
# 3) Cuts that text into lengths, optionally shortening the text.
#
# 4) Upon clicking, pops up a window to Tweet that text.
# 
# Application Variables
# ----------------

# These are "global" in the scope of the application (CoffeeScript
# executes within a closure).

if $?
    console.log """"$" is assigned to:\n#{$}"""
else
    console.log "$ is not assigned"
    
JQ = jQuery
TEXT_NODE = 3
ELEMENT_NODE = 1
BLOCKS = ['block', 'inline-block', 'table-cell', 'table-caption', 'list-item', 'none']
BLOCK_ELEMENTS = ['H1','H2','H3','H4','H5','H6', 'BODY']
TEXTUAL_ELEMENTS = ['SPAN','A','EM','B','STRONG','I']
IGNORABLE_ELEMENTS = ['IMG','OBJECT','EMBED','H1','H2']
NAV_CONTAINING_ELEMENTS = ['DIV','UL','OL','LI']
NAV_RATIO = 2


PUNCTUATION = ['.','?','!']
QUOTES = ['"', '“', '”'] 

SHORTENABLE_WORDS =
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

WORD_REGEX = new RegExp("(\\b)(" + \
    (key for key of SHORTENABLE_WORDS)
    .sort((a,b) -> return b.length - a.length)
    .join("\|") + \
    ")(\\b)", "gi")
