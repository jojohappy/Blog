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
});