var Map = {
  currentMarkers: [],
  map: null,
  
  init: function() {
    Map.getUserLocation(function(position) {
      Map.map = Map.drawMap(position); 
    });
    $('div.filters').on('ajax:success', 'a.update-bars', this.setMarkers); //bindings and delegation
    $('div.filters').on('ajax:success', 'a.clear-map', this.clearMarkers);    
  },

  clearMarkers: function(event, data) {
    for (i in Map.currentMarkers) {  
      Map.currentMarkers[i].setMap(null);
    };
    Map.currentMarkers = [];
  },

  setMarkers: function(event, data) {
    Map.clearMarkers();
    var locations = data.local_bars;
    var infoWindow = new google.maps.InfoWindow();
    for (var i = 0; i < locations.length; i++) {
      var bar = locations[i];
      var myLatLng = new google.maps.LatLng(bar.latitude, bar.longitude);
      var image = new google.maps.MarkerImage(bar.team_logo);
      var marker = new google.maps.Marker({
          position: myLatLng,
          map: Map.map,
          icon: image,
          animation: google.maps.Animation.DROP,
          title: bar.name,
          html: data.html_marker_info[i]
      });

      google.maps.event.addListener(marker, 'click', function() {
        infoWindow.setContent(this.html);
        infoWindow.open(Map.map, this);
      });
      Map.currentMarkers.push(marker);
    };
  },

  drawMap: function(position) {
    var mapOptions = {
      zoom: 13,
      center: new google.maps.LatLng(position.latitude, position.longitude-.055),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      disableDefaultUI: true
    }
    return new google.maps.Map($('.container-bars #map_canvas')[0], mapOptions);
  },

  getUserLocation: function(callback_function) {
    navigator.geolocation.getCurrentPosition(function(position) {
      callback_function(position.coords);
    });
  },


//keep this for reference
  // setCurrentLocation: function(position) {
  //   var $updateAnchor = $('a.update-bars');
  //   var link = $updateAnchor.attr('href');
  //   // alert(link);
  //   $updateAnchor.attr('href', link+'?lng='+position.longitude+'&lat='+position.latitude);
  //   //$updateAnchor.click();
  // }
 };


 $(document).ready(function() { Map.init(); });
 




