# SavePublishing.com

## What is this supposed to do?

SavePublishing is a bookmarklet, mostly in CoffeeScript, that looks at a web page and decides which statements are tweetable. It does this by length. The sentences are turned into links.

It /could/ if there were demand be a way to turn any aspect of the DOM that can be quickly auto-identified inside a browser into a "shareable" component. But right now the focus is on tweets and handling the incredible strangeness of the DOM, with a very specific use-case (i.e. this is emphatically _not_ [Readability](http://www.readability.com); the focus is on finding appropriately-sized things to share, very quickly, totally on the client-side).

## What is this repo, specifically?

This repository is all of the code necessary for a full deploy of SavePublishing.com. Right now the creator of the repo, Paul Ford (<ford@ftrain.com>) is the only person who deploys to SavePublishing.com. Eventually he/I hope to move everything to S3 and automate a little more.

As noted, the code is written in CoffeeScript, with the exception of the bookmarklet itself, which is just JavaScript with a javascript: prefix.

The coffeescript source is in 
https://github.com/ftrain/savepublishing/tree/master/htdocs/coffee

- This is all a hot mess right now.
- There's very little testing, just a reloadable page with text samples, and that's poorly used.
- The `docco` docs are a mess.
- And so forth. It's pre-alpha, basically.

## Want to help?
Involved folks are welcome to fork away. I'll likely be very permissive about merges that 
try to meet the use case described above, namely:

> the focus is on finding appropriately-sized things to share, very quickly, totally on the client-side

I'll do my best to keep a good branch live at savepublishing.com.

## Milestones

### Bugfix:

https://github.com/ftrain/savepublishing/issues?milestone=4&state=open

There are a lot of BUGFIX issues, mostly related to sites that don't parse. Because the bookmarklet needs to choose between nav/ads and not-nav-ads, there are a lot of false positives and some false negatives. It's an ongoing concern. Some issues are easy to fix; some are tiny; some will likely never be fixed.

No deadline.

### Beta

https://github.com/ftrain/savepublishing/issues?milestone=3&state=open

The "Beta." I'll probably deploy whenever anything interesting happens, but I want to prioritize bugfixes over features, so I'm using a "Bugfix"/"Beta" milestone concept to keep things clear.

No deadline.

### 1.0 or Wishlist

https://github.com/ftrain/savepublishing/issues?milestone=5&state=open

A place to put more ambitious ideas.

No deadline.



