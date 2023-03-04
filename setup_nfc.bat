@echo off
:start
if not exist *.jar (
	echo Jar not detected. Add CraftBukkit jar to continue
	pause
	goto :start
)

::Download Libraries
echo Downloading XDelta Patch
powershell -Command "Invoke-WebRequest 'https://github.com/New-Frontier-Craft/New-Frontier-Craft/releases/download/v3.4.2/NFC_Patch_v3.4.2_S1.xdelta' -OutFile 'nfcpatch.xdelta'"
echo Downloading NFC Libraries
powershell -Command "Invoke-WebRequest 'https://github.com/New-Frontier-Craft/New-Frontier-Craft/releases/download/v3.4.1_02/lib.zip' -OutFile 'lib.zip'"

::Process Files
if not exist output (
	mkdir output
	powershell -Command "Invoke-WebRequest 'https://github.com/New-Frontier-Craft/NFC-Server-Setup-Utility/output/start_server.bat' -OutFile 'lib.zip'"
)
powershell -Command Expand-Archive "lib.zip" "lib"
move lib output
ren *.jar vanilla_bukkit.jar
xdelta3.exe -v -d -s "vanilla_bukkit.jar" "nfcpatch.xdelta" "output\NFC v3.4.2 S1 Server.jar"
move start_server.bat output
pause