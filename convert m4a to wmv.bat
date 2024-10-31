@echo off
setlocal enabledelayedexpansion

REM Set the input directory containing M4A files
set "input_dir=C:\Users\prana\Desktop\songs\Downloads"
REM Set the output directory for WMA files
set "output_dir=C:\Users\prana\Desktop\songs\Misc"

REM Create the output directory if it does not exist
if not exist "!output_dir!" (
    mkdir "!output_dir!"
)

REM Loop through each M4A file in the input directory
for %%f in ("%input_dir%\*.m4a") do (
    echo Converting "%%~nxf" to WMA format...
    ffmpeg -i "%%f" -codec:a wmav2 "!output_dir!\%%~nf.wma"
    
    REM Check if the conversion was successful
    if errorlevel 1 (
        echo Failed to convert: %%f
    ) else (
        echo Successfully converted: %%f
    )
)

echo Conversion complete!
endlocal
