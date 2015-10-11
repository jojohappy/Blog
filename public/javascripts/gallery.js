$( document ).ready(function() {
  $(".div-content").css('min-height', $(window).height() - 260 + "px");
  $(".div-detail-content").css('min-height', $(window).height() - 260 + "px");

  $('.a-delete-gallery').click(function(e) {
    e.preventDefault();
    var r = confirm("Delete this Gallerys?");
    if (r) {
      var id = $(this).attr('id');
      $.ajax({
        url: '/admin/gallery/' + id,
        method: 'delete',
        success: function() {
          window.location.href = '/gallery';
        },
        error: function() {
        }
      });
    }
  });

  $('.a-ripple').click(function(e) {
    e.preventDefault();
    var id = $(this).attr('id');
    var self = this;
    $.ajax({
      url: '/gallery/' + id + '/ripple',
      method: 'post',
      contentType: 'text/plain',
      dataType: 'text',
      success: function(data) {
        $(self).html('<i class="fa fa-heart"></i>       ' + data);
      },
      error: function() {
      }
    });
  });

});

$(window).resize(function() {
  $(".div-content").css('min-height', $(window).height() - 260 + "px");
  $(".div-detail-content").css('min-height', $(window).height() - 260 + "px");
});