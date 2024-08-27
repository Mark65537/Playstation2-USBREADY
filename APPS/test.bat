@echo off
setlocal enabledelayedexpansion

for /d %%D in (*) do (
    echo "D"=%%D

    REM Ищем первый файл .elf
    set "ElfFile="
    for %%F in (%%D\*.elf) do (
        set "ElfFile=%%F"
        @REM goto foundElf
    )
    
    :foundElf
    echo set "ElfFile=!ElfFile!"
    
)

pause