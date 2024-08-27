@echo off
setlocal enabledelayedexpansion

REM Получаем имя текущей папки
for %%F in (.) do set CurFolderName=%%~nxF

REM Путь к файлу конфигурации
set ConfigFilePath=..\conf_apps.cfg

REM Удаляем файл, если он уже существует (для перезаписи)
if exist "%ConfigFilePath%" del "%ConfigFilePath%"

REM Переменная для хранения первой буквы предыдущей папки
set PrevFirstLetter=

REM Проходим по каждой папке в текущей директории
for /d %%D in (*) do (
    set "FolderName=%%~nxD"

    echo set "FolderName=%%~nxD"

    REM Ищем файл .elf
    set "ElfFile="
    for %%F in (%%D\*.elf) do (
        set "ElfFile=%%F"
        @REM не работает
        @REM goto foundElf
    )

    :foundElf
    echo set "ElfFile=!ElfFile!"
    if defined ElfFile (
        REM Получаем относительный путь к файлу .elf
        set "RelativePathToElfFile=!ElfFile:%cd%\=!"

        REM Заменяем обратные слэши на прямые для соответствия Unix-пути
        set "RelativePathToElfFile=!RelativePathToElfFile:\=/!"

        REM Проверяем первую букву папки
        set "CurFirstLetter=!FolderName:~0,1!"
        if not "!CurFirstLetter!"=="!PrevFirstLetter!" (
            REM Добавляем новую строку в конфигурационный файл
            echo. >> "%ConfigFilePath%"
        )

        REM Формируем строку для записи в файл
        echo !FolderName!=mass:/!CurFolderName!/!RelativePathToElfFile! >> "%ConfigFilePath%"

        REM Обновляем первую букву предыдущей папки
        set "PrevFirstLetter=!CurFirstLetter!"
    ) else (
        echo Файл .elf не найден в папке !FolderName!
    )
)

pause
