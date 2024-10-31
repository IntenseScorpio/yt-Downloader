@echo off
setlocal enabledelayedexpansion

REM Specify the output directory
set output_dir=Downloads

REM Check if the output directory exists; if not, create it
if not exist "!output_dir!" (
    mkdir "!output_dir!"
)

:Start
REM Check if urls.txt exists
if not exist "urls.txt" (
    echo urls.txt not found! Please ensure it's in the same directory as this script.
    set /p retry="Would you like to retry? (Y/N): "
    if /i "!retry!"=="Y" (
        echo Please create a urls.txt file in the same directory.
        pause
        goto Start
    ) else (
        echo Exiting the script.
        exit /b
    )
)

REM Read each URL from urls.txt and download
set "url_found=0"
for /f "usebackq delims=" %%a in ("urls.txt") do (
    echo Found URL: %%a
    if not "%%a"=="" (
        set "url_found=1"
        echo Downloading: %%a
        REM Correct output format
        yt-dlp -f bestaudio -x --audio-format aac ytsearch:%%a -P "!output_dir!" --parse-metadata "title:%(artist)s% - %(title)s%" --embed-metadata
        if errorlevel 1 (
            echo Failed to download: %%a
        ) else (
            echo Download complete for: %%a
        )
    ) else (
        echo Skipping empty line.
    )
)

if "!url_found!"=="0" (
    echo No valid URLs found in urls.txt.
    set /p retry="Would you like to retry? (Y/N): "
    if /i "!retry!"=="Y" (
        goto Start
    ) else (
        echo Exiting the script.
        exit /b
    )
)

echo All downloads are complete!
pause
