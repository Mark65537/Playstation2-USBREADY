# Сохраняем текущую директорию
$OriginalDirectory = Get-Location

# Функция для выполнения первого найденного .ps1 файла в указанной директории
function Invoke-FirstPS1File($directory) {
    Set-Location $directory
    
    # Находим первый файл формата .ps1 в директории
    $ScriptPath = Get-ChildItem -Path $directory -Filter "*.ps1" | Select-Object -First 1

    if ($ScriptPath) {
        try {
            # Запускаем найденный скрипт
            & $ScriptPath.FullName
            Write-Host "Скрипт $($ScriptPath.FullName) успешно выполнен в директории $directory."
        } catch {
            Write-Host "Произошла ошибка при выполнении скрипта в директории $directory: $_"
        }
    } else {
        Write-Host "Файл .ps1 не найден в директории $directory."
    }
}

# Путь к директории APPS и POPS
$AppsDirectory = Join-Path $OriginalDirectory "APPS"
$PopsDirectory = Join-Path $OriginalDirectory "POPS"

# Выполняем скрипты в директории APPS
Invoke-FirstPS1File -directory $AppsDirectory

# Выполняем скрипты в директории POPS
Invoke-FirstPS1File -directory $PopsDirectory

# Возвращаемся в исходную директорию
Set-Location $OriginalDirectory

Pause
