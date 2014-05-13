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
      ]
    }, {
      autoplay:  'autoplay',
      controls:  false, // default: 'controls'
      loop:      'loop',
      muted:     'muted',
      poster:    null, // default: url to image
      preload:   'auto' // auto | metadata | none
      } 
    );
  }
});
```
