/******************************************
 * Social Text
 *
 * Finds the text inside an HTML document that is suitable for social networks
 * and makes it easy to tweet that text.
 *
 * @author          Paul Ford
 * @copyright       Copyright (c) 2012 Paul Ford.
 * @license         Dual licensed under the MIT and GPL licenses.
 * @link            http://www.savepublishing.com
 * @docs            http://www.savepublishing.com/socialtext
 *
 ******************************************/

var dbg = (typeof console !== 'undefined') ? function (s) {
    console.log("socialtext: " + s);
} : function () {
};

(function($)
{
	$.fn.socialText = function(option, settings)
	{
		if(typeof option === 'object')
		{
			settings = option;
		}
		else if(typeof option === 'string')
		{
			var data = this.data('_socialText');

			if(data)
			{
				if($.fn.socialText.defaultSettings[option] !== undefined)
				{
					if(settings !== undefined){
						//if you need to make any specific changes to the DOM make them here
						data.settings[option] = settings;
						return true;
					}
					else return data.settings[option];
				}
				else return false;
			}
			else return false;
		}

		settings = $.extend({}, $.fn.socialText.defaultSettings, settings || {});

		return this.each(function()
		{
			var $elem = $(this);

			var $settings = jQuery.extend(true, {}, settings);

			var socialtext = new SocialText($settings);

            socialtext.generate();

			// run some code here
			// try to keep as much of the main code in the prototype methods as possible
			// focus on just setting up the plugin and calling proper methods from here

			$elem.data('_socialText', boiler);
		});
    };

	$.fn.socialText.defaultSettings = {
        length      :120, // The desired length of a sentence
        commas      :false,
        semicolons  :false,
        periods     :true,
        squeeze     :false,
        disemvowel  :false
	};

	function SocialText(settings)
	{
		this.socialtext = null;
		this.settings = settings;
        this.words = {
            // Numerals
            'one':1,
            'two':2,
            'three':3,
            'four':4,
            'five':5,
            'six':6,
            'seven':7,
            'eight':8,
            'nine':9,
            'ten':10,
            'eleven':11,
            'twelve':12,
            'thirteen':13,
            'fourteen':14,
            'fifteen':15,
            'sixteen':16,
            'seventeen':17,
            'eighteen':18,
            'nineteen':19,
            'twenty':20,
            'thirty':30,
            'forty':40,
            'fifty':50,
            'sixty':60,
            'seventy':70,
            'eighty':80,
            'ninety':90,
            'hundred':100,
            'thousand':'1k',
            'million':'mm',
            'billion':'bn',
            'trillion':'trln',

            // Days of week
            'monday':'Mon',
            'tuesday':'Tue',
            'wednesday':'Wed',
            'thursday':'Thu',
            'friday':'Fri',
            'saturday':'Sat',
            'sunday':'Sun',

            // Days of week
            'january':'Jan',
            'february':'Feb',
            'march':'Mar',
            'april':'Apr',
            'may':'May',
            'june':'Jun',
            'july':'Jul',
            'august':'Aug',
            'september':'Sep',
            'october':'Oct',
            'november':'Nov',
            'december':'Dec',

            // Misc terms
            'every':'vry',
            'see':'C',
            'cool':'k',
            'overheard':'OH',
            'whatever':'wtv',
            'your':'Ur',
            'you':'U',
            'about':'abt',
            'because':'b\/c',
            'before':'b4',
            'chk':'chk',
            'to':'2',
            'and':'&',
            'their':'thr',
            'from':'frm',
            'them':'thm',
            'be':'B',
            'large':'lrg',
            'absolute':'abs.',
            'becomes':'bcms',
            'equal':'=',
            'which':'whch',
            'for':'4',
            'are':'R',
            'great':'gr8',
            'at':'@',
            'that':'th@',
            'quarter':'1\/4',
            'half':'1\/2'
        };

        // Matches keys above with word boundaries to left and right
        this.word_regex = new RegExp('(\\W)(' + keys(words).join("|") + ')(\\W)', 'gi');

		return this;
	}

	SocialText.prototype =
	{
		generate: function()
		{
			var $this = this;

			if($this.boiler) return $this.boiler;

			$this.boiler = $('<div>boiler</div>');

			return $this.boiler;
		},
        _toAbbreviation:function (prefix, word, suffix) {
            dbg(word);
            /* Using the table of abbreviations look up an
             * abbreviation.
             *
             * param:prefix The left word boundary character
             *
             * param:word The captured term
             *
             * param:suffix The left word boundary character
             *
             */
            var lc_word = word.toLowerCase(); // Regexp passes through all cases
            return prefix + this.words[lc_word] + suffix;
        },
        _toFirstSlash:function (str) {
            /* Return the first and slash, i.e. turn "with" into
             * "w/"
             *
             * param:str The string to be chopped
             *
             */
            return str.charAt(0) + '/';

        },

        squeeze:function () {
            var _this = this;

            /* Return an abbreviated version of the text */
            var new_text = _this.text();

            new_text = new_text.replace
                    (
                            this.word_regex,
                            function (a, b, c, d) {
                                return _this._toAbbreviation(b, c, d);
                            }
                    );
            new_text = new_text.replace
                    (
                            /(with|of)\W/g,
                            function (m) {
                                return _this._toFirstSlash(m);
                            }
                    );
            new_text = new_text.replace(/(without)/g, 'w/out');
            new_text = new_text.replace(/e(r|d)(\W)/g, '\$1\$2');
            new_text = new_text.replace(/ has/g, '\'s ');
            new_text = new_text.replace(/\s+the\s+/g, ' ');
            new_text = new_text.replace(/ess/g, 's');
            new_text = new_text.replace(/er/g, 'r');
            new_text = new_text.replace(/\sfor/g, ' 4');
            new_text = new_text.replace(/ have/g, '\'ve');

            return new_text;
        },

        hideLong: function() {
            return false;
        },

        showLong: function() {
            return false;
        },

        split: function() {
            return false;
        },

        dress: function() {
          // Provide a nice halo.
            return false;
        }


	}
})(jQuery);