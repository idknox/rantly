$(document).ready(function () {


  $('nav div a').on('click', function () {
    $(this).addClass('active');
    $(this).parents().siblings().children().removeClass('active');
  });

  var stopFlash = function () {
    $('.flash').slideUp()
  };

  window.setTimeout(stopFlash, 5000);

});