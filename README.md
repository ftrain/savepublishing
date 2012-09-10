#!+TITLE: SavePublishing.com

This is the code necessary for a full deploy of SavePublishing.com

- bookmarklet/
- css
-

* What's here?

* What's there?

* Anyway this Bookmarklet

<2012-08-18 Sat>

_This is a highly edited and restructured diary. Some of it was written after the fact._

I need a conversion.

I was reading Walt Whitman's Leaves of Grass and tweeted a line from within. It was:

Tweet TK.

And it occurred to me it would be pretty easy to write a Python script that would find all of the tweetable lines in Leaves of Grass. And when that script had run you'd have not just all the tweetable lines in Leaves of Grass; moreover, you'd have all the tweetable lines in most things that are organized into sentences.

But as with most of my grand ideas I did little, aside from within my head:

1) Get the text somehow and parse it (probably with BeautifulSoup, an HTML parser that helps you make sense of HTML)

2) Cut it up into sentences (maybe using NLTK, a natural language parsing and extraction library for Python that has a wide, wide world of options)

3) Count the length of those sentences (because now they are in memory and that sort of thing is easy).

4) Spit out the sentences below 120 characters (because you must reserve 20 characters for the link)

Then it would be up to me to cut and paste those lines. But it would be fun to see how tweetable Walt Whitman is. There are all kinds of default mathematical scores for prose--the Flesch-Kincaid readbility test, for example. You could have a tweetability score to assure that
http://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_test

But I did nothing. And then, a few days later, I was tweeting something or other as we do and it occurred to me that it's kind of a pain to find a relevant quote of the appropriate length (120 characters, leaving 20 for the link) and then cut that link, and paste that link, and then hit the button, and so forth. And then I went, huh.

And two thoughts occurred to me:

1) How unbelievably lazy am I, that that seems like work? I remember photocopying art things to send them to strangers I found in the back of zines. I remember photocopying everything; if there was a technology that I understood it was that, because you could claim segments of books and make sense of them. Now I can't cut and paste for the effort?

2) But also, why shouldn't the computer show me the short lines, or automatically shorten some of them? Finding short sentences is not necessarily meaningful work.

3) And of course writing code to do that would be ridiculous, because it would point out a certain weirdness of social networks, which is that the act of sharing/communicating often takes precedence over communicating.

Now I don't want you to read this as "cut-and-paste is an antiquated technology." There are patterns in how people read now, anti-reading patterns, and it would make sense. Except I don't need any more readers or even more validation.


That we seem to have this idea of ghost-scissors, left over from yonder days. Cutting and pasting between applications. You pick a start point and an endpoint and then you cut the thing and paste it somewhere else. There's a lot of magic under the hood. Sometimes the applications speak different languages and the computer has to figure out what you meant. 

Except that the prevailing wisdom is that things should be modeless. 
When the truth is that you can do a modal shift from reading to sharing. People are against modes; modelessness is a key aspect of modern systems, in fact. NO MODES. This is a good thing, a rich legacy of devices like the automobile. The only problem is that real-life systems are chockablock with modes. 

That the prevailing wisdom has ended up supporting a whole 

It's amazing how much of the culture industry depends on validation, on feelings of inadequacy, and how tuned our prose is for that, how much of life can become a continual audition--are you a good enough writer, are you agile enough, can you hit the right notes with the right color in the right rhythm.

But let's not discount ego.

What is the conversion?

That's segmenting out again. The practitioner has high ideals and dirty fingernails. This is an ever-rarer bird. The forms are stratified, the boundaries clear. The good programmers don't mess with PHP or Perl; they write Python and JavaScript, and now Go or Clojure. They seek out new forms that appeal, that allow them to differentiate themselves, abstractions that bring them joy, and then they evangelize.


High ideals and dirty fingernails get things done, but what they leave behind can be a thornbush. That's what I'm trying to do now.

No one particularly wants me to program; I'm not great at it. They want me to write and manage. I thrive in systematic grids, in colors and lines. But at some point. 


My great fear in life is that I will be unworthy of this love.


<2012-09-01 Sat>

