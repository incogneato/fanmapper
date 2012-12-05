var Game = {

  displayGames: function() {
    $.ajax({
      url: '/games',
      dataType: 'script',
      type: 'GET'
      // More stuff should go here eventually if /when we use json for this functionality
    });
  } 
};

$(document).ready(function() { 
  if ($(".filters").length){
    Game.displayGames();
  }
});