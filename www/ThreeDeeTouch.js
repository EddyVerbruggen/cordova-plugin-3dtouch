var exec = require("cordova/exec");

var ThreeDeeTouch = function () {
};

ThreeDeeTouch.prototype.isAvailable = function (onSuccess) {
  exec(onSuccess, null, "ThreeDeeTouch", "isAvailable", []);
};

ThreeDeeTouch.prototype.enableLinkPreview = function (onSuccess) {
  exec(onSuccess, null, "ThreeDeeTouch", "enableLinkPreview", []);
};

ThreeDeeTouch.prototype.disableLinkPreview = function (onSuccess) {
  exec(onSuccess, null, "ThreeDeeTouch", "disableLinkPreview", []);
};

ThreeDeeTouch.prototype.configureQuickActions = function (icons, onSuccess, onError) {
  exec(onSuccess, onError, "ThreeDeeTouch", "configureQuickActions", [icons]);
};

module.exports = new ThreeDeeTouch();

// call the plugin as soon as deviceready fires, this makes sure the webview is loaded,
// way more solid than relying on native's pluginInitialize.
document.addEventListener('deviceready', function() {
  exec(null, null, "ThreeDeeTouch", "deviceIsReady", []);
}, false);
