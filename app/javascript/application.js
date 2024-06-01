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


let viewportWidth;

if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
  // モバイルデバイスの場合
  function moveStars() {
    const stars = document.querySelectorAll('.star');
    const screenWidth = document.documentElement.clientWidth;
    const screenHeight = document.documentElement.clientHeight;
  
    stars.forEach((star) => {
      let posX = 0;
      let posY = 0;
      let angle = 0;
      const starWidth = star.offsetWidth;
      const starHeight = star.offsetHeight;
  
      // 初期位置をランダムに設定
      let initialTop = Math.random() * (screenHeight - starHeight);
      let initialLeft = Math.random() * (screenWidth - starWidth);
      star.style.top = initialTop + 'px';
      star.style.left = initialLeft + 'px';
  
      function animate() {
        if (initialLeft + posX +8 >= screenWidth - starWidth || initialTop + posY+8 >= screenHeight - starHeight) {
          // ランダムな位置にリセット
          posX = 0;
          posY = 0;
          initialTop = Math.random() * (screenHeight - starHeight);
          initialLeft = Math.random() * (screenWidth - starWidth);
          star.style.top = initialTop + 'px';
          star.style.left = initialLeft + 'px';
          setTimeout(() => requestAnimationFrame(animate), 200); // 少し待ってから再度移動を開始
        } else {
          posX += 2; // 移動速度
          posY += 2; // 移動速度
          angle += 3.6; // 回転速度
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
  
} else {
  // PCの場合
  function moveStars() {
    const stars = document.querySelectorAll('.star');
    const screenWidth = window.innerWidth;
    const screenHeight = window.innerHeight;
  
    stars.forEach((star) => {
      let posX = 0;
      let posY = 0;
      let angle = 0;
      const starWidth = star.offsetWidth;
      const starHeight = star.offsetHeight;
  
      // 初期位置をランダムに設定
      let initialTop = Math.random() * (screenHeight - starHeight);
      let initialLeft = Math.random() * (screenWidth - starWidth);
      star.style.top = initialTop + 'px';
      star.style.left = initialLeft + 'px';
  
      function animate() {
        if (initialLeft + posX >= screenWidth - starWidth || initialTop + posY >= screenHeight - starHeight) {
          // ランダムな位置にリセット
          posX = 0;
          posY = 0;
          initialTop = Math.random() * (screenHeight - starHeight);
          initialLeft = Math.random() * (screenWidth - starWidth);
          star.style.top = initialTop + 'px';
          star.style.left = initialLeft + 'px';
          setTimeout(() => requestAnimationFrame(animate), 200); // 少し待ってから再度移動を開始
        } else {
          posX += 2; // 移動速度
          posY += 2; // 移動速度
          angle += 3.6; // 回転速度
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
  
}