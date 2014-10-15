$(document).ready(function () {

  $('.follow-button').on('click', function () {
    var toggleButton = function () {
      console.log($(this));
      $(this).hide();
      $(this).sibling('a').show();
    };

    var id = $(this).parents('.rant').first().data('followee');
    var promiseOfResult = $.getJSON("/" + id + "/follow", {followee_id: id});
    promiseOfResult.success(toggleButton);
  })
});