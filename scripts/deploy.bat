@echo off
echo 게시글 배포를 시작합니다...

REM 현재 시간 가져오기
set "current_time=%time:~0,2%:%time:~3,2%:%time:~6,2%"

REM 커밋 메시지 생성
set "commit_message=Update: %date% %current_time%"

REM Git 명령어 실행
git add .
git commit -m "%commit_message%"
git push

echo 배포가 완료되었습니다.
pause 