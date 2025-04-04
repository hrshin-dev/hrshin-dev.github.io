---
title: 네이버 블로그에서 GitHub Pages로 이전하기
date: 2025-04-05 10:00:00 +0900
categories: [블로그, GitHub]
tags: [github pages, jekyll, blog migration, 블로그 이전]
description: 네이버 블로그에서 GitHub Pages로 블로그를 이전하는 방법과 장단점을 알아봅니다.
---

## 네이버 블로그의 한계

네이버 블로그는 한국에서 가장 많이 사용하는 블로그 플랫폼 중 하나입니다. 하지만 개발자라면 더 많은 자유와 기능을 원하게 됩니다. 특히 코드 블록, 마크다운 지원, 버전 관리 등 개발 관련 콘텐츠를 게시할 때 네이버 블로그는 여러 한계점이 있습니다.

주요 한계점:
- 제한된 코드 하이라이팅
- HTML/CSS 커스터마이징 제약
- 마크다운 지원 부족
- 광고 제어 불가
- SEO 최적화의 한계

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/naver-limits.png" width="70%" alt="네이버 블로그의 한계">

## GitHub Pages와 Jekyll의 장점

GitHub Pages는 개발자 친화적인 무료 호스팅 서비스로, Jekyll이라는 정적 사이트 생성기와 함께 사용하면 강력한 블로그 플랫폼을 구축할 수 있습니다.

주요 장점:
- **무료 호스팅**: GitHub에서 무료로 제공
- **버전 관리**: Git을 통한 콘텐츠 버전 관리
- **마크다운 지원**: 쉽고 직관적인 콘텐츠 작성
- **코드 하이라이팅**: 개발 블로그에 적합한 기능
- **커스터마이징**: 완전한 디자인 및 기능 제어
- **플러그인 생태계**: 다양한 기능 확장 가능

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/github-jekyll.png" width="70%" alt="GitHub Pages와 Jekyll">

## 이전 과정

### 1. GitHub 계정 및 저장소 설정

먼저 GitHub 계정이 필요합니다. 계정이 있다면 새로운 저장소를 생성합니다.

```
저장소 이름: username.github.io
(username은 실제 GitHub 사용자 이름으로 대체)
```

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/github-repo.png" width="70%" alt="GitHub 저장소 생성">

### 2. Jekyll 테마 선택 및 설치

Jekyll 테마를 선택하는 방법은 여러 가지가 있습니다:

