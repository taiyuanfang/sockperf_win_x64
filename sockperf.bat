@echo off

if not exist csv mkdir csv

set    arg_host=127.0.0.1
set    arg_port=11111
set    arg_mps=100
set    arg_time=60
set    arg_msg_size=%1
set /a arg_count=%2

echo arg_host     : %arg_host%
echo arg_port     : %arg_port%
echo arg_mps      : %arg_mps%
echo arg_time     : %arg_time%
echo arg_msg_size : %arg_msg_size%
echo arg_count    : %arg_count%

set /a count=1

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
    set filename=%date_y%%date_m%%date_d%_%time_h%%time_m%%time_s%_%arg_msg_size%_%seq%.csv
    rem echo filename=%filename%

    @echo on
    bin\sockperf.exe pp -i %arg_host% -p %arg_port% --tcp --mps %arg_mps% -t %arg_time% --msg-size %arg_msg_size% --full-log csv\%filename%
    @echo off

    set /a count+=1
    if %count% LEQ %arg_count% goto loop
