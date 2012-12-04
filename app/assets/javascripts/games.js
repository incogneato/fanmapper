var Game = {

  displayGames: function() {
    $('a#get_games').on('click', function() {
      $.ajax({
        url: '/games',
        dataType: 'script',
        type: 'GET',
        success: function(data, textStatus) { 
          }
        // More stuff should go here eventually if /when we use json for this functionality
        });
      });
  }
};

$(document).ready(function() { Game.displayGames(); });

