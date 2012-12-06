var Game = {

  init: function() {
    $("table#teams").on('click', 'tr.update-bars', function() {
      var id = $(this).attr('id');
      Game.loadMarkersForRow(id);
    });
  },

  displayGames: function() {
    $.ajax({
      url: '/games',
      dataType: 'script',
      type: 'GET',
      success: function(data, status, xhr) {
        Game.init();
      },
    });
  }, 

  loadMarkersForRow : function(id) {
    $.ajax({
      url: "/games/" + id,
      dataType: "json",
      method: "GET",
      success: function(data){
        Map.setMarkers('event', data);
      }
    });
  }

};


$(document).ready(function() { 
  if ($(".filters").length){
    Game.displayGames();
  }
});


    
    

