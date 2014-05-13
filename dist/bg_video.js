var BgVideo, root;

root = typeof exports !== "undefined" && exports !== null ? exports : this;

$.supportsVideo = function() {
  return !!document.createElement("video").canPlayType;
};

BgVideo = (function() {
  var mimeTypes;

  mimeTypes = {
    'mp4': 'video/mp4',
    'm4v': 'video/mp4',
    'ogv': 'video/ogg',
    'webm': 'video/webm'
  };

  function BgVideo($elm, options, nativeAttributes) {
    this.$elm = $elm;
    this.settings = {
      debug: false,
      sources: [],
      fallback: true
    };
    this.attributes = {
      autoplay: 'autoplay',
      controls: false,
      loop: 'loop',
      muted: 'muted',
      poster: null,
      preload: 'auto'
    };
    this.settings = $.extend(this.settings, options);
    this.attributes = $.extend(this.attributes, nativeAttributes);
    this.$video = this.createVideoTag();
    $(this.$elm).replaceWith(this.$video);
  }

  BgVideo.prototype.play = function() {
    return this.$video.get(0).play();
  };

  BgVideo.prototype.pause = function() {
    return this.$video.get(0).pause();
  };

  BgVideo.prototype.mute = function() {
    return this.$video.prop('muted', true);
  };

  BgVideo.prototype.unmute = function() {
    return this.$video.prop('muted', false);
  };

  BgVideo.prototype.createVideoTag = function() {
    var $video, source, _i, _len, _ref;
    $video = $('<video />');
    $('body').css('overflow', 'hidden');
    $video.css({
      position: 'absolute',
      top: 0,
      left: 0,
      minWidth: '100%',
      minHeight: '100%',
      width: 'auto',
      height: 'auto',
      zIndex: '-1000',
      overflow: 'hidden'
    });
    $.each(this.attributes, function(key, val) {
      if (val !== null) {
        return $video.attr(key, val);
      }
    });
    _ref = this.settings.sources;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      source = _ref[_i];
      this.appendSource($video, source);
    }
    return $video;
  };

  BgVideo.prototype.appendSource = function($video, source) {
    var mimeType;
    mimeType = this.detectMimeType(source);
    return $('<source />').attr('src', source).attr('type', mimeType).appendTo($video);
  };

  BgVideo.prototype.detectMimeType = function(source) {
    var ext;
    ext = source.split('.').pop().toLowerCase();
    return mimeTypes[ext];
  };

  return BgVideo;

})();

root.BgVideo = BgVideo;
