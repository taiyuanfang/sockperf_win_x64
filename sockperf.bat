@echo off

if not exist csv mkdir csv

set /a arg_sz=%1
set /a arg_hz=%2
set /a arg_count=%3
set /a count=1

echo Size: %arg_sz%
echo Hz:   %arg_hz%
echo Loop: %arg_count%

:loop
    set pad=000000%count%
    set seq=%pad:~-6%
    rem echo %seq%

    set now=%time: =0%
    rem echo %now%
    set time_h=%now:~0,2%
    set time_m=%now:~3,2%
    set time_s=%now:~6,2%

    set date_y=%date:~6,4%
    set date_m=%date:~0,2%
    set date_d=%date:~3,2%
    set filename=%date_y%%date_m%%date_d%_%time_h%%time_m%%time_s%_%arg_sz%_%arg_hz%_%seq%.csv
    rem echo filename=%filename%

    @echo on
    bin\sockperf.exe pp -i 127.0.0.1 --tcp --full-log csv\%filename% --msg-size %arg_sz% --mps %arg_hz% -t 60
    @echo off

    set /a count+=1
    if %count% LEQ %arg_count% goto loop
