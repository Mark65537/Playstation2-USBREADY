@echo off
setlocal enabledelayedexpansion

REM Указываем исходную папку
set source_folder=F:\sony playstation 2\programs for

REM Целевая директория (текущая директория)
set target_folder=%CD%

REM Перебираем все папки в исходной директории
for /d %%d in ("%source_folder%\APP_*") do (
    REM Копируем каждую найденную папку в целевую директорию
    xcopy "%%d" "%target_folder%\%%~nxd" /e /i /h /y
)

echo Копирование завершено.
