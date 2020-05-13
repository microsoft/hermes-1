REM Run as administrator
mc -um hermes_etw.man
rc.exe hermes_etw.rc
link.exe  /dll /noentry /machine:x64 hermes_etw.res /OUT:hermes_etw_res.dll

wevtutil um hermes_etw.man
wevtutil im hermes_etw.man /rf:"%~dp0hermes_etw_res.dll" /mf:"%~dp0hermes_etw_res.dll"
wevtutil gp "Hermes-Provider" 