I pull an all-nighter, or what passes for one for a 38-year-old with young twins who usually goes to bed no later than 11; instead I go to bed at 3AM. While it lasts it is majestic. So much work just flies out of my fingers. In the morning I wake up exhausted and refreshed, hungry, with a sore neck and new order brought to my thoughts. 


<2012-09-01 Sat>

I have the domain savepublishing.com, and I think that might be where this lives. The mismatch is funny to me. It feels like a tremendous dick move to call it that, but at the same time it's funny to me, the idea that you could somehow save publishing by finding short sentences.

I feel sad, sometimes, that the jokes that matter most to me amuse only a small room of people. I've met about half of them. To build something of utility, with a slider, and call it SavePublishing, is to me hilarious.

And yet people will use the bookmarklet and they will assume I am sincere. Am I missing an opportunity to connect with them directly? Should I register the website IsThisTheWorldWeWant? Sincerity always ends up fake. You need something in the system to remind you of human folly, some room to maneuver.

I need a conversion.


<2012-09-01 Sat>

I really only have a short amount of time to do this, a few hours here or there, between job and twins. And if I don't do it no one will notice. No one will care at all. It will come down to a few pages of code at most, literal milliseconds of execution. And if I ship it and it exists and is wildly successful I will come to hate it; I will despise it within six months because it will generate no money and the people who ask me to fix bugs will be imperious, presumptive assholes likely using it for nefarious well-poisoning, and they will have spotty English; the cost to them to scold and cajole me will be nothing. This is the nature of things.

And yet I want to share all of the tweetable lines in Leaves of Grass.

What is it that makes me want to share a Whitman poem with people? Or any poem really. What is the urge of the quoter? Some hypotheses:

1) Territorial expansion
2) Some sort.

All I know is that there is some linguistic connection, a moment where by going meta I can rope someone in.

I met a notable web curator--this is I swear to god a real thing--and she said, you know, I'm the middlebrow. I have people write me and say "I was never a reader before."

And if I am honest in my heart I do not love those people. Where have they been? And now they are going to get a subscription to I don't know the Atlantic and think well of themselves. 


<2012-09-01 Sat>

jQuery is a funny library. A library is a set of code that you can re-use.

jQuery has a way of seeing the web; it greatly abbreviates the code one must write, normalizes it. 

A web page is really just a bunch of words and tags that say, sort of, what those words are. It follows some rules to display those tokens; for example if it sees an <h1> and then some nice words and then a </h1>, it displays the nice words in a bigger typeface. 

jQuery was a reaction to JavaScript's native syntax, which is verbose and sometimes overwhelming.

JavaScript was a reaction to the structure of a web page in memory, and to other computer languages that came before, especially one called Scheme. 

Scheme was a reaction to LISP, which is more than 50 years old.

LISP was built atop an IBM TKTK machine, and thus it is a reaction to the way that machine works. The secret codes in LISP are car and cdr, which are.

LISP has been called a discovery rather than an invention, but of course it was a reaction to, or an interpretation, of the lambda calculus.

Which was a reaction to set theory.

Which was Georg Cantor's reaction to everything.


What is my code a reaction to?

Well, it's a reaction to Readability. I'm an advisor at Readability. It incorporates some code of Readability.


<2012-09-01 Sat>

I'm not a great coder. It's a fact of life. I'm certainly not the worst. I'm contientious. But it's never been the sole way I made a living and I don't have the burning mathematical awareness or love of process that it takes. I'm inconstant in exactly the wrong ways.

Yet I've learned to read code, to enjoy it. That's the pleasure of open-sourced software, is that you can internalize the lessons of others. There is now a whole culture of correctness around test-driven development and agile coding methodologies; there are leaders. It reminds me of English departments staring in anxious jealousy at Duke in the 1980s and early 1990s, watching as Frank Lentricchia strutted a leather jacket and wrote on science fiction. Or any community, really; the passionate norms and forms that create territories. This is the big insight of my last five years, having been an editor at Harper's, a CMS-builder for Condé Nast, all of it accidental: That forms create territories. The form itself is hardly important compared to the actual shape of the territory. It's been a long five years. In fact it's been seven.

<2012-09-05 Wed>

