# ��������� ������� ����������
$OriginalDirectory = Get-Location

# ������� ��� ���������� ������� ���������� .ps1 ����� � ��������� ����������
function Invoke-FirstPS1File($directory) {
    Set-Location $directory
    
    # ������� ������ ���� ������� .ps1 � ����������
    $ScriptPath = Get-ChildItem -Path $directory -Filter "*.ps1" | Select-Object -First 1

    if ($ScriptPath) {
        try {
            # ��������� ��������� ������
            & $ScriptPath.FullName
            Write-Host "������ $($ScriptPath.FullName) ������� �������� � ���������� $directory."
        } catch {
            Write-Host "��������� ������ ��� ���������� ������� � ���������� $directory: $_"
        }
    } else {
        Write-Host "���� .ps1 �� ������ � ���������� $directory."
    }
}

# ���� � ���������� APPS � POPS
$AppsDirectory = Join-Path $OriginalDirectory "APPS"
$PopsDirectory = Join-Path $OriginalDirectory "POPS"

# ��������� ������� � ���������� APPS
Invoke-FirstPS1File -directory $AppsDirectory

# ��������� ������� � ���������� POPS
Invoke-FirstPS1File -directory $PopsDirectory

# ������������ � �������� ����������
Set-Location $OriginalDirectory

Pause
