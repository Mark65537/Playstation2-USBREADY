# Получаем имя текущей папки
$CurFolderName = Split-Path -Leaf (Get-Location)

# Путь к файлу конфигурации
$ConfigFilePath = "..\conf_apps.cfg"

# Переменная для подсчета добавленных файлов
$FilesAdded = 0

# Ищем файлы с расширением .elf в текущей директории
Get-ChildItem -Path . -Filter "*.elf*" -File | ForEach-Object {
    $FileName = $_.Name

    # Получаем относительный путь к файлу
    $RelativePathToElfFile = $_.FullName.Substring((Get-Location).Path.Length)

    # Заменяем обратные слэши на прямые для соответствия Unix-пути
    $RelativePathToElfFile = $RelativePathToElfFile -replace "\\", "/"

    # Формируем строку для записи в файл
    $ConfigLine = "$FileName=mass:/$CurFolderName$RelativePathToElfFile"

    # Дописываем строку в файл конфигурации
    Add-Content -Path $ConfigFilePath -Value $ConfigLine

    # Увеличиваем счетчик добавленных файлов
    $FilesAdded++
}

# Проверяем, была ли успешно добавлена информация в файл конфигурации
if ($FilesAdded -gt 0) {
    Write-Host "Информация о $FilesAdded файлах успешно добавлена в файл conf_apps.cfg."
} else {
    Write-Host "Файлы с расширением .elf не найдены."
}

Pause