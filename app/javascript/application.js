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

  function moveStars() {
    const stars = document.querySelectorAll('.star');
    stars.forEach((star) => {
      let posX = 0;
      let posY = 0;
      let angle = 0;
      let initialTop = parseInt(window.getComputedStyle(star).top, 10);
      let initialLeft = parseInt(window.getComputedStyle(star).left, 10);
      const screenWidth = window.innerWidth;
      const screenHeight = window.innerHeight;
      const starWidth = star.offsetWidth;
      const starHeight = star.offsetHeight;
  
      function animate() {
        if (initialLeft + posX >= screenWidth - starWidth || initialTop + posY >= screenHeight - starHeight) {
          // ランダムな位置にリセット
          posX = 0;
          posY = 0;
          initialTop = Math.random() * (screenHeight - starHeight);
          initialLeft = Math.random() * (screenWidth - starWidth);
          star.style.top = initialTop + 'px';
          star.style.left = initialLeft + 'px';
          setTimeout(() => requestAnimationFrame(animate), 200); // 1秒待ってから再度移動を開始
        } else {
          posX += 2; // 移動速度を10倍に
          posY += 2; // 移動速度を10倍に
          angle += 3.6; // 回転速度はそのまま
          star.style.top = (initialTop + posY) + 'px'; 
          star.style.left = (initialLeft + posX) + 'px'; 
          star.style.transform = `rotate(${angle}deg)`; // 画像を回転
          requestAnimationFrame(animate); // 次のフレームをリクエスト
        }
      }
  
      animate();
    });
  }

  window.onload = function() {
    moveStars();
  };
  
  document.querySelectorAll('.startButton').forEach(function(button) {
    button.addEventListener('click', function(event) {
      event.preventDefault(); // ページ遷移を防ぐ
      moveStars();
  
      // ページ遷移を手動で行う
      window.location.href = event.currentTarget.getAttribute('href');
    });
  });