$(document).ready(function () {

  $('nav div a').first().addClass('active');

  $('nav div a').on('click', function () {
    $(this).addClass('active');
    $(this).parents().siblings().children().removeClass('active');
  });

});