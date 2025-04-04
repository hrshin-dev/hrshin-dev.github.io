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
      
      # 각 카테고리에 대한 페이지 생성
      all_categories.each do |category|
        site.pages << CategoryPage.new(site, site.source, category)
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