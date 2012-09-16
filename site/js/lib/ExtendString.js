/*


 Extensions to native string.

 */

var trim = /^\s*(.*)\s*$/g;
String.prototype.trimWhitespace = function () {
    /**
     * Trims whitespace.
     *
     * Depends on a regular expression in variable trim.
     *
     *  @return {String}
     */
    return this.replace(trim, '\$1');
}

var newlines = /[\n\r]/g;
String.prototype.stripNewlines = function () {
    /**
     * Replaces newline with spaces.
     *
     * Depends on a regular expression in variable newLines.
     */
    return this.replace(newlines, ' ');
}

var para = /(.+?)SOCIALTEXT_BR\s*SOCIALTEXT_BR/g;
String.prototype.twoBreaksToSocialtext = function () {
    /**
     * Wraps text before two occurrences of SOCIALTEXT_BR in a socialtext class.
     *
     * Depends on a regular expression in variable para.
     *
     *  @return {String}
     */

    return this.replace(para, '<span class="socialtext-line">\$1</span><br/><br/>\n\n');
}

var rebreak = /(.*?)SOCIALTEXT_BR/g;
String.prototype.oneBreakToSocialtext = function () {
    /**
     * Wraps text before a break in a socialtext class.
     *
     * @return {String}
     *
     * Depends on a regular expression in variable rebreak.
     */
    return this.replace(rebreak, '<span class="socialtext-line">\$1</span><br/>');
}

String.prototype.wrapInSpan = function () {
    /**
     * Wraps text in a socialtext class.
     *
     * @return {String}
     */

    return '<span class="socialtext-text">' + this + '</span>';
}

var entities = /[&"><]/g;
String.prototype.replaceEntities = function () {
    /**
     *
     * @param char
     * @return {String}
     */

    function replace(char) {
        /**
         * Inserts HTML entitities
         *
         * @param char a single character that is one of &"><
         */
        switch (char) {
            case '&':
                return '&amp';
            case '"':
                return '&quot;';
            case '>':
                return "&gt;"
            case '<':
                return "&lt;"
        }
    }

    return this.replace(entities, function (a) {
        return replace(a);
    });
}