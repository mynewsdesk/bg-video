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

    @$elm = $elm

    @$detachedElm = null

    @settings =
      sources:    []
      cssPosition: 'absolute' # static|fixed|absolute
      alignment: 'top left' # top left|top right|bottom left|bottom right
      hideBodyScrollbars: true

    @attributes =
      autoplay:  'autoplay'
      controls:  false # default: 'controls'
      loop:      'loop'
      muted:     'muted'
      poster:    null # default: url to image
      preload:   'auto' # auto | metadata | none

    @settings = $.extend @settings, options
    @attributes = $.extend @attributes, nativeAttributes
    if @settings.hideBodyScrollbars then $('body').css 'overflow', 'hidden' # hide scrollbars
    @$video = @createVideoTag()
    $elm.append @$video

  play: ->    @$video.get(0).play()
  pause: ->   @$video.get(0).pause()
  mute: ->    @$video.prop 'muted', true
  unmute: ->  @$video.prop 'muted', false

  alignmentPosition: ->
    switch @settings.alignment
      when 'top right' then { top: 0, right: 0 }
      when 'bottom left' then { bottom: 0, left: 0 }
      when 'bottom right' then { bottom: 0, right: 0 }
      else { top: 0, left: 0 }

  createVideoTag: ->
    $video = $('<video />')
    css =
      position:   @settings.cssPosition
      minWidth:   '100%'
      minHeight:  '100%'
      width:      'auto'
      height:     'auto'
      zIndex:     '-1000'
      overflow:   'hidden'

    $video.css $.extend(css, @alignmentPosition())

    $.each @attributes, (key, val) -> unless val is null then $video.attr(key, val)
    @appendSource($video, source) for source in @settings.sources
    $video

  appendSource: ($video, source) ->
    mimeType = @detectMimeType source
    $('<source />').attr('src', source).attr('type', mimeType).appendTo $video

  detectMimeType: (source) ->
    ext = source.split('.').pop().toLowerCase()
    mimeTypes[ext]

  destroy: ->
    @pause()
    @$video.remove()

  detach: ->
    @pause()
    @$detachedElm = @$video.detach()

  reAttach: ->
    if @$detachedElm?
      @$elm.append @$video
      @play()
      @$detachedElm = null

root.BgVideo = BgVideo
