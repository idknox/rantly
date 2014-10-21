$(document).ready(function () {
  $('body').on('click', '.favorite-button', function () {
    var userId = $(this).parents('.rant').first().data('user');
    var rantId = $(this).parents('.rant').first().data('rant');
    var favoriteCount = $(this).parents('.rant').first().data('fav-count');

    var toggleFavoriteButton = function (button) {
      favoriteCount += 1;
      button.empty().append(favoriteCount + ' - Unfavorite').removeClass('favorite-button')
        .addClass('unfavorite-button')
    };

    var promiseOfResult = $.get("/users/" + userId + "/rants/" + rantId + '/favorite');
    promiseOfResult.success(toggleFavoriteButton($(this)));
  });

  $('body').on('click', '.unfavorite-button', function () {
    var userId = $(this).parents('.rant').first().data('user');
    var rantId = $(this).parents('.rant').first().data('rant');
    var favoriteCount = $(this).parents('.rant').first().data('fav-count');

    var toggleUnfavoriteButton = function (button) {
      button.empty().append(favoriteCount + ' - Favorite').removeClass('unfavorite-button')
        .addClass('favorite-button');
    };

    var promiseOfResult = $.get("/users/" + userId + "/rants/" + rantId + "/unfavorite");
    promiseOfResult.success(toggleUnfavoriteButton($(this)));
  });

});