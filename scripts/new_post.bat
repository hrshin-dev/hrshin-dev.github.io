@echo off
setlocal enabledelayedexpansion

echo ====================================
echo        게시글 작성 도구
echo ====================================
echo.

REM 제목 입력
set /p "title=게시글 제목을 입력하세요: "

REM 카테고리 선택
echo.
echo 카테고리를 선택하세요:
echo 1. Algorithm
echo 2. Unity
echo 3. ETC
set /p "category_choice=선택 (1-3): "

REM 카테고리 선택에 따른 값 설정
if "%category_choice%"=="1" set "category=Algorithm"
if "%category_choice%"=="2" set "category=Unity"
if "%category_choice%"=="3" set "category=ETC"

REM 현재 날짜로 파일명 생성
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set "date=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%"
set "filename=%date%-%title:.=%.md"
set "filepath=_posts\%filename%"
set "folder_name=%date%-%title:.=%"
set "img_folder=assets\img\posts\%folder_name%"

REM 이미지 폴더 생성
if not exist "%img_folder%" mkdir "%img_folder%"

REM front matter 생성
echo --- > "%filepath%"
echo title: %title% >> "%filepath%"
echo date: %date% %time:~0,2%:%time:~3,2%:%time:~6,2% %time:~9,2% >> "%filepath%"
echo categories: [%category%] >> "%filepath%"
echo tags: [] >> "%filepath%"
echo --- >> "%filepath%"
echo. >> "%filepath%"

echo.
echo 게시글이 생성되었습니다: %filepath%
echo 이미지 폴더가 생성되었습니다: %img_folder%
echo.
echo 게시글 작성 방법:
echo 1. 메모장이나 VS Code로 %filepath% 파일을 열어주세요
echo 2. 내용을 작성하고 저장하세요
echo 3. 이미지를 추가하려면 %img_folder% 폴더에 이미지를 넣고
echo    ![이미지이름](/assets/img/posts/%folder_name%/이미지이름) 형식으로 작성하세요
echo 4. 코드 블록은 ``` 로 감싸서 작성하세요
echo 5. 작성이 끝나면 deploy.bat을 실행하여 배포하세요
echo.
pause 