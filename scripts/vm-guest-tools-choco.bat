powershell -Command "choco install 7zip.install"

if "%PACKER_BUILDER_TYPE%" equ "vmware-iso" goto :vmware
if "%PACKER_BUILDER_TYPE%" equ "virtualbox-iso" goto :virtualbox
if "%PACKER_BUILDER_TYPE%" equ "parallels-iso" goto :parallels
goto :done

:vmware
powershell -Command "choco install vmware-tools"
goto :done

:virtualbox
powershell -Command "choco install choco install virtualbox-guest-additions-guest.install"
goto :done

:parallels
powershell -Command "choco install choco install virtualbox-guest-additions-guest.install"

:done
powershell -Command "choco uninstall 7zip.install"
