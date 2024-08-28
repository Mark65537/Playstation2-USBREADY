@echo off
setlocal enabledelayedexpansion

REM Получаем имя текущей папки
for %%F in (.) do set CurFolderName=%%~nxF

REM Путь к файлу конфигурации
set ConfigFilePath=..\conf_apps.cfg

for %%F in (*.elf) do (
    set "ElfFile=%%F"
   
    REM Формируем строку для записи в файл
    echo PS1_!ElfFile:~3,-4!=mass:/!CurFolderName!/!ElfFile!    
    echo PS1_!ElfFile:~3,-4!=mass:/!CurFolderName!/!ElfFile! >> "%ConfigFilePath%"    
)
pause
