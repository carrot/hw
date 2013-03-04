$( document ).ready( function() {
  waypoints = $('header ul li.waypoint');

  // $('section h3').waypoint(function() {
  //   console.log(this.id);
  //   waypoints.removeClass('active');
  //   return $("a[href='#" + this.id + "']").parent().addClass('active');
  // }, { offset: 47 });

  $('section h3')
    .waypoint(function(direction) {
      if (direction === 'down') {
        console.log(direction);
        waypoints.removeClass('active');
        return $("a[href='#" + this.id + "']").parent().addClass('active');
      }
    }, { offset: 47 })
    .waypoint(function(direction) {
      if (direction === 'up') {
        console.log(direction);
        waypoints.removeClass('active');
        return $("a[href='#" + this.id + "']").parent().addClass('active');
      }
    }, { offset: -5 })
});
