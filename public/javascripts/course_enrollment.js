$(document).ready(function() {
  var warning_icon = $('.course-warning');

  $('input[type=checkbox]').change( function(e) {
    var self = $(this);

    if ( self.is(':checked') ) {
      warning_icon.addClass('hidden');
    }
    else {
      warning_icon.removeClass('hidden');
    }

   
  });
});


