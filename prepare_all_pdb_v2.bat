@echo off
setlocal enabledelayedexpansion
rem ----------------------------------------------------------
rem Prepare all .pdb ligands in .\lib for AutoDock Vina
rem • Protonate at pH 7.4 with Open Babel 3.1.1
rem • Convert to PDBQT with prepare_ligand4.py
rem ----------------------------------------------------------

cd /d "%~dp0"

rem -------- sanity checks -----------------------------------
if not exist "lib" (
    echo ERROR: Folder "lib" not found in "%~dp0"
    pause & exit /b 1
)

rem -------- paths ------------------------------------------
set "PYTHON_PATH=C:\Program Files (x86)\MGLTools-1.5.7\python.exe"
set "PREP_SCRIPT=C:\Program Files (x86)\MGLTools-1.5.7\prepare_ligand4.py"
set "OBABEL=C:\Program Files\OpenBabel-3.1.1\obabel.exe"

for %%P in ("%PYTHON_PATH%" "%PREP_SCRIPT%" "%OBABEL%") do if not exist %%~P (
    echo ERROR: %%~P not found
    pause & exit /b 1
)

rem -------- folders ----------------------------------------
set "TMP_FOLDER=tmp_ph74"
set "OUTPUT_FOLDER=pdbqt-2"

if not exist "%TMP_FOLDER%"    mkdir "%TMP_FOLDER%"
if not exist "%OUTPUT_FOLDER%" mkdir "%OUTPUT_FOLDER%"

echo Starting ligand preparation at pH 7.4...
echo.

rem -------- main loop --------------------------------------
for %%F in ("lib\*.pdb") do (
    echo Processing %%~nxF

    rem 1) Protonate / de‑protonate at pH 7.4
    call "%OBABEL%" "%%~F" -O "%TMP_FOLDER%\%%~nF_ph74.pdb" -p 7.4
    if errorlevel 1 (
        echo   ERROR: Open Babel failed on %%~nxF
    ) else (
        rem 2) Convert to PDBQT
        call "%PYTHON_PATH%" "%PREP_SCRIPT%" ^
            -l "%TMP_FOLDER%\%%~nF_ph74.pdb" ^
            -A bonds ^
            -F -v ^
            -o "%OUTPUT_FOLDER%\%%~nF.pdbqt"
        if errorlevel 1 (
            echo   ERROR: prepare_ligand4.py failed on %%~nxF
        ) else (
            echo   OK
        )
    )
    echo ---------------------------------------------
)

rem -------- cleanup ----------------------------------------
echo Cleaning up temporary files...
rd /s /q "%TMP_FOLDER%"

echo.
echo All files processed.
pause
