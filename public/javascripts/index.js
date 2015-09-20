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

  $('.form-remote').submit(function(ev){
    ev.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      data: $(this).serialize(),
      method: $(this).attr('method') || 'get',
    });
  });

  $(".div-content-main").css('min-height', $(window).height() - $('.div-footer').height() + "px");

  $('#divSearchIcon').click(function(e) {
    if($(".search-form-input-t").css('display') == 'none') {
      $(".search-form-input-t").show();
      $(".search-form-input-t").animate({"width": "+=150px"}, 200);
      $(".search-form-input-t").focus();
    }
    else {
      $(".search-form-input-t").animate({"width": "-=150px"}, 200, function() {
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

  $('.a-delete-blog').click(function() {
    var r = confirm("Delete this Blog?");
    if (r === true) {
      blogid = $(this).attr('id');
      $.ajax({
        url: '/admin/blog/' + blogid,
        method: 'delete',
        contentType: 'text/plain',
        dataType: 'text',
        success: function(data) {
          window.location.href = '/';
        },
        error: function(status, error) {
        }
      });
    }
  });

  $('.a-logout').click(function() {
    var r = confirm("Do you want to logout?");
    if (r === true) {
      $.ajax({
        url: '/logout',
        method: 'delete',
        success: function(data) {
          window.location.href = '/';
        },
        error: function(status, error) {
        }
      });
    }
  });

  $(window).on("scroll", function(e) {
    if ($(this).scrollTop() > ($('.div-left-card-img').height())) {
      $('#divCategory').addClass("div-category-fix");
    } else {
      $('#divCategory').removeClass("div-category-fix");
    }

  });
});

$(window).resize(function() {
  $(".div-content-main").css('min-height', $(window).height() - $('.div-footer').height() + "px");
});