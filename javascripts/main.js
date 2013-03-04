$( document ).ready( function() {
  waypoints = $('header ul li.waypoint');

  $('section h3').waypoint(function(e) {
    waypoints.removeClass('active');
    return $("a[href='#" + e.target.id + "']").parent().addClass('active');
  });
});
