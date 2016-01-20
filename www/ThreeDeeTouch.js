var exec = require("cordova/exec");

var ThreeDeeTouch = function () {
};

ThreeDeeTouch.prototype.isAvailable = function (onSuccess) {
  exec(onSuccess, null, "ThreeDeeTouch", "isAvailable", []);
};

ThreeDeeTouch.prototype.watchForceTouches = function (onSuccess) {
  exec(onSuccess, null, "ThreeDeeTouch", "watchForceTouches", []);
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

var remainingAttempts = 150;
function waitForIt() {
  if (window.ThreeDeeTouch && typeof window.ThreeDeeTouch.onHomeIconPressed === "function") {
    exec(null, null, "ThreeDeeTouch", "deviceIsReady", []);
  } else if (remainingAttempts-- > 0) {
    setTimeout(waitForIt, 100);
  }
}

// Call the plugin as soon as deviceready fires, this makes sure the webview is loaded, way more solid than relying on native's pluginInitialize.
// Still, if the first attempt fails we will re-check for a little while because a fwk like Meteor will only make the function available after a little while.
document.addEventListener('deviceready', waitForIt, false);
