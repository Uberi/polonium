var fs = require("fs");
var path = require("path");

var $ = require("jquery");
var notifier = require("node-notifier");
var gui = require("nw.gui");
var request = require("request");

// show the GUI
var win = gui.Window.get()
var window_active = true;
win.on("focus", function() { window_active = true; });
win.on("blur", function() { window_active = false; });

var frame = $("#main");

var injectCSS = fs.readFileSync(path.resolve("resources", "inject.css"), "utf8");
var injectJS = fs.readFileSync(path.resolve("resources", "inject.js"), "utf8");

// attempt to auto-update the injected stuff in case Facebook changes
request.get("https://raw.githubusercontent.com/Uberi/polonium/master/resources/inject.js", function (error, response, body) {
  if (!error && response.statusCode === 200) injectJS = body;
});
request.get("https://raw.githubusercontent.com/Uberi/polonium/master/resources/inject.css", function (error, response, body) {
  if (!error && response.statusCode === 200) injectCSS = body;
});

var badge_count = function(count) {
  console.log(count);
}

var notify = function(title, message) {
  if (window_active) return; // do nothing if the window is currently active
  notifier.notify({
    title: title,
    message: message,
    icon: path.resolve("resources", "icon.png"),
    sound: true,
  });
}

var open_externally = function(URL) {
  gui.Shell.openExternal(URL);
}

var beautify = function() {
  var doc = frame.contents();
  
  // inject the custom stylesheet
  style = doc[0].createElement("style"); style.type = "text/css";
  style.appendChild(doc[0].createTextNode(injectCSS));
  doc.find("head").append(style);
  
  // inject the custom script
  var injected = new Function("document", injectJS);
  injected(doc[0]);
}
frame.load(beautify); // run whenever the frame loads a document
