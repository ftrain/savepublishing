chrome.browserAction.onClicked.addListener(function(tab) {
// the bookmarklet javascript, hacked to load savepublishing.js from
// locally inside the extension.
  var sp_url = chrome.extension.getURL("savepublishing.js");
  var action_url = "javascript:(function(e,a,g,h,f,c,b,d){if(!(f=e.jQuery)||g>f.fn.jquery||h(f)){c=a.createElement('script');c.type='text/javascript';c.src='//ajax.googleapis.com/ajax/libs/jquery/'+g+'/jquery.min.js';c.onload=c.onreadystatechange=function(){if(!b&&(!(d=this.readyState)||d=='loaded'||d=='complete')){h((f=e.jQuery).noConflict(1),b=1);f(c).remove()}};a.body.appendChild(c);}})(window,document,'1.8.3',function($,L){y=document.createElement('script');y.type='text/javascript';y.src='//platform.twitter.com/widgets.js';z=document.createElement('script');z.type='text/javascript';z.src='//ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js';x=document.createElement('script');x.type='text/javascript';x.src='"+sp_url+"';window.JQ=$;window.jQuery=$;document.body.appendChild(y);document.body.appendChild(z);document.body.appendChild(x);});";
  chrome.tabs.update(tab.id, {url: action_url});
});