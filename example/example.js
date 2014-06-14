$(function() {
  if ($.supportsVideo()) {
    window.video = new BgVideo($("#bg_video"), {
      alignment: "top right",
      sources: ["http://techslides.com/demos/sample-videos/small.mp4", "http://techslides.com/demos/sample-videos/small.webm", "http://techslides.com/demos/sample-videos/small.ogv"],
      cssPosition: "fixed",
      attachImmediately: true
    });

    $('#toggle-attach').click(function() {
      if($(this).data('attached')) {
        video.attach();
        video.play();
        return $(this).data("attached", false);
      }
      else {
        video.detach();
        return $(this).data("attached", true);
      }
    });


    $("#toggle-play").click(function() {
      if ($(this).data("playing")) {
        video.pause();
        return $(this).data("playing", false);
      } else {
        video.play();
        return $(this).data("playing", true);
      }
    }).focus();
  } else {
    return alert("Your browser does not support HTML5 video");
  }
});
