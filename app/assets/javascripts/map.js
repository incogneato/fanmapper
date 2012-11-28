var currentMarkers = [];
var Map = {
  init: function() {
    Map.getUserLocation(function(position) {
      // Map.setCurrentLocation(position);
      map = Map.drawMap(position); 
    });
    $('a.update-bars').on('ajax:success', this.setMarkers);
    $('a.clear-map').on('ajax:success', this.clearMarkers);
  },

  clearMarkers: function(event, data) {
    for (i in currentMarkers) {  
      currentMarkers[i].setMap(null);
    }
  },

  setMarkers: function(event, data) {
    Map.clearMarkers();
    var locations = data.local_bars
    for (var i = 0; i < locations.length; i++) {
      var bar = locations[i];
      var myLatLng = new google.maps.LatLng(bar[1], bar[2]);
      var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          title: bar[0]
      });
      currentMarkers.push(marker);
    }
  },

  drawMap: function(position) {
    var mapOptions = {
      zoom: 13,
      center: new google.maps.LatLng(position.latitude, position.longitude-.055),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      disableDefaultUI: true
    }
    return new google.maps.Map($('#map_canvas')[0], mapOptions);
  },

  getUserLocation: function(callback_function) {
    navigator.geolocation.getCurrentPosition(function(position) {
    callback_function(position.coords);
    });
  },

  // setCurrentLocation: function(position) {
  //   var $updateAnchor = $('a.update-bars');
  //   var link = $updateAnchor.attr('href');
  //   // alert(link);
  //   $updateAnchor.attr('href', link+'?lng='+position.longitude+'&lat='+position.latitude);
  //   //$updateAnchor.click();
  // }
 };

 $(document).ready(function() { Map.init(); });
