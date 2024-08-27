@echo off
setlocal enabledelayedexpansion

REM ����砥� ��� ⥪�饩 �����
for %%F in (.) do set CurFolderName=%%~nxF

REM ���� � 䠩�� ���䨣��樨
set ConfigFilePath=..\conf_apps.cfg

REM ����塞 䠩�, �᫨ �� 㦥 ������� (��� ��१����)
if exist "%ConfigFilePath%" del "%ConfigFilePath%"

REM ��६����� ��� �࠭���� ��ࢮ� �㪢� �।��饩 �����
set PrevFirstLetter=

REM ��室�� �� ������ ����� � ⥪�饩 ��४�ਨ
for /d %%D in (*) do (
    set "FolderName=%%~nxD"

    echo set "FolderName=%%~nxD"

    REM �饬 䠩� .elf
    set "ElfFile="
    for %%F in (%%D\*.elf) do (
        set "ElfFile=%%F"
        @REM �� ࠡ�⠥�
        @REM goto foundElf
    )

    :foundElf
    echo set "ElfFile=!ElfFile!"
    if defined ElfFile (
        REM ����砥� �⭮�⥫�� ���� � 䠩�� .elf
        set "RelativePathToElfFile=!ElfFile:%cd%\=!"

        REM �����塞 ����� ��� �� ���� ��� ᮮ⢥��⢨� Unix-���
        set "RelativePathToElfFile=!RelativePathToElfFile:\=/!"

        REM �஢��塞 ����� �㪢� �����
        set "CurFirstLetter=!FolderName:~0,1!"
        if not "!CurFirstLetter!"=="!PrevFirstLetter!" (
            REM ������塞 ����� ��ப� � ���䨣��樮��� 䠩�
            echo. >> "%ConfigFilePath%"
        )

        REM ��ନ�㥬 ��ப� ��� ����� � 䠩�
        echo !FolderName!=mass:/!CurFolderName!/!RelativePathToElfFile! >> "%ConfigFilePath%"

        REM ������塞 ����� �㪢� �।��饩 �����
        set "PrevFirstLetter=!CurFirstLetter!"
    ) else (
        echo ���� .elf �� ������ � ����� !FolderName!
    )
)

pause