1. [Jekyll Themes](https://jekyllthemes.io/) 사이트에서 선택
2. GitHub에서 마음에 드는 테마 저장소 포크하기
3. 인기 있는 테마(예: Minimal Mistakes, Chirpy, Just the Docs 등) 직접 다운로드

저는 [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) 테마를 선택했습니다.

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/jekyll-themes.png" width="70%" alt="Jekyll 테마 선택">

### 3. 로컬 개발 환경 설정

Jekyll을 로컬에서 실행하려면 Ruby 및 관련 도구를 설치해야 합니다.

**Windows 환경:**

```bash
# Ruby 설치 (RubyInstaller 다운로드 후 설치)
# https://rubyinstaller.org/downloads/

# Jekyll 및 Bundler 설치
gem install jekyll bundler

# 프로젝트 디렉토리로 이동
cd username.github.io

# 의존성 설치
bundle install

# 로컬 서버 실행
bundle exec jekyll serve
```

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/local-setup.png" width="70%" alt="로컬 개발 환경 설정">

### 4. 네이버 블로그 콘텐츠 마이그레이션

네이버 블로그에서 GitHub Pages로 콘텐츠를 이전하는 과정은 대부분 수동으로 이루어집니다.

1. 네이버 블로그 글 목록에서 중요한 게시물 식별
2. 마크다운 형식으로 콘텐츠 변환
3. 이미지 및 미디어 파일 다운로드 및 GitHub 저장소에 업로드
4. Jekyll 포맷에 맞게 YAML 프론트매터 추가

```markdown
---
title: "게시글 제목"
date: 2023-04-30 14:30:00 +0900
categories: [카테고리1, 카테고리2]
tags: [태그1, 태그2, 태그3]
---

여기에 본문 내용이 들어갑니다.
```

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/content-migration.png" width="70%" alt="콘텐츠 마이그레이션">

### 5. 배포 및 도메인 설정

GitHub Pages는 기본적으로 `username.github.io` 도메인을 제공하지만, 원한다면 사용자 정의 도메인도 설정할 수 있습니다.

**사용자 정의 도메인 설정:**

1. 도메인 제공업체에서 DNS 설정에 GitHub Pages IP 주소 추가
   ```
   185.199.108.153
   185.199.109.153
   185.199.110.153
   185.199.111.153
   ```

2. GitHub 저장소 Settings > Pages에서 사용자 정의 도메인 입력
3. 저장소에 CNAME 파일 생성 (도메인 이름 포함)

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/domain-setup.png" width="70%" alt="도메인 설정">

## GitHub Pages 블로그 운영 팁

### 1. 포스트 작성 워크플로우 최적화

마크다운 편집기를 사용하면 효율적으로 글을 작성할 수 있습니다:
- VS Code + 마크다운 플러그인
- Typora
- StackEdit

또한 Python 스크립트로 새 포스트 템플릿을 자동 생성할 수 있습니다:

```python
import os
from datetime import datetime

def create_post():
    title = input("포스트 제목: ")
    categories = input("카테고리(쉼표로 구분): ").split(',')
    tags = input("태그(쉼표로 구분): ").split(',')
    
    date = datetime.now().strftime("%Y-%m-%d")
    filename = f"{date}-{'-'.join(title.lower().split())}.md"
    
    with open(f"_posts/{filename}", "w", encoding="utf-8") as f:
        f.write("---\n")
        f.write(f"title: \"{title}\"\n")
        f.write(f"date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} +0900\n")
        f.write(f"categories: {categories}\n")
        f.write(f"tags: {tags}\n")
        f.write("---\n\n")
        f.write("여기에 본문을 작성하세요.\n")
    
    print(f"포스트 생성 완료: _posts/{filename}")

if __name__ == "__main__":
    create_post()
```

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/post-workflow.png" width="70%" alt="포스트 작성 워크플로우">

### 2. SEO 최적화

Jekyll 블로그의 SEO를 향상시키는 방법:

1. `jekyll-seo-tag` 플러그인 설치
2. 모든 포스트에 적절한 메타 데이터 추가
3. `sitemap.xml` 생성 및 Google Search Console에 등록
4. 이미지에 alt 태그 추가
5. 적절한 제목 계층 구조 사용 (H1, H2, H3...)

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/seo-optimization.png" width="70%" alt="SEO 최적화">

### 3. 댓글 시스템 추가

정적 사이트에서도 다음과 같은 서비스를 통해 댓글 기능을 추가할 수 있습니다:

- **Disqus**: 널리 사용되는 댓글 서비스
- **Utterances**: GitHub 이슈 기반 댓글 시스템 (개발 블로그에 적합)
- **Giscus**: GitHub Discussions 기반 댓글 시스템

Utterances 설정 예:

```html
<script src="https://utteranc.es/client.js"
        repo="username/username.github.io"
        issue-term="pathname"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>
```

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/comments-system.png" width="70%" alt="댓글 시스템">

## 네이버에서 GitHub Pages로 전환 후기

### 장점

1. **개발 관련 콘텐츠 작성이 편리해짐**
   - 코드 블록 하이라이팅
   - 마크다운 작성 방식
   - Git을 통한 버전 관리

2. **블로그 커스터마이징 자유도 증가**
   - 원하는 디자인과 레이아웃 적용
   - 필요한 기능 직접 추가 가능

3. **글로벌 접근성 향상**
   - 영어 컨텐츠 작성 시 글로벌 독자 접근 용이
   - 기술 블로그로서의 포트폴리오 가치

### 단점

1. **초기 설정의 복잡성**
   - 기술적 지식이 필요
   - 환경 설정에 시간 투자 필요

2. **일반 사용자 접근성 감소**
   - 네이버 블로그에 비해 국내 검색엔진 노출 감소
   - 일반 대중보다는, 개발자 중심의 독자층

3. **편의 기능 부족**
   - 이미지 업로드나 관리가 상대적으로 불편
   - 모바일 환경에서 글 작성이 어려움

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/pros-cons.png" width="70%" alt="장단점 비교">

## 결론

네이버 블로그에서 GitHub Pages로의 이전은 특히 개발자나 기술 블로거에게 많은 이점을 제공합니다. 초기 설정의 어려움과 학습 곡선이 있지만, 한 번 설정해 놓으면 자유롭고 전문적인 블로그 운영이 가능합니다.

두 플랫폼의 장단점을 고려하여 본인의 블로그 목적과 타겟 독자에 따라 선택하는 것이 중요합니다. 개발 관련 콘텐츠를 주로 다루거나 포트폴리오로서의 블로그를 원한다면 GitHub Pages는 탁월한 선택이 될 것입니다.

<img src="/assets/img/posts/2025-04-05-naver-blog-migration/conclusion.png" width="70%" alt="결론">

## 참고 자료

- [GitHub Pages 공식 문서](https://pages.github.com/)
- [Jekyll 공식 사이트](https://jekyllrb.com/)
- [Chirpy 테마 문서](https://chirpy.cotes.page/)
- [마크다운 가이드](https://www.markdownguide.org/) 