var doc = $(document);

// make sure all external links are opened in the browser
doc.find("div[aria-label=\"Message thread contents\"]").on("click", "a", function(e) {
  if ($(this).prop("target") == "_blank") {
    var location = $(this).prop("href");
    open_externally(location);
    return false; // prevent further handling
  }
});

// add the eggplant button
setTimeout(function() {
  doc.find("._2pt").append("<a href=\"#\" id=\"_custom_eggplant_button\" onmouseup=\"" +
    "var textarea = document.getElementsByName('message_body')[0], text = '\uD83C\uDF46';" +
    "console.log(text); var scroll = textarea.scrollTop, caret = textarea.selectionStart;" +
    "var before = textarea.value.substring(0, caret), after = textarea.value.substring(textarea.selectionEnd, textarea.value.length);" +
    "textarea.value = before + text + after; caret += text.length; textarea.selectionStart = caret; textarea.selectionEnd = caret;" +
    "textarea.focus(); textarea.scrollTop = scroll; return false;" +
    "\">\uD83C\uDF46</a>");
}, 2000);

var last_notification;
var last_count;
function dockCount() {
  var unreadBadge = doc.find(".pls._1r.fwn").first(); // obtain the unread count badge on the inbox
  if (unreadBadge.hasClass("hidden_elem")) { // unread badge not shown, there are no new messages
    if (last_count !== 0) badge_count(0);
  } else { // there are unread messages
    var title = doc.find('._kx ._l2 ._l1').first().text(); // obtain the title of the first unread covnersation
    var text = doc.find('._kx ._l3').first().text(); // obtain the most recent message in the first unread conversation
    if (last_notification != title + text) {
      notify(title, text);
      last_notification = title + text;
    }
    
    var count = parseInt(doc.find(".pls._1r.fwn").text().replace(/\D/g, ""));
    if (last_count !== count) {
      badge_count(count);
      last_count = count;
    }
  }
}

var process = require("process");
console.log(process.env);

setInterval(dockCount, 200);
