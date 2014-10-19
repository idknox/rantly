$(document).ready(function () {

  $('.follow-button').on('click', function () {
    var toggleFollowButton = function (button) {
      button.removeClass('follow-button').addClass('unfollow-button').empty()
        .append('Unfollow');
    };

    var id = $(this).parents('.rant').first().data('followee');
    var promiseOfResult = $.get("/" + id + "/follow", {followee_id: id});
    promiseOfResult.success(toggleFollowButton($(this)));
  });

  $('.unfollow-button').on('click', function () {
    var toggleUnfollowButton = function (button) {
      console.log(button);
      button.empty().append('Follow').removeClass('unfollow-button')
        .addClass('follow-button');
    };

    var id = $(this).parents('.rant').first().data('followee');
    var promiseOfResult = $.get("/" + id + "/unfollow", {followee_id: id});
    promiseOfResult.success(toggleUnfollowButton($(this)));
  })
});