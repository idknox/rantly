$(document).ready(function () {

  $('body').on('click', '.fa-caret-down', function () {
    $(this).addClass('fa-caret-up').removeClass('fa-caret-down')
    toggleSort();
  });

  $('body').on('click', '.fa-caret-up', function () {
    $(this).addClass('fa-caret-down').removeClass('fa-caret-up')

  });
});