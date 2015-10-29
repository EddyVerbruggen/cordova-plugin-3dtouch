# 3D Touch Cordova plugin
by [Eddy Verbruggen](http://twitter.com/eddyverbruggen)

## 0. Index

1. [Description](#1-description)
2. [Screenshots](#2-screenshots)
3. [Installation](#3-installation)
4. [Usage](#4-usage)
5. [Changelog](#5-changelog)

## 1. Description

Add 3D Touch capabilities to your Cordova app:
* Quick Action for Home Screen icons
* Enable Link preview for external links

## 2. Screenshots

<img src="screenshots/icon-actions-2.PNG" width="235"/>&nbsp;
<img src="screenshots/icon-actions-4.PNG" width="235"/>&nbsp;
<img src="screenshots/link-preview.PNG" width="235"/>&nbsp;

## 3. Installation

Latest stable version from npm:
```
$ cordova plugin add cordova-plugin-3dtouch
```

Bleeding edge version from Github:
```
$ cordova plugin add https://github.com/EddyVerbruggen/cordova-plugin-3dtouch
```

`ThreeDeeTouch.js` is brought in automatically.
It adds a global `ThreeDeeTouch` object which you can use to interact with the plugin.

## 4. Usage

Check the [demo code](demo/index.html) for all the tricks in the book!

Make sure to wait for `deviceready` before using any of these functions.

Note that all these functions have optional callbacks, but mostly they're irrelevant,
except for the first function here:

### isAvailable
You need an iPhone 6S or some future tech to use the features of this plugin,
so you can check at runtime if the user's device is supported.

```js
  ThreeDeeTouch.isAvailable(function (avail) {
    // 'avail' is a boolean
    alert("avail? " + avail)
  });
```

### configureQuickActions
When your app starts you can add those fancy Quick Actions to the Home Screen icon.
You can configure up to four icons and they are 'cached' until you pass in a new set of icons.
So you don't need to do this every time your app loads, but it can't really hurt.

There are two types of icons supported currently" `iconType` and `iconTemplate`.

##### iconType
A value from a (case insensitive) fixed list of icons which have been provided by Apple and look great:
* iOS 9.0: Compose, Play, Pause, Add, Location, Search, Share
* iOS 9.1: Prohibit, Contact, Home, MarkLocation, Favorite, Love, Cloud, Invitation, Confirmation, Mail, Message, Date, Time, CapturePhoto, CaptureVideo, Task, TaskCompleted, Alarm, Bookmark, Shuffle, Audio, Update

##### iconTemplate
Can be used to provide your own icon. It must be a valid name of an icon template in your Assets catalog.


The `type` param is the most convenient way to relate the icon to the event you'll receiver when
the icon was used to launch your app. So make sure it's unique amongst your icons.

```js
  ThreeDeeTouch.configureQuickActions([
    {
      type: 'checkin', // optional, but can be used in the onHomeIconPressed callback
      title: 'Check in', // mandatory
      subtitle: 'Quickly check in', // optional
      iconType: 'Compose' // optional
    },
    {
      type: 'share',
      title: 'Share',
      subtitle: 'Share like you care',
      iconType: 'Share'
    },
    {
      type: 'search',
      title: 'Search',
      iconType: 'Search'
    },
    {
      title: 'Show favorites',
      iconTemplate: 'HeartTemplate' // from Assets catalog
    }
  ]);
}
```

### onHomeIconPressed
When a home icon is pressed, your app launches and this JS callback is invoked. I found it worked
reliable when you use it like this (you should recognize the `type` params used previously):

```js
  document.addEventListener('deviceready', function () {
    ThreeDeeTouch.onHomeIconPressed = function (payload) {
      console.log("Icon pressed. Type: " + payload.type + ". Title: " + payload.title + ".");
      if (payload.type == 'checkin') {
        document.location = 'checkin.html';
      } else if (payload.type == 'share') {
        document.location = 'share.html';
      } else {
        // hook up any other icons you may have and do something awesome (e.g. launch the Camera UI, then share the image to Twitter)
        console.log(JSON.stringify(payload));
      }
    }
  }, false);
```

### enableLinkPreview
UIWebView and WKWebView (the webviews powering Cordova apps) don't allow the fancy new link preview feature
of iOS9. If you have a 3D Touch enabled device though, you sometimes are allowed to force press a link and a
preview pops up (see the screenshot above). If you want to enable this feature, do:
```js
  ThreeDeeTouch.enableLinkPreview();
```

### disableLinkPreview
To disable the link preview feature again, do:
```js
  ThreeDeeTouch.disableLinkPreview();
```

## 5. Changelog
* 1.2.0 iOS 9.1 added a lot of new iconTypes to choose from. Thanks #2!
* 1.1.0 Found a solid way to deal with timing when to call into `onHomeIconPressed`. Should always work now, even on coldstart.
* 1.0.1 Increased the timeouts a bit, so there is a better chance `onHomeIconPressed` gets called on coldstart. Thanks [#1](https://github.com/EddyVerbruggen/cordova-plugin-3dtouch/issues/1).
* 1.0.0 Initial release (untagged)
