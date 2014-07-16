$(document).ready(function(){

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
