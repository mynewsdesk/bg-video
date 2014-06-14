# BgVideo

Display HTML5 video backgrounds in fullscreen.

## Install via Bower

bower install bg-video

## Test for HTML5 video support

```javascript
if($.supportsVideo()) {
  // initialize code
}
```

... or with Modernizr

```javascript
if(Modernizr.video) {
  // initialize code
}
```

## Setup
```javascript
$(function() {
  if($.supportsVideo()) {
    var video = new BgVideo($('#some_element'), {
      sources: [
        'http://techslides.com/demos/sample-videos/small.mp4',
        'http://techslides.com/demos/sample-videos/small.webm',
        'http://techslides.com/demos/sample-videos/small.ogv'
      ],
      cssPosition: 'absolute', // static|absolute|fixed
      alignment: 'top left', // top left|top right|bottom left|bottom right
      hideBodyScrollbars: true, // set body to overflow:hidden
      resizeWithWindow: true, // resize video on window.resize
      attachImmediately: true // attach video immediately to the DOM
    }, {
      autoplay:  true,
      controls:  false,
      loop:      true,
      muted:     true,
      poster:    null, // default: url to image
      preload:   'auto' // auto | metadata | none
      }
    );
  }
});
```
### Methods
```javascript
...
video.play();
video.pause();
video.mute();
video.unmute();
video.destroy();
video.detach();
video.attach();
...
```
