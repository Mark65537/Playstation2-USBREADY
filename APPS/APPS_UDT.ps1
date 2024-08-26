# �������� ��� ������� �����
$CurFolderName = Split-Path -Leaf (Get-Location)

# ���� � ����� ������������
$ConfigFilePath = "..\conf_apps.cfg"

# ������� ����, ���� �� ��� ���������� (��� ����������)
Remove-Item -Path $ConfigFilePath -ErrorAction SilentlyContinue

# ���������� ��� �������� ������ ����� ���������� �����
$PrevFirstLetter = ""

# �������� �� ������ ����� � ������� ����������
Get-ChildItem -Directory | ForEach-Object {
    $FolderName = $_.Name

    # ���� ���� .elf
    $ElfFile = Get-ChildItem -Path $_.FullName -Filter "*.elf" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

    if ($ElfFile) {
        # �������� ������������� ���� � ����� .elf
        $RelativePathToElfFile = $ElfFile.FullName.Substring((Get-Location).Path.Length)

        # �������� �������� ����� �� ������ ��� ������������ Unix-����
        $RelativePathToElfFile = $RelativePathToElfFile -replace "\\", "/"

        # ��������� ������ ����� �����
        $CurFirstLetter = $FolderName.Substring(0, 1)
        if ($CurFirstLetter -ne $PrevFirstLetter) {
            # ��������� ����� ������ � ���������������� ����
            Add-Content -Path $ConfigFilePath -Value ""
        }

        # ��������� ������ ��� ������ � ����
        $ConfigLine = "$FolderName=mass:/$CurFolderName$RelativePathToElfFile"

        # ���������� ������ � ���� ������������
        Add-Content -Path $ConfigFilePath -Value $ConfigLine

        # ��������� ������ ����� ���������� �����
        $PrevFirstLetter = $CurFirstLetter
    } else {
        Write-Host "���� .elf �� ������ � ����� $FolderName"
    }
}

# Pause
