module Jekyll
  class CategoryPageGenerator < Generator
    safe true
    
    def generate(site)
      # 사이트에서 사용 가능한 모든 카테고리 목록을 가져옵니다
      all_categories = []
      
      # 게시물에서 사용된 모든 카테고리를 수집합니다
      site.posts.docs.each do |post|
        if post.data['categories']
          # 배열 또는 문자열 형태의 카테고리를 처리합니다
          if post.data['categories'].is_a?(Array)
            all_categories.concat(post.data['categories'])
          else
            all_categories << post.data['categories']
          end
        end
      end
      
      # 추가 카테고리 목록 - 게시물이 없는 카테고리여도 표시하기 위함
      additional_categories = [
        "algorithm",
        "etc"
        # 여기에 추가 카테고리를 더 넣을 수 있습니다
      ]
      
      # 추가 카테고리를 목록에 더합니다
      all_categories.concat(additional_categories)
      
      # 중복 제거 및 정렬
      all_categories = all_categories.uniq.sort
      
      # _categories 폴더에 이미 있는 카테고리 페이지 확인
      existing_categories = []
      
      # _categories 폴더가 있는지 확인
      categories_dir = File.join(site.source, '_categories')
      if Dir.exist?(categories_dir)
        # _categories 폴더 내의 모든 파일 확인
        Dir.glob(File.join(categories_dir, '*.md')).each do |file|
          # 파일 내용 읽기
          content = File.read(file)
          # YAML 프론트매터에서 title 추출
          if content =~ /^---\s*\n(.*?\n)---\s*\n/m
            front_matter = $1
            if front_matter =~ /title:\s*(.+)$/
              # 추출된 title을 소문자로 변환하여 저장
              category_title = $1.strip.downcase
              existing_categories << category_title
            end
          end
        end
      end
      
      # 각 카테고리에 대한 페이지 생성 (기존에 존재하지 않는 경우만)
      all_categories.each do |category|
        # 소문자로 변환하여 비교
        category_lower = category.downcase
        
        # 이미 _categories 폴더에 있는 카테고리는 건너뜁니다
        unless existing_categories.include?(category_lower)
          site.pages << CategoryPage.new(site, site.source, category)
        end
      end
    end
  end
  
  # 카테고리 페이지 클래스
  class CategoryPage < Page
    def initialize(site, base, category)
      @site = site
      @base = base
      @dir = File.join('categories', category.downcase.gsub(' ', '-'))
      @name = 'index.html'
      
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category.html')
      
      self.data['title'] = category
      self.data['category'] = category
    end
  end
end 