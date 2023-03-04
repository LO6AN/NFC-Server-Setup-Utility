@echo off
:start
if not exist *.jar (
	echo Jar not detected. Add CraftBukkit jar to continue
	pause
	goto :start
)

::Download Libraries
echo Downloading XDelta Patch
powershell -Command "Invoke-WebRequest 'https://github.com/New-Frontier-Craft/New-Frontier-Craft/releases/download/v3.4.2/NFC_Patch_v3.4.2_S2.xdelta' -OutFile 'nfcpatch.xdelta'"
echo Downloading NFC Libraries
powershell -Command "Invoke-WebRequest 'https://github.com/New-Frontier-Craft/New-Frontier-Craft/releases/download/v3.4.2/lib.zip' -OutFile 'lib.zip'"

::Process Files
if not exist output (
	mkdir output
	powershell -Command "Invoke-WebRequest 'https://raw.githubusercontent.com/New-Frontier-Craft/NFC-Server-Setup-Utility/main/output/start_server.bat' -OutFile 'output\start_server.bat'"
)
powershell -Command Expand-Archive "lib.zip" "lib"
move lib output
ren *.jar vanilla_bukkit.jar
xdelta3.exe -v -d -s "vanilla_bukkit.jar" "nfcpatch.xdelta" "output\NFC v3.4.2 S2 Server.jar"
pause