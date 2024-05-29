// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

  navigator.geolocation.getCurrentPosition(function(position) {
    $.ajax({
      url: '/update_location',
      type: 'POST',
      data: { 
        latitude: position.coords.latitude, 
        longitude: position.coords.longitude 
      },
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
    });
  });