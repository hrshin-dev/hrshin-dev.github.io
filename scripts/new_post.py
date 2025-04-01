#!/usr/bin/env python3
import os
import sys
from datetime import datetime

def create_new_post(title, category):
    # 현재 날짜로 파일명 생성
    date = datetime.now().strftime('%Y-%m-%d')
    filename = f"{date}-{title.lower().replace(' ', '-')}.md"
    filepath = os.path.join('_posts', filename)

    # front matter 생성
    front_matter = f"""---
title: {title}
date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S %z')}
categories: [{category}]
tags: []
---

"""

    # 파일 생성
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(front_matter)

    print(f"새 게시글이 생성되었습니다: {filepath}")
    print("게시글을 작성하고 저장한 후, 다음 명령어로 자동 배포할 수 있습니다:")
    print("git add . && git commit -m \"New post: {title}\" && git push")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("사용법: python new_post.py \"게시글 제목\" \"카테고리\"")
        sys.exit(1)

    title = sys.argv[1]
    category = sys.argv[2]
    create_new_post(title, category) 