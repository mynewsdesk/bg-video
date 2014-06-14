###
# BgVideo v0.0.8 - Fullscreen HTML5 background video
# Author: Emil Löfquist @ Mynewsdesk
# GitHub: https://github.com/mynewsdesk/bg-video
###
root = exports ? this

$.supportsVideo = -> !!document.createElement("video").canPlayType

class BgVideo

  mimeTypes = {
    'mp4':  'video/mp4'
    'm4v':  'video/mp4'
    'ogv':  'video/ogg'
    'webm': 'video/webm'
  }

  constructor: ($elm, options, nativeAttributes) ->

    @$elm = $elm
    @$detachedElm = null

    @settings =
      sources:            []
      cssPosition:        'absolute' # static|fixed|absolute
      alignment:          'top left' # top left|top right|bottom left|bottom right
      hideBodyScrollbars: true
      resizeWithWindow:   true
      attachImmediately:  true

    @attributes =
      autoplay:  true
      controls:  false
      loop:      true
      muted:     true
      poster:    null # default: url to image
      preload:   'auto' # auto | metadata | none

    @settings = $.extend @settings, options
    @attributes = $.extend @attributes, nativeAttributes
    if @settings.hideBodyScrollbars then $('body').css 'overflow', 'hidden' # hide scrollbars
    @$video = @createVideoTag()
    if @settings.attachImmediately then $elm.append @$video

    if @settings.resizeWithWindow
      $(window).on 'resize', => @setVideoDimensions(@$video)

  # Video controls
  play: ->    @$video.get(0).play()
  pause: ->   @$video.get(0).pause()
  mute: ->    @$video.prop 'muted', true
  unmute: ->  @$video.prop 'muted', false

  setVideoDimensions: ($video) ->
    ar = $(window).width() / $(window).height()

    css =
      position:   @settings.cssPosition
      minWidth:   '100%'
      minHeight:  '100%'
      width:      -> if ar < 1.77 then 'auto' else '100%'
      height:     -> if ar > 1.77 then 'auto' else '100%'
      zIndex:     '-1000'
      overflow:   'hidden'

    $video.css $.extend(css, @alignmentPosition())

  alignmentPosition: ->
    switch @settings.alignment
      when 'top right'    then top: 0, right: 0
      when 'bottom left'  then bottom: 0, left: 0
      when 'bottom right' then bottom: 0, right: 0
      else top: 0, left: 0

  createVideoTag: ->
    $video = $('<video />')
    @setVideoDimensions($video)

    $.each @attributes, (key, val) ->
      if typeof val is 'boolean'
        $video.prop(key, true) if val is true
      else
        $video.prop(key, val) unless val is null
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

  attach: ->
    @$elm.append @$video
    @$detachedElm = null
    @settings.attachImmediately = false

root.BgVideo = BgVideo
