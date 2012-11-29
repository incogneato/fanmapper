var Map = {
  currentMarkers: [],
  map: null,

  init: function() {
    Map.getUserLocation(function(position) {
      // Map.setCurrentLocation(position);
      Map.map = Map.drawMap(position); 
    });
    $('a.update-bars').on('ajax:success', this.setMarkers);
    $('a.clear-map').on('ajax:success', this.clearMarkers);
  },

  updateBars: function(event) {
    event.preventDefault();
    var $self = $(this);
  },

  clearMarkers: function(event, data) {
    for (i in Map.currentMarkers) {  
      Map.currentMarkers[i].setMap(null);
    }
  },

  setMarkers: function(event, data) {
    Map.clearMarkers();
    var locations = data.local_bars
    for (var i = 0; i < locations.length; i++) {
      var bar = locations[i];
      var myLatLng = new google.maps.LatLng(bar[1], bar[2]);
      var image = new google.maps.MarkerImage('http://content.update.parallelkingdom.com/hat_blue_football_helmet.png');
      var marker = new google.maps.Marker({
          position: myLatLng,
          map: Map.map,
          icon: image,
          animation: google.maps.Animation.DROP,
          title: bar[0]
      });
      Map.currentMarkers.push(marker);
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


//KEEP THIS FOR A WHILE FOR REFERENCE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // setCurrentLocation: function(position) {
  //   var $updateAnchor = $('a.update-bars');
  //   var link = $updateAnchor.attr('href');
  //   // alert(link);
  //   $updateAnchor.attr('href', link+'?lng='+position.longitude+'&lat='+position.latitude);
  //   //$updateAnchor.click();
  // }
 };

 $(document).ready(function() { Map.init(); });