The scoring has already been done, of course; it's been done by Readability.

There is part of me that wants to let Readability do more lifting here—to call out to the API. I am an advisor to that company. I believe very deeply in what they are doing. Readability is about documents, about a part of the web that is passed over in an ecstasy of clicking and reinvention.

But at a certain point I need to decide.

<2012-09-08 Sat>

There is a tiny chance that this will receive on the order of 1-2 million hits a day. More likely it will be a few dozen or a couple hundred. Or that it will be forgotten.

And yet you never know and you should have always in the back of your mind a sense of what might happen if it blows up. There are two factors:

1) I don't want to spend money.
2) I don't want to overarchitect.

Oddly these are at odds. The easiest thing to do--it takes minutes--is spin up some abstract computer in some cloud and then run a server or two, pull the files out of version control, and be done. Everything is constant. And since I am hosting static files the likelik

There are two conversions--ask people to follow me on Twitter, thus building audience. This thing is probably worth a few hundred or maybe one thousand Twitter followers over time. I don't know what I'll do with them but having more followers makes people take me more seriously; I've been watching this as I wander around the world. I don't need hundreds of thousands (what would I do with them), but this is now a fact of life. And I want people, when they look me up, to see that I am an active and eager participant in the wider world, even if I often feel otherwise. This is important to keeping my billable rate high. The sweet spot, I've decided, is about 30,000 followers. Any more will be suspect.

I get invited to go on TV once or twice a year—some ideas program. I usually beg off. I'm too fat and don't have the right clothes, and don't want to deal.

I don't write as much as I used to because I am so incredibly vulnerable when I write. Because writing is a very moral act and if I tell less than what I believe I'll be lying and wasting time. And so that. 

I have a number of national magazines asking me in sincere tones when I'll send something in.

Thinktanks? Grants? I know a few people in the world of grantsmaking bodies; they forward me the infinitely cheerful, positive emails. People go work there because they believe they can change the world, whereas the weird thing about the web is that you can change the world. You can channel voices and money in very strange ways.

I suppose the right thing to do is say that none of it matters, that I don't mind thinking these things through. I find them interesting. But the fact remains that if you leave me be, I just want to write bookmarklets and play with things, create forms and work within them.

I keep getting the <i>what would make you happy</i> question.

Riding my bike, playing with my kids, creating a new decentralized modal CMS optimized around tiny statements, and seeing if it's possible to do software criticism.


<2012-09-08 Sat>



Deployment.



<2012-09-01 Sat>

Quinn is writing about sexual assault at tech conferences. And what the hell is this? Are we supposed to have take back the FOO camp rallies?

I mean I love this stuff. I love the bits. I love my own ignorance in the face of things. Why is it so hard?

But then at some level it is very hard. It is complex and there are assumptions and confusions. And so we need to talk about it, at length. 

My wife is about to go to school for Construction Project Management.

Words ricochet off of most people but with me, with other people in my world, they sink in, like a sugarcube into coffee. The right set of words can just leave you (I had a boss who would stand up).


There's something about that, that the scaffolding comes away and the building is just there in the sun, all the windows, and OSMETHING.




<2012-09-01 Sat>

I need a conversion. I need to get people to do something but what do I want them to do?

I want them _not_ to write things. I want them to dump words into social networks, to make that a bridge less far.

I want to simplify. I want to reduce the need for interpretation.

The conversion can also be the data.

By decomposing the units.
And this can teach us to write tweetably.
This knowledge is useful in general, then, for tuning pieces for maximum tweetability.
Should I go back through this development diary and cut all the pieces down, make every sentence tweetable?
Because that may be how it's understood. Someone will understand this bookmarklet as a way to 

There is very little that is small now.
jQuery
jQuery UI
It can be hard for 

IE7--do I care about these people? I have an internalized guilt about them. My mind immediately goes to some person in.

The empathy at war with the irony.

This will not be an accessible tool; it will not work in flat-text browsers or in situations where people are browsing without the full access to the DOM. It will work anywhere a browser works, but if you are blink you are on your own.

There's not much I can do about that and still get this done. I'm a parasite upon the web, not a resource.

