var Game = {

  init: function() {
    $("#game_list").on('click', 'tr.update-bars', function() {
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
  console.log('test');
  if ($(".filters").length){
    Game.displayGames();
  }
});
