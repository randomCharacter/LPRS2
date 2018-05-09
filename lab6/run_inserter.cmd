@echo off


REM Copyright (C)
REM RT-RK, Novi Sad, 2011
REM All rights reserved.
REM

set XILINX=C:\Xilinx\14.6\ISE_DS\ISE
set XILINX_DSP=C:\Xilinx\14.6\ISE_DS\DSP_Tools\nt
set XILINX_EDK=C:\Xilinx\14.6\ISE_DS\EDK
set XILINX_PLANAHEAD=C:\Xilinx\14.6\ISE_DS\PlanAhead

set Path=C:\Xilinx\14.6\ISE_DS\common\lib\nt;%XILINX_EDK%\bin\nt;%XILINX_EDK%\lib\nt;%XILINX_PLANAHEAD%\bin;%XILINX%\bin\nt;%XILINX%\lib\nt;

%XILINX%\bin\nt\ngcbuild.exe -i .\implementation\system.ngc  .\implementation\system_all.ngc

%XILINX%\bin\nt\inserterw.exe