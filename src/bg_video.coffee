root = exports ? this

$.supportsVideo = -> !!document.createElement("video").canPlayType

class BgVideo

  mimeTypes = {
    'mp4': 'video/mp4'
    'm4v': 'video/mp4'
    'ogv': 'video/ogg'
    'webm': 'video/webm'
  }

  constructor: ($elm, options, nativeAttributes) ->

    @settings =
      sources:    []

    @attributes =
      autoplay:  'autoplay'
      controls:  false # default: 'controls'
      loop:      'loop'
      muted:     'muted'
      poster:    null # default: url to image
      preload:   'auto' # auto | metadata | none

    @settings = $.extend @settings, options
    @attributes = $.extend @attributes, nativeAttributes
    @$video = @createVideoTag()
    $(@$elm).replaceWith @$video

  play: ->
    @$video.get(0).play()
  pause: ->
    @$video.get(0).pause()
  mute: ->
    @$video.prop 'muted', true
  unmute: ->
    @$video.prop 'muted', false

  createVideoTag: ->
    $video = $('<video />')
    $('body').css 'overflow', 'hidden' # hide scrollbars

    $video.css
      position:   'absolute'
      top:        0
      left:       0
      minWidth:   '100%'
      minHeight:  '100%'
      width:      'auto'
      height:     'auto'
      zIndex:     '-1000'
      overflow:   'hidden'

    $.each @attributes, (key, val) -> unless val is null then $video.attr(key, val)
    @appendSource($video, source) for source in @settings.sources
    $video

  appendSource: ($video, source) ->
    mimeType = @detectMimeType source
    $('<source />').attr('src', source).attr('type', mimeType).appendTo $video

  detectMimeType: (source) ->
    ext = source.split('.').pop().toLowerCase()
    mimeTypes[ext]

root.BgVideo = BgVideo
