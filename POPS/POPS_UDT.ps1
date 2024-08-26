# �������� ��� ������� �����
$CurFolderName = Split-Path -Leaf (Get-Location)

# ���� � ����� ������������
$ConfigFilePath = "..\conf_apps.cfg"

# ���������� ��� �������� ����������� ������
$FilesAdded = 0

# ���� ����� � ����������� .elf � ������� ����������
Get-ChildItem -Path . -Filter "*.elf*" -File | ForEach-Object {
    $FileName = $_.Name

    # �������� ������������� ���� � �����
    $RelativePathToElfFile = $_.FullName.Substring((Get-Location).Path.Length)

    # �������� �������� ����� �� ������ ��� ������������ Unix-����
    $RelativePathToElfFile = $RelativePathToElfFile -replace "\\", "/"

    # ��������� ������ ��� ������ � ����
    $ConfigLine = "$FileName=mass:/$CurFolderName$RelativePathToElfFile"

    # ���������� ������ � ���� ������������
    Add-Content -Path $ConfigFilePath -Value $ConfigLine

    # ����������� ������� ����������� ������
    $FilesAdded++
}

# ���������, ���� �� ������� ��������� ���������� � ���� ������������
if ($FilesAdded -gt 0) {
    Write-Host "���������� � $FilesAdded ������ ������� ��������� � ���� conf_apps.cfg."
} else {
    Write-Host "����� � ����������� .elf �� �������."
}

Pause