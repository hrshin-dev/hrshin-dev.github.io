document.addEventListener('DOMContentLoaded', function() {
  // 이미지를 포함하는 모든 링크를 찾아서 처리
  const imgLinks = document.querySelectorAll('a.popup, a.img-link, a[href$=".jpg"], a[href$=".jpeg"], a[href$=".png"], a[href$=".gif"], a[href$=".webp"], a[href$=".svg"]');
  
  imgLinks.forEach(function(link) {
    const images = link.querySelectorAll('img');
    if (images.length > 0) {
      // 첫 번째 이미지 복사
      const img = images[0].cloneNode(true);
      
      // 링크의 부모 요소에 이미지 삽입하고 링크 제거
      link.parentNode.insertBefore(img, link);
      link.parentNode.removeChild(link);
    }
  });

  // 이미지 클릭 이벤트 방지
  document.querySelectorAll('img').forEach(function(img) {
    img.style.cursor = 'default';
    img.style.pointerEvents = 'none';
    img.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      return false;
    });
  });
}); 