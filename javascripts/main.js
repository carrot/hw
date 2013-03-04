$( document ).ready( function() {
  $('section h3').waypoint(function(direction) {
    $('header ul li.waypoint').removeClass('active');
    return $("a[href='#" + ($(this).attr('id')) + "']").parent().addClass('active');
  });
});
