@echo off
setlocal enabledelayedexpansion

REM �������� ��� ������� �����
for %%F in (.) do set CurFolderName=%%~nxF

REM ���� � ����� ������������
set ConfigFilePath=..\conf_apps.cfg

for %%F in (*.elf) do (
    set "ElfFile=%%F"
   
    REM ��������� ������ ��� ������ � ����
    echo PS1_!ElfFile:~3,-4!=mass:/!CurFolderName!/!ElfFile!    
    echo PS1_!ElfFile:~3,-4!=mass:/!CurFolderName!/!ElfFile! >> "%ConfigFilePath%"    
)
pause
