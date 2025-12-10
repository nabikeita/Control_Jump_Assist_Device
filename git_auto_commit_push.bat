@echo off
REM ==== Git 自動 add / commit / push スクリプト ====
REM この .bat は「リポジトリのルート」で実行すること！

REM --- コミットメッセージ（引数が無ければ日付入りにする） ---
set MSG=%*
if "%MSG%"=="" (
    set MSG=auto commit %date% %time%
)

echo [INFO] git pull --rebase...
git pull --rebase
if errorlevel 1 (
    echo [ERROR] occur error in git pull. solve conflict
    pause
    goto :EOF
)

echo [INFO] git add -A ...
git add -A

echo [INFO] git commit ...
git commit -m "%MSG%"
if errorlevel 1 (
    echo [INFO] don't need commit or occur error
    echo        （No problem in case of "nothing to commit" ）
    goto :PUSH
)

:PUSH
echo [INFO] git push origin main ...
git push origin main
if errorlevel 1 (
    echo [ERROR] occur error in git push 
    pause
    goto :EOF
)

echo [OK] Done!
pause
