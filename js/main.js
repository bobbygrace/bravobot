$(document).ready(function(){

  // Fill the Message

  function getQueryVariable(variable) {
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i=0;i<vars.length;i++) {
      var pair = vars[i].split("=");
      if(pair[0] == variable){
        return decodeURIComponent(pair[1]);
      }
    }
    return(false);
  }

  var toStr = getQueryVariable("to");
  var msgStr = getQueryVariable("msg");
  var fromStr = getQueryVariable("from");

  if(fromStr === false) {
    var fromStr = "your secret admirer <3";
  };

  $(".js-to").text(toStr);
  $(".js-msg").text(msgStr);
  $(".js-from").text(fromStr);


  // Background Image

  var backgroundImages = [
    "bear.jpg",
    "fox.jpg",
    "fireworks.jpg",
    "panda.jpg",
    "woof.jpg",
    "lizard.jpg",
    "owl.jpg",
    "party.png"
  ];

  function getRandomImage() {
    return backgroundImages[Math.floor(Math.random() * backgroundImages.length)];
  };

  var backgroundImageUrl = "url('images/" + getRandomImage() + "')";

  $(".js-background").css({
    "background-image": backgroundImageUrl
  });


  // Background Color

  function getRandomHue() {
    return Math.floor(Math.random() * 360) + 1
  };

  function getRandomBackgroundColor() {
    return "hsl(" + getRandomHue() + ", 40%, 50%)"
  };

  $(".js-bravo-box").css({
    "background-color": getRandomBackgroundColor()
  });

});
