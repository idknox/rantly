$(document).ready(function () {
  $('.new-rant').on('click', function () {

    var userId = $(this).data('user-id');
    var subject = $('.rant-subject').val();
    var body = $('.rant-body').val();
    var newRant = {rant: {subject: subject, body: body}};

    var promiseOfResult = $.post('/users/' + userId + '/rants', newRant);
    promiseOfResult.success(function (errors) {
      if (errors.errors) {
        $('.errors').html(errors.errors.base)
      } else {
        location.reload();
      }
    });
  })
});