powershell -Command "choco install 7zip.install -y"

if "%PACKER_BUILDER_TYPE%" equ "vmware-iso" goto :vmware
if "%PACKER_BUILDER_TYPE%" equ "virtualbox-iso" goto :virtualbox
if "%PACKER_BUILDER_TYPE%" equ "parallels-iso" goto :parallels
goto :done

:vmware
if exist "C:\Users\vagrant\windows.iso" (
    move /Y C:\Users\vagrant\windows.iso C:\Windows\Temp
)
if not exist "C:\Windows\Temp\windows.iso" (
   powershell -Command "choco install vmware-tools -y"
) else (
    cmd /c ""C:\Program Files\7-Zip\7z.exe" x "C:\Windows\Temp\windows.iso" -oC:\Windows\Temp\VMWare"
    cmd /c C:\Windows\Temp\VMWare\setup.exe /S /v"/qn REBOOT=R\"
)
goto :done

:virtualbox
if not exist "C:\Users\vagrant\VBoxGuestAdditions.iso" (
   powershell -Command "choco install virtualbox-guest-additions-guest.install -y"
) else (
    move /Y C:\Users\vagrant\VBoxGuestAdditions.iso C:\Windows\Temp
    cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox"
    for %%i in (C:\Windows\Temp\virtualbox\cert\vbox*.cer) do C:\Windows\Temp\virtualbox\cert\VBoxCertUtil add-trusted-publisher %%i --root %%i
    cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S
)
goto :done

:parallels
if exist "C:\Users\vagrant\prl-tools-win.iso" (
	move /Y C:\Users\vagrant\prl-tools-win.iso C:\Windows\Temp
	cmd /C "C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\prl-tools-win.iso -oC:\Windows\Temp\parallels
	cmd /C C:\Windows\Temp\parallels\PTAgent.exe /install_silent
	rd /S /Q "c:\Windows\Temp\parallels"
)

:done
powershell -Command "choco uninstall 7zip.install -y"
