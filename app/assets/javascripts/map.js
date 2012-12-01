var Map = {
  currentMarkers: [],
  map: null,
  // contentString: "hi",
  
  init: function() {
    Map.getUserLocation(function(position) {
      // Map.setCurrentLocation(position);
      Map.map = Map.drawMap(position); 
    });
    $('div.filters').on('ajax:success', 'a.update-bars', this.setMarkers); //bindings and delegation
    $('div.filters').on('ajax:success', 'a.clear-map', this.clearMarkers);
    // Map.windowMaker();
  },

  clearMarkers: function(event, data) {
    for (i in Map.currentMarkers) {  
      Map.currentMarkers[i].setMap(null);
    };
    Map.currentMarkers = [];
  },

  setMarkers: function(event, data) {
    Map.clearMarkers();
    console.log("hello!");
    var locations = data.local_bars;
    for (var i = 0; i < locations.length; i++) {
      var bar = locations[i];
      var myLatLng = new google.maps.LatLng(bar['latitude'], bar['longitude']);
      var image = new google.maps.MarkerImage('http://dl.dropbox.com/u/59723155/football_sport_tiny.png');
      var marker = new google.maps.Marker({
          position: myLatLng,
          map: Map.map,
          icon: image,
          animation: google.maps.Animation.DROP,
          title: bar['name']
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

  // windowMaker: function() {
  //   console.log("doodoo")
  //   var infowindow = new google.maps.InfoWindow({
  //     content: Map.contentString
  //   });

  //   google.maps.event.addListener(marker, 'click', function() {
  //     infowindow.open(Map.map,Map.marker);
  //   });
  // },

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
 