$( document ).ready( function() {
  waypoints = $('header ul li.waypoint');

  $('section h3')
    .waypoint(function(direction) {
      if (direction === 'down') {
        return update_waypoints(this);
      }
    }, { offset: 47 })
    .waypoint(function(direction) {
      if (direction === 'up') {
        return update_waypoints(this);
      }
    }, { offset: -5 });
});

function update_waypoints(waypoint) {
  waypoints.removeClass('active');
  return $("a[href='#" + waypoint.id + "']").parent().addClass('active');
}
