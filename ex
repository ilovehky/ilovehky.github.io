////////////////////////////////////////
// 1. This GSAP code fires onComplete after animation then plays the video

// GSAP code below
$(document).ready(function() {

  $(window).on("load", function() {

    /* this one doesn't work in a linear fashion */
    var obj = document.getElementById("overlayFrame");

    TweenMax.fromTo(obj, 3, {
      autoAlpha: 0,
      rotation: 0,
      delay: 2
    }, {
      autoAlpha: 1,
      rotation: 360,
      onCompleteParams: [obj],
      onComplete: toggle
    });

    function toggle(o) {
      TweenMax.to(o, 1, {
        backgroundColor: "#CC0000"
      });
      $("#msg").html("Box onComplete fired and YouTube plays video");
      //console.log(o);

      player.playVideo();
    }

  });
});

////////////////////////////////////////
// 2. This code loads the IFrame Player API code asynchronously.
var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

////////////////////////////////////////
// 3. This function creates an <iframe> (and YouTube player)
//    after the API code downloads.
var player;

function onYouTubeIframeAPIReady() {
  player = new YT.Player('player', {
    height: '268',
    width: '440',
    videoId: 'M7lc1UVf-VE',
    events: {
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange
    }
  });
}

////////////////////////////////////////
// 4. The API will call this function when the video player is ready.
function onPlayerReady(event) {
  event.target.stopVideo();
}

// 5. The API calls this function when the player's state changes.
//    The function indicates that when playing a video (state=1),
//    the player should play for six seconds and then stop.
var done = false;

function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.PLAYING && !done) {
    setTimeout(stopVideo, 6000);
    done = true;
  }
}

function stopVideo() {
  player.stopVideo();
}

function pauseVideo() {
  player.pauseVideo();
}