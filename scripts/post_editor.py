import tkinter as tk
from tkinter import ttk, scrolledtext, filedialog, messagebox
from datetime import datetime
import os
import shutil

class PostEditor:
    def __init__(self, root):
        self.root = root
        self.root.title("게시글 에디터")
        self.root.geometry("800x600")

        # 메인 프레임
        main_frame = ttk.Frame(root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        # 제목 입력
        ttk.Label(main_frame, text="제목:").grid(row=0, column=0, sticky=tk.W)
        self.title_entry = ttk.Entry(main_frame, width=50)
        self.title_entry.grid(row=0, column=1, columnspan=2, sticky=(tk.W, tk.E))

        # 카테고리 선택
        ttk.Label(main_frame, text="카테고리:").grid(row=1, column=0, sticky=tk.W)
        self.category_var = tk.StringVar()
        categories = ["Algorithm", "Unity", "ETC"]
        self.category_combo = ttk.Combobox(main_frame, textvariable=self.category_var, values=categories)
        self.category_combo.grid(row=1, column=1, sticky=(tk.W, tk.E))
        self.category_combo.set(categories[0])

        # 에디터 영역
        ttk.Label(main_frame, text="내용:").grid(row=2, column=0, sticky=tk.W)
        self.content_text = scrolledtext.ScrolledText(main_frame, width=80, height=30)
        self.content_text.grid(row=3, column=0, columnspan=3, sticky=(tk.W, tk.E, tk.N, tk.S))

        # 버튼 프레임
        button_frame = ttk.Frame(main_frame)
        button_frame.grid(row=4, column=0, columnspan=3, pady=10)

        # 이미지 삽입 버튼
        ttk.Button(button_frame, text="이미지 삽입", command=self.insert_image).pack(side=tk.LEFT, padx=5)
        
        # 코드 블록 삽입 버튼
        ttk.Button(button_frame, text="코드 블록 삽입", command=self.insert_code_block).pack(side=tk.LEFT, padx=5)
        
        # 저장 버튼
        ttk.Button(button_frame, text="저장", command=self.save_post).pack(side=tk.LEFT, padx=5)

        # Grid 설정
        main_frame.columnconfigure(1, weight=1)
        main_frame.rowconfigure(3, weight=1)

    def insert_image(self):
        file_path = filedialog.askopenfilename(
            filetypes=[("이미지 파일", "*.png *.jpg *.jpeg *.gif")]
        )
        if file_path:
            # 이미지 파일을 assets/img/posts로 복사
            filename = os.path.basename(file_path)
            dest_dir = "assets/img/posts"
            os.makedirs(dest_dir, exist_ok=True)
            shutil.copy2(file_path, os.path.join(dest_dir, filename))
            
            # 마크다운 이미지 문법 삽입
            image_md = f"\n![{filename}](/assets/img/posts/{filename})\n"
            self.content_text.insert(tk.INSERT, image_md)

    def insert_code_block(self):
        code_block = "\n```\n# 여기에 코드를 입력하세요\n```\n"
        self.content_text.insert(tk.INSERT, code_block)

    def save_post(self):
        title = self.title_entry.get()
        if not title:
            messagebox.showerror("오류", "제목을 입력해주세요.")
            return

        category = self.category_var.get()
        content = self.content_text.get("1.0", tk.END).strip()

        # 파일명 생성
        date = datetime.now().strftime("%Y-%m-%d")
        filename = f"{date}-{title.lower().replace(' ', '-')}.md"
        filepath = os.path.join("_posts", filename)

        # front matter 생성
        front_matter = f"""---
title: {title}
date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S %z')}
categories: [{category}]
tags: []
---

{content}
"""

        # 파일 저장
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(front_matter)

        messagebox.showinfo("성공", f"게시글이 저장되었습니다.\n{filepath}")
        self.root.quit()

def main():
    root = tk.Tk()
    app = PostEditor(root)
    root.mainloop()

if __name__ == "__main__":
    main() 