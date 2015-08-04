$(document).ready(function() {
  $("#divMenu").click(function() {
    if($("#divMenu").hasClass('fa-arrow-left')) {
      $("#divSearchForm").hide();
      $("#spanBlogTitle").show();
      $("#divSearch").show();
      $("#divMenu").removeClass('fa-arrow-left');
      $("#divMenu").addClass('fa-bars');
      return;
    }
    if($("#divCategory").css('display') == 'none') {
      $("#divCategory").show();
    }
    else {
      $("#divCategory").hide();
    }
  });

  $("#divSearch").click(function() {
    if($("#divSearchForm").css('display') == 'none') {
      $("#divSearchForm").show();
      $("#spanBlogTitle").hide();
      $("#divSearch").hide();
      $("#divMenu").removeClass('fa-bars');
      $("#divMenu").addClass('fa-arrow-left');
      $("#divCategory").hide();
    }

  });

  $(".quote-tag").click(function(e) {
    if (e.stopped) return;
    e.preventDefault(); e.stopped = true;
    $.ajax({
      url: '/comment/quote',
      data: {'id': $(this).attr('id')},
      method: 'get',
      contentType: 'text/plain',
      success: function(data) {
        var body = $('textarea#comment_content').val() + data;
        $('textarea#comment_content').val(body);
        $('textarea#comment_content').focus();
      },
      error: function(status, error) {
      }
     });
  });

  $('.form-remote').submit(function(ev){
    ev.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      data: $(this).serialize(),
      method: $(this).attr('method') || 'get',
    });
  });

  $('.md-preview').click(function(e) {
    $.ajax({
      url: '/comment/preview',
      data: {'data': $('#comment_content').val()},
      method: 'get',
      contentType: 'text/plain',
      success: function(data) {
        $('#comment_content_preview').html(data);
      },
      error: function(status, error) {
      }
    });

    if (!$(this).hasClass('has_preview')) {
      $('#comment_content_preview').removeClass('hidden');
      $('#comment_content').addClass('hidden');
      $(this).addClass('has_preview');
      $(this).html('Cancel');
    }
    else {
      $('#comment_content_preview').addClass('hidden');
      $('#comment_content').removeClass('hidden');
      $(this).removeClass('has_preview');
      $(this).html('Preview');
      $('#comment_content_preview').html("");
    }
  });
  $(".div-content-main").css('min-height', $(window).height() - $('.div-footer').height() + "px");

  $('#divSearchIcon').click(function(e) {
    if($(".search-form-input-t").css('display') == 'none') {
      $(".search-form-input-t").show();
      $(".search-form-input-t").animate({"width": "+=176px"}, 200);
      $(".search-form-input-t").focus();
    }
    else {
      $(".search-form-input-t").animate({"width": "-=176px"}, 200, function() {
        $('.search-form-input-t').hide();
      });
    }
  });

  $('.blog-edit-tag').click(function() {
    value = $('.tag-edit-text').val();
    if ('' === value)
      value = $(this).attr('name');
    else
      value = value + ', ' + $(this).attr('name');
    $('.tag-edit-text').val(value);
  });
});

$(window).resize(function() {
  $(".div-content-main").css('min-height', $(window).height() - $('.div-footer').height() + "px");
});