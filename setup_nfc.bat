@echo off
:start
if not exist *.jar (
	echo Jar not detected. Add CraftBukkit jar to continue
	pause
	goto :start
)

::Download Libraries
echo Downloading XDelta Patch
powershell -Command "Invoke-WebRequest 'https://github.com/New-Frontier-Craft/New-Frontier-Craft/releases/download/v3.5.1/NFC_Patch_v3.5.1_S4.xdelta' -OutFile 'nfcpatch.xdelta'"

::Process Files
if not exist output (
	mkdir output
	powershell -Command "Invoke-WebRequest 'https://raw.githubusercontent.com/New-Frontier-Craft/NFC-Server-Setup-Utility/main/output/start_server.bat' -OutFile 'output\start_server.bat'"
)
ren *.jar vanilla_bukkit.jar
xdelta3.exe -v -d -s "vanilla_bukkit.jar" "nfcpatch.xdelta" "output\NFC v3.5.1 S4 Server.jar"
pause