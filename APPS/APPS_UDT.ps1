# Получаем имя текущей папки
$CurFolderName = Split-Path -Leaf (Get-Location)

# Путь к файлу конфигурации
$ConfigFilePath = "..\conf_apps.cfg"

# Удаляем файл, если он уже существует (для перезаписи)
Remove-Item -Path $ConfigFilePath -ErrorAction SilentlyContinue

# Переменная для хранения первой буквы предыдущей папки
$PrevFirstLetter = ""

# Проходим по каждой папке в текущей директории
Get-ChildItem -Directory | ForEach-Object {
    $FolderName = $_.Name

    # Ищем файл .elf
    $ElfFile = Get-ChildItem -Path $_.FullName -Filter "*.elf" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

    if ($ElfFile) {
        # Получаем относительный путь к файлу .elf
        $RelativePathToElfFile = $ElfFile.FullName.Substring((Get-Location).Path.Length)

        # Заменяем обратные слэши на прямые для соответствия Unix-пути
        $RelativePathToElfFile = $RelativePathToElfFile -replace "\\", "/"

        # Проверяем первую букву папки
        $CurFirstLetter = $FolderName.Substring(0, 1)
        if ($CurFirstLetter -ne $PrevFirstLetter) {
            # Добавляем новую строку в конфигурационный файл
            Add-Content -Path $ConfigFilePath -Value ""
        }

        # Формируем строку для записи в файл
        $ConfigLine = "$FolderName=mass:/$CurFolderName$RelativePathToElfFile"

        # Записываем строку в файл конфигурации
        Add-Content -Path $ConfigFilePath -Value $ConfigLine

        # Обновляем первую букву предыдущей папки
        $PrevFirstLetter = $CurFirstLetter
    } else {
        Write-Host "Файл .elf не найден в папке $FolderName"
    }
}

# Pause
