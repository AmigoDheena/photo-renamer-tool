# Photo Renamer Tool

A simple yet powerful batch utility to sequentially rename photo files in a folder from 1 to N.

## 📷 Overview

Photo Renamer Tool automatically renames all image files in a folder with sequential numbers (1.jpg, 2.jpg, 3.jpg, etc.), making it easier to organize and sort your photo collection.

## ✨ Features

- Sequentially renames all photos in a folder (1, 2, 3, etc.)
- Supports multiple image formats (JPG, PNG, JPEG) in both lowercase and uppercase
- Uses a two-pass system to ensure no file conflicts during renaming
- Simple user interface with progress feedback
- No installation required - just a single batch file

## 🚀 Usage

1. Place the `photo-renamer-tool.bat` file in the folder containing your photos
2. Double-click the batch file to run it
3. All photos will be renamed sequentially starting from 1

## 🔒 Security Notes

Windows may display a security warning when running this batch file as it's not signed by a recognized certificate authority. This is normal for any script downloaded from the internet.

To reduce security warnings, you can:

### Option 1 (Simple)
- Right-click the batch file
- Choose "Properties"
- Check the "Unblock" box (if present)
- Click "OK"

### Option 2 (Advanced - requires administrator privileges)
- Right-click on `sign-script.ps1`
- Choose "Run with PowerShell as Administrator"
- This will create a self-signed certificate and sign the batch file

## 📋 How It Works

The script works in two phases:

1. **First pass**: All image files are renamed to temporary names (temp_1000000.jpg, etc.) to avoid conflicts
2. **Second pass**: The temporary files are renamed to their final sequential numbers (1.jpg, 2.jpg, etc.)

## 🛠️ Technical Details

```batch
@echo off
:: Photo Renamer Tool
:: Renames all image files in the current folder sequentially from 1 to N

setlocal enabledelayedexpansion

:: First pass - rename to temporary names
set tempcount=1000000
for %%f in (*.jpg *.png *.jpeg *.JPG *.PNG *.JPEG) do (
    ren "%%f" "temp_!tempcount!%%~xf"
    set /a tempcount+=1
)

:: Second pass - rename to final names
set count=1
for %%f in (temp_*.jpg temp_*.png temp_*.jpeg temp_*.JPG temp_*.PNG temp_*.JPEG) do (
    ren "%%f" "!count!%%~xf"
    set /a count+=1
)
```

## 📝 License

This project is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/AmigoDheena/photo-renamer-tool/issues).

## 📅 Created

July 16, 2025