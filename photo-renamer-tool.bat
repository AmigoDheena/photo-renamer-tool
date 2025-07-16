@echo off
:: =================================================================
:: Photo Renamer Tool v1.0
:: Created: July 16, 2025
:: Author: Amig Dheena
:: Description: This tool renames image files in the current foldersequentially from 1 to N.
:: Usage: Simply place this batch file in the folder with your photos
:: and run it. The photos will be renamed sequentially.
:: =================================================================

setlocal enabledelayedexpansion
title Photo Renamer Tool v1.0

echo Photo Renamer Tool v1.0
echo.
echo This tool will rename all image files in the current folder 
echo sequentially starting from 1.
echo.

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% == 0 (
    echo Running with administrator privileges.
) else (
    echo Note: For best results, consider running as administrator.
)

echo.
echo Starting renaming process...
echo.

:: First pass - rename all files to temporary names
set tempcount=1000000
for %%f in (*.jpg *.png *.jpeg *.JPG *.PNG *.JPEG) do (
    echo Processing: %%f
    ren "%%f" "temp_!tempcount!%%~xf"
    set /a tempcount+=1
)

:: Second pass - rename to final sequential numbers
set count=1
for %%f in (temp_*.jpg temp_*.png temp_*.jpeg temp_*.JPG temp_*.PNG temp_*.JPEG) do (
    echo Renaming to: !count!%%~xf
    ren "%%f" "!count!%%~xf"
    set /a count+=1
)

set /a finalcount=%count%-1
echo.
echo Successfully renamed %finalcount% files starting from 1
echo.
echo Thank you for using Photo Renamer Tool!
echo.
pause