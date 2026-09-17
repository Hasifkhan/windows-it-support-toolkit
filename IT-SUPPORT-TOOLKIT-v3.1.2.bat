@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ####################################################################
:: #
:: #              ULTIMATE IT SUPPORT TOOLKIT
:: #                  PROFESSIONAL EDITION
:: #
:: #              Developed & Maintained By
:: #                       HASIF KHAN
:: #
:: # Copyright (c) 2026 Hasif Khan. All Rights Reserved.
:: #
:: # Project ID : HK-ITST-2026-001
:: # Version    : 3.1.2 Professional Edition
:: #
:: # NOTICE:
:: # This software and source code are proprietary to Hasif Khan.
:: # Unauthorized reproduction, redistribution, resale, or removal
:: # of copyright/author attribution is not permitted without
:: # permission from the copyright owner.
:: #
:: ####################################################################

title HASIF KHAN - ULTIMATE IT SUPPORT TOOLKIT v3.1.2
color 0B

:: ====================================================================
:: CONSOLE SIZE & SCROLLBACK
:: ====================================================================
:: Visible window : 72 columns x 38 lines
:: Scrollback     : 5000 lines
:: This keeps the professional compact layout while allowing long
:: diagnostic output to be reviewed with the mouse wheel / scrollbar.

mode con: cols=72 lines=38 >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$rawui = $Host.UI.RawUI; $buffer = $rawui.BufferSize; $buffer.Width = 72; $buffer.Height = 5000; $rawui.BufferSize = $buffer" >nul 2>&1

:: ====================================================================
:: CONFIGURATION
:: ====================================================================

set "APP_TITLE=ULTIMATE IT SUPPORT TOOLKIT"
set "APP_VERSION=3.1.2 Professional Edition"
set "AUTHOR=HASIF KHAN"
set "COPYRIGHT=Copyright (c) 2026 Hasif Khan. All Rights Reserved."
set "PROJECT_ID=HK-ITST-2026-001"

set "BASEDIR=%USERPROFILE%\Desktop\IT-Toolkit"
set "LOGDIR=%BASEDIR%\Logs"
set "REPORTDIR=%BASEDIR%\Reports"
set "LOGFILE=%LOGDIR%\toolkit-activity.log"

if not exist "%BASEDIR%" mkdir "%BASEDIR%" >nul 2>&1
if not exist "%LOGDIR%" mkdir "%LOGDIR%" >nul 2>&1
if not exist "%REPORTDIR%" mkdir "%REPORTDIR%" >nul 2>&1

:: ====================================================================
:: ADMINISTRATOR CHECK
:: ====================================================================

net session >nul 2>&1

if "%errorlevel%"=="0" (
    set "ADMIN_STATUS=ADMINISTRATOR"
) else (
    set "ADMIN_STATUS=STANDARD USER"
)

:: ====================================================================
:: WINDOWS VERSION
:: ====================================================================

set "WINVER="

for /f "delims=" %%A in (
    'powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).Caption" 2^>nul'
) do (
    set "WINVER=%%A"
)

if not defined WINVER set "WINVER=Windows"

:: ====================================================================
:: START APPLICATION
:: ====================================================================

call :Splash
goto MAIN_MENU


:: ####################################################################
::                         SPLASH SCREEN
:: ####################################################################

:SPLASH

cls
color 0B

echo.
echo.
echo.
echo  +------------------------------------------------------------------+
echo  ^|                                                                  ^|
echo  ^|              ULTIMATE IT SUPPORT TOOLKIT                        ^|
echo  ^|                   PROFESSIONAL EDITION                           ^|
echo  ^|                                                                  ^|
echo  ^|                    Developed ^& Maintained By                     ^|
echo  ^|                         HASIF KHAN                               ^|
echo  ^|                                                                  ^|
echo  +------------------------------------------------------------------+
echo  ^|                                                                  ^|
echo  ^|                   Initializing Console...                         ^|
echo  ^|                                                                  ^|
echo  +------------------------------------------------------------------+
echo.

timeout /t 2 /nobreak >nul

exit /b


:: ####################################################################
::                         MAIN MENU
:: ####################################################################

:MAIN_MENU

call :Header "MAIN SUPPORT CONSOLE"

echo.
echo                         MAIN SUPPORT CONSOLE
echo.
echo        [01] PC Information
echo        [02] Hardware Diagnostics
echo        [03] Network Diagnostics
echo        [04] Internet Troubleshooting
echo        [05] Windows Repair
echo        [06] Disk ^& Storage
echo        [07] Performance
echo        [08] Services
echo        [09] User ^& Account Tools
echo        [10] Driver ^& Device Tools
echo        [11] Windows Update
echo        [12] Security ^& Firewall
echo        [13] Wi-Fi Tools
echo        [14] Report Generator
echo        [15] System Tools
echo        [16] Power ^& Shutdown
echo        [17] Quick IT Health Check
echo        [18] Exit
echo.
echo  ------------------------------------------------------------------
echo   IT SUPPORT TOOLKIT v3.1.2 ^| HASIF KHAN ^| %ADMIN_STATUS%
echo  ------------------------------------------------------------------
echo.

set "choice="
set /p "choice=  Select Module [01-18]: "

:: Normalize accidental leading/trailing spaces
set "choice=%choice: =%"

:: Main menu dispatch - explicit labels prevent accidental fall-through
if /i "%choice%"=="1"  goto :PC_INFO
if /i "%choice%"=="01" goto :PC_INFO
if /i "%choice%"=="2"  goto :HARDWARE
if /i "%choice%"=="02" goto :HARDWARE
if /i "%choice%"=="3"  goto :MODULE_NETWORK
if /i "%choice%"=="03" goto :MODULE_NETWORK
if /i "%choice%"=="4"  goto :INTERNET
if /i "%choice%"=="04" goto :INTERNET
if /i "%choice%"=="5"  goto :WINDOWS_REPAIR
if /i "%choice%"=="05" goto :WINDOWS_REPAIR
if /i "%choice%"=="6"  goto :DISK_STORAGE
if /i "%choice%"=="06" goto :DISK_STORAGE
if /i "%choice%"=="7"  goto :PERFORMANCE
if /i "%choice%"=="07" goto :PERFORMANCE
if /i "%choice%"=="8"  goto :SERVICES
if /i "%choice%"=="08" goto :SERVICES
if /i "%choice%"=="9"  goto :USER_TOOLS
if /i "%choice%"=="09" goto :USER_TOOLS
if /i "%choice%"=="10" goto :DRIVER_TOOLS
if /i "%choice%"=="11" goto :WINDOWS_UPDATE
if /i "%choice%"=="12" goto :SECURITY
if /i "%choice%"=="13" goto :WIFI_TOOLS
if /i "%choice%"=="14" goto :REPORTS
if /i "%choice%"=="15" goto :SYSTEM_TOOLS
if /i "%choice%"=="16" goto :POWER
if /i "%choice%"=="17" goto :HEALTH_CHECK
if /i "%choice%"=="18" goto :EXIT_APP

call :Invalid
goto :MAIN_MENU


:: ####################################################################
:: 01 - PC INFORMATION
:: ####################################################################

:PC_INFO

call :Header "01 - PC INFORMATION"

echo.
echo        [01] Complete System Information
echo        [02] Operating System
echo        [03] Computer / Manufacturer
echo        [04] CPU Information
echo        [05] RAM Information
echo        [06] BIOS Information
echo        [07] Windows Activation
echo        [08] Environment Variables
echo        [09] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if /i "%sub%"=="1" (
    systeminfo | more
    call :Log "PC Information - System Information"
    call :Pause
    goto PC_INFO
)

if /i "%sub%"=="2" (
    powershell -NoProfile -Command "Get-CimInstance Win32_OperatingSystem | Select Caption,Version,BuildNumber,OSArchitecture,InstallDate,LastBootUpTime | Format-List"
    call :Log "PC Information - Operating System"
    call :Pause
    goto PC_INFO
)

if /i "%sub%"=="3" (
    powershell -NoProfile -Command "Get-CimInstance Win32_ComputerSystem | Select Manufacturer,Model,SystemType,@{N='RAM_GB';E={[math]::Round($_.TotalPhysicalMemory/1GB,2)}} | Format-List"
    call :Log "PC Information - Computer Manufacturer"
    call :Pause
    goto PC_INFO
)

if /i "%sub%"=="4" (
    powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select Name,Manufacturer,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed | Format-List"
    call :Log "PC Information - CPU"
    call :Pause
    goto PC_INFO
)

if /i "%sub%"=="5" (
    powershell -NoProfile -Command "Get-CimInstance Win32_PhysicalMemory | Select Manufacturer,PartNumber,@{N='CapacityGB';E={[math]::Round($_.Capacity/1GB,2)}},Speed | Format-Table -Auto"
    call :Log "PC Information - RAM"
    call :Pause
    goto PC_INFO
)

if /i "%sub%"=="6" (
    powershell -NoProfile -Command "Get-CimInstance Win32_BIOS | Select Manufacturer,SMBIOSBIOSVersion,SerialNumber,ReleaseDate | Format-List"
    call :Log "PC Information - BIOS"
    call :Pause
    goto PC_INFO
)

if /i "%sub%"=="7" (
    cscript //nologo "%windir%\system32\slmgr.vbs" /xpr
    call :Log "PC Information - Windows Activation"
    call :Pause
    goto PC_INFO
)

if /i "%sub%"=="8" (
    set
    call :Log "PC Information - Environment Variables"
    call :Pause
    goto PC_INFO
)

if /i "%sub%"=="9" goto :MAIN_MENU

call :Invalid
goto :PC_INFO


:: ####################################################################
:: 02 - HARDWARE DIAGNOSTICS
:: ####################################################################

:HARDWARE

call :Header "02 - HARDWARE DIAGNOSTICS"

echo.
echo        [01] CPU Information
echo        [02] RAM Information
echo        [03] Disk Health
echo        [04] Battery Report
echo        [05] Plug and Play Devices
echo        [06] Problem Devices
echo        [07] Hardware Resources
echo        [08] DirectX Diagnostic
echo        [09] Memory Diagnostic
echo        [10] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Format-List *"
    call :Pause
    goto HARDWARE
)

if "%sub%"=="2" (
    powershell -NoProfile -Command "Get-CimInstance Win32_PhysicalMemory | Select BankLabel,Manufacturer,PartNumber,@{N='CapacityGB';E={[math]::Round($_.Capacity/1GB,2)}},Speed | Format-Table -Auto"
    call :Pause
    goto HARDWARE
)

if "%sub%"=="3" (
    powershell -NoProfile -Command "Get-PhysicalDisk | Select FriendlyName,MediaType,HealthStatus,OperationalStatus,@{N='SizeGB';E={[math]::Round($_.Size/1GB,2)}} | Format-Table -Auto"
    call :Pause
    goto HARDWARE
)

if "%sub%"=="4" (
    powercfg /batteryreport /output "%REPORTDIR%\battery-report.html"
    echo.
    echo  Battery report created:
    echo.
    echo  %REPORTDIR%\battery-report.html
    call :Log "Hardware - Battery Report"
    call :Pause
    goto HARDWARE
)

if "%sub%"=="5" (
    powershell -NoProfile -Command "Get-PnpDevice | Sort Status,FriendlyName | Format-Table Status,Class,FriendlyName,InstanceId -Auto"
    call :Pause
    goto HARDWARE
)

if "%sub%"=="6" (
    powershell -NoProfile -Command "Get-PnpDevice | Where-Object {$_.Status -ne 'OK'} | Format-Table Status,Class,FriendlyName,InstanceId -Auto"
    call :Pause
    goto HARDWARE
)

if "%sub%"=="7" (
    msinfo32.exe
    call :Log "Hardware - System Information"
    goto HARDWARE
)

if "%sub%"=="8" (
    dxdiag.exe
    call :Log "Hardware - DirectX Diagnostic"
    goto HARDWARE
)

if "%sub%"=="9" (
    mdsched.exe
    call :Log "Hardware - Memory Diagnostic"
    goto HARDWARE
)

if "%sub%"=="10" goto MAIN_MENU

call :Invalid
goto HARDWARE


:: ####################################################################
:: 03 - NETWORK DIAGNOSTICS
:: ####################################################################

:MODULE_NETWORK

call :Header "03 - NETWORK DIAGNOSTICS"

echo.
echo        [01] IP Configuration
echo        [02] Network Adapters
echo        [03] Default Gateway
echo        [04] DNS Configuration
echo        [05] ARP Table
echo        [06] Routing Table
echo        [07] Active Connections
echo        [08] Ping Gateway
echo        [09] Ping Internet
echo        [10] Traceroute
echo        [11] Flush DNS
echo        [12] Winsock Reset
echo        [13] TCP/IP Reset
echo        [14] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" goto NET_IPCONFIG
if "%sub%"=="2" goto NET_ADAPTERS
if "%sub%"=="3" goto NET_GATEWAY
if "%sub%"=="4" goto NET_DNS
if "%sub%"=="5" goto NET_ARP
if "%sub%"=="6" goto NET_ROUTE
if "%sub%"=="7" goto NET_NETSTAT
if "%sub%"=="8" goto NET_PING_GATEWAY
if "%sub%"=="9" goto NET_PING_INTERNET
if "%sub%"=="10" goto NET_TRACERT
if "%sub%"=="11" goto NET_FLUSH_DNS
if "%sub%"=="12" goto NET_WINSOCK
if "%sub%"=="13" goto NET_TCPIP
if "%sub%"=="14" goto MAIN_MENU

call :Invalid
goto MODULE_NETWORK


:NET_IPCONFIG

call :Header "NETWORK - IP CONFIGURATION"

ipconfig /all | more
call :Log "Network - IP Configuration"
call :Pause
goto MODULE_NETWORK


:NET_ADAPTERS

call :Header "NETWORK - NETWORK ADAPTERS"

powershell -NoProfile -Command "Get-NetAdapter | Format-Table Name,InterfaceDescription,Status,LinkSpeed,MacAddress -Auto"
call :Log "Network - Adapters"
call :Pause
goto MODULE_NETWORK


:NET_GATEWAY

call :Header "NETWORK - DEFAULT GATEWAY"

powershell -NoProfile -Command "Get-NetRoute -DestinationPrefix '0.0.0.0/0' | Select ifIndex,NextHop,RouteMetric | Format-Table -Auto"
call :Pause
goto MODULE_NETWORK


:NET_DNS

call :Header "NETWORK - DNS CONFIGURATION"

ipconfig /displaydns | more

echo.
powershell -NoProfile -Command "Get-DnsClientServerAddress | Format-Table -Auto"

call :Pause
goto MODULE_NETWORK


:NET_ARP

call :Header "NETWORK - ARP TABLE"

arp -a | more
call :Pause
goto MODULE_NETWORK


:NET_ROUTE

call :Header "NETWORK - ROUTING TABLE"

route print | more
call :Pause
goto MODULE_NETWORK


:NET_NETSTAT

call :Header "NETWORK - ACTIVE CONNECTIONS"

netstat -ano | more
call :Pause
goto MODULE_NETWORK


:NET_PING_GATEWAY

call :Header "NETWORK - PING GATEWAY"

set "GW="

for /f "tokens=3" %%A in ('ipconfig ^| findstr /R /C:"Default Gateway"') do (
    if not "%%A"=="" set "GW=%%A"
)

if defined GW (
    ping -n 4 %GW%
) else (
    echo.
    echo  Default Gateway could not be detected.
)

call :Pause
goto MODULE_NETWORK


:NET_PING_INTERNET

call :Header "NETWORK - PING INTERNET"

ping -n 4 8.8.8.8

call :Pause
goto MODULE_NETWORK


:NET_TRACERT

call :Header "NETWORK - TRACEROUTE"

set "TARGET="
set /p "TARGET=  Enter host or IP: "

if not defined TARGET set "TARGET=8.8.8.8"

tracert %TARGET%

call :Log "Network - Traceroute %TARGET%"
call :Pause
goto MODULE_NETWORK


:NET_FLUSH_DNS

call :Header "NETWORK - FLUSH DNS"

ipconfig /flushdns

call :Log "Network - DNS Cache Flushed"
call :Pause
goto MODULE_NETWORK


:NET_WINSOCK

call :Header "NETWORK - WINSOCK RESET"

echo.
echo  Winsock reset requires administrator privileges.
echo.

call :Confirm "Continue with Winsock reset"

if errorlevel 1 goto MODULE_NETWORK

netsh winsock reset

call :Log "Network - Winsock Reset"
call :Pause
goto MODULE_NETWORK


:NET_TCPIP

call :Header "NETWORK - TCP/IP RESET"

echo.
echo  TCP/IP reset may require a restart.
echo.

call :Confirm "Continue with TCP/IP reset"

if errorlevel 1 goto MODULE_NETWORK

netsh int ip reset

call :Log "Network - TCP/IP Reset"
call :Pause
goto MODULE_NETWORK


:: ####################################################################
:: 04 - INTERNET TROUBLESHOOTING
:: ####################################################################

:INTERNET

call :Header "04 - INTERNET TROUBLESHOOTING"

echo.
echo        [01] Check Network Adapter
echo        [02] Test Default Gateway
echo        [03] Test DNS
echo        [04] Test Internet Connectivity
echo        [05] Test Website
echo        [06] NSLOOKUP
echo        [07] Renew IP Address
echo        [08] Flush DNS
echo        [09] Full Internet Test
echo        [10] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    powershell -NoProfile -Command "Get-NetAdapter | Format-Table Name,Status,LinkSpeed -Auto"
    call :Pause
    goto INTERNET
)

if "%sub%"=="2" goto INTERNET_GATEWAY
if "%sub%"=="3" goto INTERNET_DNS
if "%sub%"=="4" goto INTERNET_CONNECTIVITY
if "%sub%"=="5" goto INTERNET_WEBSITE
if "%sub%"=="6" goto INTERNET_NSLOOKUP

if "%sub%"=="7" (
    ipconfig /release
    ipconfig /renew
    call :Log "Internet - Renewed IP Address"
    call :Pause
    goto INTERNET
)

if "%sub%"=="8" (
    ipconfig /flushdns
    call :Pause
    goto INTERNET
)

if "%sub%"=="9" goto INTERNET_FULL
if "%sub%"=="10" goto MAIN_MENU

call :Invalid
goto INTERNET


:INTERNET_GATEWAY

call :Header "INTERNET - GATEWAY TEST"

set "GW="

for /f "tokens=3" %%A in ('ipconfig ^| findstr /R /C:"Default Gateway"') do (
    if not "%%A"=="" set "GW=%%A"
)

if defined GW (
    ping -n 4 %GW%
) else (
    echo  Gateway not detected.
)

call :Pause
goto INTERNET


:INTERNET_DNS

call :Header "INTERNET - DNS TEST"

nslookup google.com

call :Pause
goto INTERNET


:INTERNET_CONNECTIVITY

call :Header "INTERNET - CONNECTIVITY TEST"

ping -n 4 8.8.8.8

call :Pause
goto INTERNET


:INTERNET_WEBSITE

call :Header "INTERNET - WEBSITE TEST"

set "TARGET="
set /p "TARGET=  Enter website/domain: "

if not defined TARGET set "TARGET=google.com"

powershell -NoProfile -Command "try {$r=Invoke-WebRequest -Uri ('https://' + '%TARGET%') -Method Head -TimeoutSec 10; Write-Host ('HTTP Status: ' + $r.StatusCode)} catch {Write-Host ('Website test failed: ' + $_.Exception.Message)}"

call :Pause
goto INTERNET


:INTERNET_NSLOOKUP

call :Header "INTERNET - NSLOOKUP"

set "TARGET="
set /p "TARGET=  Enter domain: "

if not defined TARGET set "TARGET=google.com"

nslookup %TARGET%

call :Pause
goto INTERNET


:INTERNET_FULL

call :Header "INTERNET - FULL TEST"

echo.
echo  [1] Network Adapter
echo  --------------------------------------------------------------
powershell -NoProfile -Command "Get-NetAdapter | Format-Table Name,Status,LinkSpeed -Auto"

echo.
echo  [2] Gateway
echo  --------------------------------------------------------------

set "GW="

for /f "tokens=3" %%A in ('ipconfig ^| findstr /R /C:"Default Gateway"') do (
    if not "%%A"=="" set "GW=%%A"
)

if defined GW ping -n 2 %GW%

echo.
echo  [3] Internet Connectivity
echo  --------------------------------------------------------------
ping -n 2 8.8.8.8

echo.
echo  [4] DNS
echo  --------------------------------------------------------------
nslookup google.com

echo.
echo  [5] HTTPS
echo  --------------------------------------------------------------
powershell -NoProfile -Command "try {$r=Invoke-WebRequest -Uri 'https://www.microsoft.com' -Method Head -TimeoutSec 10; Write-Host ('HTTP Status: ' + $r.StatusCode)} catch {Write-Host 'HTTPS test failed.'}"

call :Log "Internet - Full Internet Test"
call :Pause
goto INTERNET


:: ####################################################################
:: 05 - WINDOWS REPAIR
:: ####################################################################

:WINDOWS_REPAIR

call :Header "05 - WINDOWS REPAIR"

echo.
echo        [01] SFC Scan
echo        [02] DISM CheckHealth
echo        [03] DISM ScanHealth
echo        [04] DISM RestoreHealth
echo        [05] CHKDSK Online Scan
echo        [06] Component Cleanup
echo        [07] Windows Troubleshooter
echo        [08] Event Viewer
echo        [09] Reset Windows Update Components
echo        [10] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" goto REPAIR_SFC
if "%sub%"=="2" goto REPAIR_DISM_CHECK
if "%sub%"=="3" goto REPAIR_DISM_SCAN
if "%sub%"=="4" goto REPAIR_DISM_RESTORE
if "%sub%"=="5" goto REPAIR_CHKDSK
if "%sub%"=="6" goto REPAIR_CLEANUP

if "%sub%"=="7" (
    start "" ms-settings:troubleshoot
    goto WINDOWS_REPAIR
)

if "%sub%"=="8" (
    start "" eventvwr.msc
    goto WINDOWS_REPAIR
)

if "%sub%"=="9" goto REPAIR_WU_RESET
if "%sub%"=="10" goto MAIN_MENU

call :Invalid
goto WINDOWS_REPAIR


:REPAIR_SFC

call :Header "WINDOWS REPAIR - SFC"

echo.
echo  Running System File Checker...
echo.

sfc /scannow

call :Log "Windows Repair - SFC Scan"
call :Pause
goto WINDOWS_REPAIR


:REPAIR_DISM_CHECK

call :Header "WINDOWS REPAIR - DISM CHECK"

DISM /Online /Cleanup-Image /CheckHealth

call :Pause
goto WINDOWS_REPAIR


:REPAIR_DISM_SCAN

call :Header "WINDOWS REPAIR - DISM SCAN"

DISM /Online /Cleanup-Image /ScanHealth

call :Pause
goto WINDOWS_REPAIR


:REPAIR_DISM_RESTORE

call :Header "WINDOWS REPAIR - DISM RESTORE"

echo.
echo  This operation can take considerable time.
echo.

call :Confirm "Run DISM RestoreHealth"

if errorlevel 1 goto WINDOWS_REPAIR

DISM /Online /Cleanup-Image /RestoreHealth

call :Log "Windows Repair - DISM RestoreHealth"
call :Pause
goto WINDOWS_REPAIR


:REPAIR_CHKDSK

call :Header "WINDOWS REPAIR - CHKDSK"

chkdsk C: /scan

call :Log "Windows Repair - CHKDSK C Scan"
call :Pause
goto WINDOWS_REPAIR


:REPAIR_CLEANUP

call :Header "WINDOWS REPAIR - COMPONENT CLEANUP"

DISM /Online /Cleanup-Image /StartComponentCleanup

call :Log "Windows Repair - Component Cleanup"
call :Pause
goto WINDOWS_REPAIR


:REPAIR_WU_RESET

call :Header "WINDOWS UPDATE - COMPONENT RESET"

echo.
echo  Stopping Windows Update services...
echo.

net stop wuauserv
net stop bits
net stop cryptsvc
net stop msiserver

echo.
echo  Renaming update cache folders...
echo.

ren "%windir%\SoftwareDistribution" SoftwareDistribution.old 2>nul
ren "%windir%\System32\catroot2" catroot2.old 2>nul

echo.
echo  Starting Windows Update services...
echo.

net start wuauserv
net start bits
net start cryptsvc
net start msiserver

call :Log "Windows Update - Component Reset"
call :Pause
goto WINDOWS_REPAIR


:: ####################################################################
:: 06 - DISK & STORAGE
:: ####################################################################

:DISK_STORAGE

call :Header "06 - DISK & STORAGE"

echo.
echo        [01] Volume Information
echo        [02] Physical Disk Health
echo        [03] Disk Management
echo        [04] CHKDSK
echo        [05] Optimize Drives
echo        [06] Temporary Files
echo        [07] Storage Settings
echo        [08] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    powershell -NoProfile -Command "Get-Volume | Where-Object DriveLetter | Select DriveLetter,FileSystemLabel,FileSystem,@{N='SizeGB';E={[math]::Round($_.Size/1GB,2)}},@{N='FreeGB';E={[math]::Round($_.SizeRemaining/1GB,2)}} | Format-Table -Auto"
    call :Pause
    goto DISK_STORAGE
)

if "%sub%"=="2" (
    powershell -NoProfile -Command "Get-PhysicalDisk | Select FriendlyName,MediaType,HealthStatus,OperationalStatus,@{N='SizeGB';E={[math]::Round($_.Size/1GB,2)}} | Format-Table -Auto"
    call :Pause
    goto DISK_STORAGE
)

if "%sub%"=="3" (
    start "" diskmgmt.msc
    goto DISK_STORAGE
)

if "%sub%"=="4" (
    chkdsk C: /scan
    call :Pause
    goto DISK_STORAGE
)

if "%sub%"=="5" (
    start "" dfrgui.exe
    goto DISK_STORAGE
)

if "%sub%"=="6" (
    start "" "%TEMP%"
    start "" "%windir%\Temp"
    call :Log "Disk - Temporary Files"
    goto DISK_STORAGE
)

if "%sub%"=="7" (
    start "" ms-settings:storagesense
    goto DISK_STORAGE
)

if "%sub%"=="8" goto MAIN_MENU

call :Invalid
goto DISK_STORAGE


:: ####################################################################
:: 07 - PERFORMANCE
:: ####################################################################

:PERFORMANCE

call :Header "07 - PERFORMANCE"

echo.
echo        [01] Task Manager
echo        [02] Process List
echo        [03] Top CPU Processes
echo        [04] Top Memory Processes
echo        [05] Performance Monitor
echo        [06] Resource Monitor
echo        [07] Startup Apps
echo        [08] System Uptime
echo        [09] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    taskmgr.exe
    goto PERFORMANCE
)

if "%sub%"=="2" (
    tasklist | more
    call :Pause
    goto PERFORMANCE
)

if "%sub%"=="3" (
    powershell -NoProfile -Command "Get-Process | Sort-Object CPU -Descending | Select -First 15 Name,Id,@{N='CPU_s';E={[math]::Round($_.CPU,1)}} | Format-Table -Auto"
    call :Pause
    goto PERFORMANCE
)

if "%sub%"=="4" (
    powershell -NoProfile -Command "Get-Process | Sort-Object WorkingSet64 -Descending | Select -First 15 Name,Id,@{N='MemoryMB';E={[math]::Round($_.WorkingSet64/1MB,1)}} | Format-Table -Auto"
    call :Pause
    goto PERFORMANCE
)

if "%sub%"=="5" (
    start "" perfmon.exe
    goto PERFORMANCE
)

if "%sub%"=="6" (
    start "" resmon.exe
    goto PERFORMANCE
)

if "%sub%"=="7" (
    start "" ms-settings:startupapps
    goto PERFORMANCE
)

if "%sub%"=="8" (
    powershell -NoProfile -Command "$os=Get-CimInstance Win32_OperatingSystem; Write-Host ('Last Boot: ' + $os.LastBootUpTime)"
    call :Pause
    goto PERFORMANCE
)

if "%sub%"=="9" goto MAIN_MENU

call :Invalid
goto PERFORMANCE


:: ####################################################################
:: 08 - SERVICES
:: ####################################################################

:SERVICES

call :Header "08 - SERVICES MANAGEMENT"

echo.
echo        [01] Services Console
echo        [02] Running Services
echo        [03] Stopped Services
echo        [04] Search Service
echo        [05] Start Service
echo        [06] Stop Service
echo        [07] Restart Service
echo        [08] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    start "" services.msc
    goto SERVICES
)

if "%sub%"=="2" (
    powershell -NoProfile -Command "Get-Service | Where Status -eq 'Running' | Sort DisplayName | Format-Table Status,Name,DisplayName -Auto"
    call :Pause
    goto SERVICES
)

if "%sub%"=="3" (
    powershell -NoProfile -Command "Get-Service | Where Status -eq 'Stopped' | Sort DisplayName | Format-Table Status,Name,DisplayName -Auto"
    call :Pause
    goto SERVICES
)

if "%sub%"=="4" (
    set "SVC="
    set /p "SVC=  Enter service name or display name: "
    powershell -NoProfile -Command "Get-Service -ErrorAction SilentlyContinue | Where {$_.Name -like '*%SVC%*' -or $_.DisplayName -like '*%SVC%*'} | Format-Table Status,Name,DisplayName -Auto"
    call :Pause
    goto SERVICES
)

if "%sub%"=="5" (
    set "SVC="
    set /p "SVC=  Enter service name: "
    net start "%SVC%"
    call :Log "Services - Start %SVC%"
    call :Pause
    goto SERVICES
)

if "%sub%"=="6" (
    set "SVC="
    set /p "SVC=  Enter service name: "
    net stop "%SVC%"
    call :Log "Services - Stop %SVC%"
    call :Pause
    goto SERVICES
)

if "%sub%"=="7" (
    set "SVC="
    set /p "SVC=  Enter service name: "
    net stop "%SVC%"
    timeout /t 2 /nobreak >nul
    net start "%SVC%"
    call :Log "Services - Restart %SVC%"
    call :Pause
    goto SERVICES
)

if "%sub%"=="8" goto MAIN_MENU

call :Invalid
goto SERVICES


:: ####################################################################
:: 09 - USER & ACCOUNT TOOLS
:: ####################################################################

:USER_TOOLS

call :Header "09 - USER & ACCOUNT TOOLS"

echo.
echo        [01] Current User
echo        [02] Local Users
echo        [03] Local Administrators
echo        [04] Computer Management
echo        [05] User Accounts
echo        [06] Password Policy
echo        [07] Logged-on Users
echo        [08] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    whoami
    echo.
    whoami /all | more
    call :Pause
    goto USER_TOOLS
)

if "%sub%"=="2" (
    net user | more
    call :Pause
    goto USER_TOOLS
)

if "%sub%"=="3" (
    net localgroup administrators | more
    call :Pause
    goto USER_TOOLS
)

if "%sub%"=="4" (
    start "" compmgmt.msc
    goto USER_TOOLS
)

if "%sub%"=="5" (
    start "" netplwiz.exe
    goto USER_TOOLS
)

if "%sub%"=="6" (
    net accounts
    call :Pause
    goto USER_TOOLS
)

if "%sub%"=="7" (
    query user
    call :Pause
    goto USER_TOOLS
)

if "%sub%"=="8" goto MAIN_MENU

call :Invalid
goto USER_TOOLS


:: ####################################################################
:: 10 - DRIVER & DEVICE TOOLS
:: ####################################################################

:DRIVER_TOOLS

call :Header "10 - DRIVER & DEVICE TOOLS"

echo.
echo        [01] Device Manager
echo        [02] Installed Drivers
echo        [03] Problem Devices
echo        [04] Plug and Play Devices
echo        [05] Driver Verifier
echo        [06] DirectX Diagnostic
echo        [07] Driver Store
echo        [08] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    start "" devmgmt.msc
    goto DRIVER_TOOLS
)

if "%sub%"=="2" (
    powershell -NoProfile -Command "Get-CimInstance Win32_PnPSignedDriver | Select DeviceName,DriverVersion,DriverDate,Manufacturer | Sort DeviceName | Format-Table -Auto"
    call :Pause
    goto DRIVER_TOOLS
)

if "%sub%"=="3" (
    powershell -NoProfile -Command "Get-PnpDevice | Where {$_.Status -ne 'OK'} | Format-Table Status,Class,FriendlyName,InstanceId -Auto"
    call :Pause
    goto DRIVER_TOOLS
)

if "%sub%"=="4" (
    powershell -NoProfile -Command "Get-PnpDevice | Format-Table Status,Class,FriendlyName -Auto"
    call :Pause
    goto DRIVER_TOOLS
)

if "%sub%"=="5" (
    verifier.exe
    goto DRIVER_TOOLS
)

if "%sub%"=="6" (
    dxdiag.exe
    goto DRIVER_TOOLS
)

if "%sub%"=="7" (
    pnputil /enum-drivers | more
    call :Pause
    goto DRIVER_TOOLS
)

if "%sub%"=="8" goto MAIN_MENU

call :Invalid
goto DRIVER_TOOLS


:: ####################################################################
:: 11 - WINDOWS UPDATE
:: ####################################################################

:WINDOWS_UPDATE

call :Header "11 - WINDOWS UPDATE"

echo.
echo        [01] Windows Update
echo        [02] Update History
echo        [03] Advanced Update Settings
echo        [04] Windows Update Service
echo        [05] Restart Update Service
echo        [06] Reset Update Components
echo        [07] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    start "" ms-settings:windowsupdate
    goto WINDOWS_UPDATE
)

if "%sub%"=="2" (
    start "" ms-settings:windowsupdate-history
    goto WINDOWS_UPDATE
)

if "%sub%"=="3" (
    start "" ms-settings:windowsupdate-options
    goto WINDOWS_UPDATE
)

if "%sub%"=="4" (
    sc query wuauserv | more
    call :Pause
    goto WINDOWS_UPDATE
)

if "%sub%"=="5" (
    net stop wuauserv
    net start wuauserv
    call :Log "Windows Update - Service Restart"
    call :Pause
    goto WINDOWS_UPDATE
)

if "%sub%"=="6" goto REPAIR_WU_RESET
if "%sub%"=="7" goto MAIN_MENU

call :Invalid
goto WINDOWS_UPDATE


:: ####################################################################
:: 12 - SECURITY & FIREWALL
:: ####################################################################

:SECURITY

call :Header "12 - SECURITY & FIREWALL"

echo.
echo        [01] Windows Security
echo        [02] Firewall Status
echo        [03] Firewall Profiles
echo        [04] Firewall Rules
echo        [05] Windows Defender Status
echo        [06] Advanced Firewall
echo        [07] Enable Firewall
echo        [08] Disable Firewall
echo        [09] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    start "" windowsdefender:
    goto SECURITY
)

if "%sub%"=="2" (
    netsh advfirewall show allprofiles
    call :Pause
    goto SECURITY
)

if "%sub%"=="3" (
    powershell -NoProfile -Command "Get-NetFirewallProfile | Format-Table Name,Enabled,DefaultInboundAction,DefaultOutboundAction -Auto"
    call :Pause
    goto SECURITY
)

if "%sub%"=="4" (
    powershell -NoProfile -Command "Get-NetFirewallRule | Select DisplayName,Enabled,Direction,Action,Profile | Format-Table -Auto"
    call :Pause
    goto SECURITY
)

if "%sub%"=="5" (
    powershell -NoProfile -Command "Get-MpComputerStatus | Select AntivirusEnabled,AntispywareEnabled,RealTimeProtectionEnabled,AMServiceEnabled,AntivirusSignatureLastUpdated | Format-List"
    call :Pause
    goto SECURITY
)

if "%sub%"=="6" (
    start "" wf.msc
    goto SECURITY
)

if "%sub%"=="7" goto FIREWALL_ENABLE
if "%sub%"=="8" goto FIREWALL_DISABLE
if "%sub%"=="9" goto MAIN_MENU

call :Invalid
goto SECURITY


:FIREWALL_ENABLE

call :Header "SECURITY - ENABLE FIREWALL"

call :Confirm "Enable Windows Firewall on all profiles"

if errorlevel 1 goto SECURITY

netsh advfirewall set allprofiles state on

call :Log "Security - Firewall Enabled"
call :Pause
goto SECURITY


:FIREWALL_DISABLE

call :Header "SECURITY - DISABLE FIREWALL"

echo.
echo  WARNING:
echo  Disabling Windows Firewall reduces network protection.
echo.

call :Confirm "Disable Windows Firewall on all profiles"

if errorlevel 1 goto SECURITY

netsh advfirewall set allprofiles state off

call :Log "Security - Firewall Disabled"
call :Pause
goto SECURITY


:: ####################################################################
:: 13 - WI-FI TOOLS
:: ####################################################################

:WIFI_TOOLS

call :Header "13 - WI-FI TOOLS"

echo.
echo        [01] Wi-Fi Interface
echo        [02] Available Networks
echo        [03] Saved Wi-Fi Profiles
echo        [04] Wi-Fi Driver
echo        [05] Signal Information
echo        [06] WLAN Report
echo        [07] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    netsh wlan show interfaces
    call :Pause
    goto WIFI_TOOLS
)

if "%sub%"=="2" (
    netsh wlan show networks mode=bssid
    call :Pause
    goto WIFI_TOOLS
)

if "%sub%"=="3" (
    netsh wlan show profiles
    call :Pause
    goto WIFI_TOOLS
)

if "%sub%"=="4" (
    netsh wlan show drivers
    call :Pause
    goto WIFI_TOOLS
)

if "%sub%"=="5" (
    netsh wlan show interfaces
    call :Pause
    goto WIFI_TOOLS
)

if "%sub%"=="6" (
    netsh wlan show wlanreport
    echo.
    echo  WLAN report generated by Windows.
    echo.
    echo  C:\ProgramData\Microsoft\Windows\WlanReport
    call :Log "Wi-Fi - WLAN Report"
    call :Pause
    goto WIFI_TOOLS
)

if "%sub%"=="7" goto MAIN_MENU

call :Invalid
goto WIFI_TOOLS


:: ####################################################################
:: 14 - REPORT GENERATOR
:: ####################################################################

:REPORTS

call :Header "14 - REPORT GENERATOR"

echo.
echo        [01] System Report
echo        [02] Network Report
echo        [03] Hardware Report
echo        [04] Full Diagnostic Report
echo        [05] Open Reports Folder
echo        [06] Open Logs Folder
echo        [07] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" goto REPORT_SYSTEM
if "%sub%"=="2" goto REPORT_NETWORK
if "%sub%"=="3" goto REPORT_HARDWARE
if "%sub%"=="4" goto REPORT_FULL

if "%sub%"=="5" (
    start "" "%REPORTDIR%"
    goto REPORTS
)

if "%sub%"=="6" (
    start "" "%LOGDIR%"
    goto REPORTS
)

if "%sub%"=="7" goto MAIN_MENU

call :Invalid
goto REPORTS


:REPORT_SYSTEM

call :CreateStamp

set "REPORTFILE=%REPORTDIR%\System-Report-%STAMP%.txt"

(
echo ==================================================================
echo              ULTIMATE IT SUPPORT TOOLKIT
echo                   PROFESSIONAL EDITION
echo ==================================================================
echo Developed ^& Maintained By : %AUTHOR%
echo Copyright                 : 2026 Hasif Khan
echo Project ID                : %PROJECT_ID%
echo Version                   : %APP_VERSION%
echo Date                      : %date%
echo Time                      : %time%
echo Computer                  : %COMPUTERNAME%
echo User                      : %USERNAME%
echo Administrator Status      : %ADMIN_STATUS%
echo ==================================================================
echo.
echo [OPERATING SYSTEM]
powershell -NoProfile -Command "Get-CimInstance Win32_OperatingSystem | Select Caption,Version,BuildNumber,OSArchitecture,InstallDate,LastBootUpTime | Format-List"
echo.
echo [COMPUTER]
powershell -NoProfile -Command "Get-CimInstance Win32_ComputerSystem | Select Manufacturer,Model,SystemType,@{N='RAM_GB';E={[math]::Round($_.TotalPhysicalMemory/1GB,2)}} | Format-List"
echo.
echo [CPU]
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed | Format-List"
) > "%REPORTFILE%" 2>&1

echo.
echo  SYSTEM REPORT CREATED
echo.
echo  %REPORTFILE%

call :Log "Report Created - System"
call :Pause
goto REPORTS


:REPORT_NETWORK

call :CreateStamp

set "REPORTFILE=%REPORTDIR%\Network-Report-%STAMP%.txt"

(
echo ==================================================================
echo              ULTIMATE IT SUPPORT TOOLKIT
echo                   PROFESSIONAL EDITION
echo ==================================================================
echo Developed ^& Maintained By : %AUTHOR%
echo Copyright                 : 2026 Hasif Khan
echo Project ID                : %PROJECT_ID%
echo Version                   : %APP_VERSION%
echo Date                      : %date%
echo Time                      : %time%
echo Computer                  : %COMPUTERNAME%
echo User                      : %USERNAME%
echo ==================================================================
echo.
echo [IP CONFIGURATION]
ipconfig /all
echo.
echo [ROUTING TABLE]
route print
echo.
echo [ARP TABLE]
arp -a
echo.
echo [ACTIVE CONNECTIONS]
netstat -ano
echo.
echo [WI-FI]
netsh wlan show interfaces
) > "%REPORTFILE%" 2>&1

echo.
echo  NETWORK REPORT CREATED
echo.
echo  %REPORTFILE%

call :Log "Report Created - Network"
call :Pause
goto REPORTS


:REPORT_HARDWARE

call :CreateStamp

set "REPORTFILE=%REPORTDIR%\Hardware-Report-%STAMP%.txt"

(
echo ==================================================================
echo              ULTIMATE IT SUPPORT TOOLKIT
echo                   PROFESSIONAL EDITION
echo ==================================================================
echo Developed ^& Maintained By : %AUTHOR%
echo Copyright                 : 2026 Hasif Khan
echo Project ID                : %PROJECT_ID%
echo Version                   : %APP_VERSION%
echo Date                      : %date%
echo Time                      : %time%
echo Computer                  : %COMPUTERNAME%
echo ==================================================================
echo.
echo [CPU]
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Format-List Name,Manufacturer,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed"
echo.
echo [MEMORY]
powershell -NoProfile -Command "Get-CimInstance Win32_PhysicalMemory | Select Manufacturer,PartNumber,@{N='CapacityGB';E={[math]::Round($_.Capacity/1GB,2)}},Speed | Format-Table -Auto"
echo.
echo [DISKS]
powershell -NoProfile -Command "Get-PhysicalDisk | Select FriendlyName,MediaType,HealthStatus,OperationalStatus,@{N='SizeGB';E={[math]::Round($_.Size/1GB,2)}} | Format-Table -Auto"
echo.
echo [PROBLEM DEVICES]
powershell -NoProfile -Command "Get-PnpDevice | Where {$_.Status -ne 'OK'} | Format-Table Status,Class,FriendlyName -Auto"
) > "%REPORTFILE%" 2>&1

echo.
echo  HARDWARE REPORT CREATED
echo.
echo  %REPORTFILE%

call :Log "Report Created - Hardware"
call :Pause
goto REPORTS


:REPORT_FULL

call :CreateStamp

set "REPORTFILE=%REPORTDIR%\Full-Diagnostic-%STAMP%.txt"

(
echo ##################################################################
echo #                                                                #
echo #             ULTIMATE IT SUPPORT TOOLKIT                       #
echo #                  PROFESSIONAL EDITION                          #
echo #                                                                #
echo #              Developed ^& Maintained By                        #
echo #                       HASIF KHAN                               #
echo #                                                                #
echo # Copyright (c) 2026 Hasif Khan. All Rights Reserved.           #
echo # Project ID : %PROJECT_ID%                                     #
echo #                                                                #
echo ##################################################################
echo.
echo Date     : %date%
echo Time     : %time%
echo Computer : %COMPUTERNAME%
echo User     : %USERNAME%
echo Status   : %ADMIN_STATUS%
echo.
echo ================================================================
echo [SYSTEM INFORMATION]
echo ================================================================
systeminfo
echo.
echo ================================================================
echo [IP CONFIGURATION]
echo ================================================================
ipconfig /all
echo.
echo ================================================================
echo [ROUTING TABLE]
echo ================================================================
route print
echo.
echo ================================================================
echo [ARP TABLE]
echo ================================================================
arp -a
echo.
echo ================================================================
echo [ACTIVE CONNECTIONS]
echo ================================================================
netstat -ano
echo.
echo ================================================================
echo [CPU]
echo ================================================================
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Format-List Name,NumberOfCores,NumberOfLogicalProcessors"
echo.
echo ================================================================
echo [MEMORY]
echo ================================================================
powershell -NoProfile -Command "Get-CimInstance Win32_PhysicalMemory | Select Manufacturer,PartNumber,@{N='CapacityGB';E={[math]::Round($_.Capacity/1GB,2)}},Speed | Format-Table -Auto"
echo.
echo ================================================================
echo [DISK]
echo ================================================================
powershell -NoProfile -Command "Get-PhysicalDisk | Format-Table FriendlyName,MediaType,HealthStatus,OperationalStatus,@{N='SizeGB';E={[math]::Round($_.Size/1GB,2)}} -Auto"
echo.
echo ================================================================
echo [NETWORK ADAPTERS]
echo ================================================================
powershell -NoProfile -Command "Get-NetAdapter | Format-Table Name,Status,LinkSpeed,MacAddress -Auto"
echo.
echo ================================================================
echo [FIREWALL]
echo ================================================================
netsh advfirewall show allprofiles
echo.
echo ================================================================
echo [WI-FI]
echo ================================================================
netsh wlan show interfaces
echo.
echo ================================================================
echo [DEFENDER]
echo ================================================================
powershell -NoProfile -Command "Get-MpComputerStatus | Select AntivirusEnabled,AntispywareEnabled,RealTimeProtectionEnabled,AMServiceEnabled | Format-List"
) > "%REPORTFILE%" 2>&1

echo.
echo  FULL DIAGNOSTIC REPORT CREATED
echo.
echo  %REPORTFILE%

call :Log "Report Created - Full Diagnostic"
call :Pause
goto REPORTS


:: ####################################################################
:: 15 - SYSTEM TOOLS
:: ####################################################################

:SYSTEM_TOOLS

call :Header "15 - SYSTEM TOOLS"

echo.
echo        [01] System Configuration
echo        [02] Event Viewer
echo        [03] Computer Management
echo        [04] Device Manager
echo        [05] Disk Management
echo        [06] Services
echo        [07] Task Scheduler
echo        [08] Local Security Policy
echo        [09] Registry Editor
echo        [10] Group Policy
echo        [11] System Information
echo        [12] Control Panel
echo        [13] Command Prompt
echo        [14] PowerShell
echo        [15] Back
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" (
    start "" msconfig.exe
    goto SYSTEM_TOOLS
)

if "%sub%"=="2" (
    start "" eventvwr.msc
    goto SYSTEM_TOOLS
)

if "%sub%"=="3" (
    start "" compmgmt.msc
    goto SYSTEM_TOOLS
)

if "%sub%"=="4" (
    start "" devmgmt.msc
    goto SYSTEM_TOOLS
)

if "%sub%"=="5" (
    start "" diskmgmt.msc
    goto SYSTEM_TOOLS
)

if "%sub%"=="6" (
    start "" services.msc
    goto SYSTEM_TOOLS
)

if "%sub%"=="7" (
    start "" taskschd.msc
    goto SYSTEM_TOOLS
)

if "%sub%"=="8" (
    start "" secpol.msc
    goto SYSTEM_TOOLS
)

if "%sub%"=="9" (
    start "" regedit.exe
    goto SYSTEM_TOOLS
)

if "%sub%"=="10" (
    start "" gpedit.msc
    goto SYSTEM_TOOLS
)

if "%sub%"=="11" (
    start "" msinfo32.exe
    goto SYSTEM_TOOLS
)

if "%sub%"=="12" (
    start "" control.exe
    goto SYSTEM_TOOLS
)

if "%sub%"=="13" (
    start "" cmd.exe
    goto SYSTEM_TOOLS
)

if "%sub%"=="14" (
    start "" powershell.exe
    goto SYSTEM_TOOLS
)

if "%sub%"=="15" goto MAIN_MENU

call :Invalid
goto SYSTEM_TOOLS


:: ####################################################################
:: 16 - POWER & SHUTDOWN
:: ####################################################################

:POWER

call :Header "16 - POWER & SHUTDOWN"

echo.
echo        [01] Restart Computer
echo        [02] Shutdown Computer
echo        [03] Restart to BIOS / UEFI
echo        [04] Sign Out
echo        [05] Cancel Pending Shutdown
echo        [06] Back
echo.
echo  ------------------------------------------------------------------
echo   WARNING: Power operations affect the current Windows session.
echo  ------------------------------------------------------------------
echo.

set "sub="
set /p "sub=  Select Option: "

if "%sub%"=="1" goto POWER_RESTART
if "%sub%"=="2" goto POWER_SHUTDOWN
if "%sub%"=="3" goto POWER_BIOS
if "%sub%"=="4" goto POWER_SIGNOUT
if "%sub%"=="5" goto POWER_CANCEL
if "%sub%"=="6" goto MAIN_MENU

call :Invalid
goto POWER


:POWER_RESTART

call :Header "POWER - RESTART"

echo.
echo  The computer will restart in 30 seconds.
echo.

call :Confirm "Schedule computer restart"

if errorlevel 1 goto POWER

shutdown /r /t 30 /d p:0:0 /c "Restart initiated by IT Support Toolkit - HASIF KHAN"

call :Log "Power - Restart Scheduled"

echo.
echo  Restart scheduled successfully.
echo  Use "Cancel Pending Shutdown" if you change your mind.

call :Pause
goto MAIN_MENU


:POWER_SHUTDOWN

call :Header "POWER - SHUTDOWN"

echo.
echo  The computer will shut down in 30 seconds.
echo.

call :Confirm "Schedule computer shutdown"

if errorlevel 1 goto POWER

shutdown /s /t 30 /d p:0:0 /c "Shutdown initiated by IT Support Toolkit - HASIF KHAN"

call :Log "Power - Shutdown Scheduled"

echo.
echo  Shutdown scheduled successfully.
echo  Use "Cancel Pending Shutdown" if you change your mind.

call :Pause
goto MAIN_MENU


:POWER_BIOS

call :Header "POWER - BIOS / UEFI"

echo.
echo  The computer will restart directly into firmware settings.
echo.

call :Confirm "Restart to BIOS / UEFI"

if errorlevel 1 goto POWER

shutdown /r /fw /t 0

exit /b


:POWER_SIGNOUT

call :Header "POWER - SIGN OUT"

echo.

call :Confirm "Sign out current Windows user"

if errorlevel 1 goto POWER

shutdown /l

exit /b


:POWER_CANCEL

call :Header "POWER - CANCEL SHUTDOWN"

shutdown /a

call :Log "Power - Pending Shutdown Cancelled"
call :Pause
goto POWER


:: ####################################################################
:: 17 - QUICK IT HEALTH CHECK
:: ####################################################################

:HEALTH_CHECK

call :Header "17 - QUICK IT HEALTH CHECK"

echo.
echo  Running automated health checks...
echo.

echo  ================================================================
echo   [01] OPERATING SYSTEM
echo  ================================================================

powershell -NoProfile -Command "Get-CimInstance Win32_OperatingSystem | Select Caption,Version,BuildNumber | Format-List"

echo.
echo  ================================================================
echo   [02] CPU
echo  ================================================================

powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select Name,NumberOfCores,NumberOfLogicalProcessors | Format-List"

echo.
echo  ================================================================
echo   [03] MEMORY
echo  ================================================================

powershell -NoProfile -Command "$os=Get-CimInstance Win32_OperatingSystem; Write-Host ('Total RAM : ' + [math]::Round($os.TotalVisibleMemorySize/1MB,2) + ' GB'); Write-Host ('Free RAM  : ' + [math]::Round($os.FreePhysicalMemory/1MB,2) + ' GB')"

echo.
echo  ================================================================
echo   [04] DISK
echo  ================================================================

powershell -NoProfile -Command "Get-Volume -DriveLetter C | Select DriveLetter,@{N='SizeGB';E={[math]::Round($_.Size/1GB,2)}},@{N='FreeGB';E={[math]::Round($_.SizeRemaining/1GB,2)}} | Format-List"

echo.
echo  ================================================================
echo   [05] NETWORK ADAPTER
echo  ================================================================

powershell -NoProfile -Command "Get-NetAdapter | Where Status -eq 'Up' | Format-Table Name,Status,LinkSpeed -Auto"

echo.
echo  ================================================================
echo   [06] INTERNET PING
echo  ================================================================

ping -n 2 8.8.8.8

echo.
echo  ================================================================
echo   [07] DNS
echo  ================================================================

nslookup google.com

echo.
echo  ================================================================
echo   [08] FIREWALL
echo  ================================================================

powershell -NoProfile -Command "Get-NetFirewallProfile | Format-Table Name,Enabled -Auto"

echo.
echo  ================================================================
echo                     HEALTH CHECK COMPLETE
echo  ================================================================

call :Log "Quick IT Health Check Completed"
call :Pause
goto MAIN_MENU


:: ####################################################################
:: EXIT
:: ####################################################################

:EXIT_APP

cls
color 0B

echo.
echo.
echo  +------------------------------------------------------------------+
echo  ^|                                                                  ^|
echo  ^|              ULTIMATE IT SUPPORT TOOLKIT                        ^|
echo  ^|                   PROFESSIONAL EDITION                           ^|
echo  ^|                                                                  ^|
echo  ^|                    HASIF KHAN                                    ^|
echo  ^|                                                                  ^|
echo  ^|              Copyright (c) 2026 Hasif Khan                      ^|
echo  ^|                                                                  ^|
echo  +------------------------------------------------------------------+
echo  ^|                                                                  ^|
echo  ^|                 Thank you for using the toolkit.                 ^|
echo  ^|                                                                  ^|
echo  +------------------------------------------------------------------+
echo.

timeout /t 2 /nobreak >nul

endlocal
exit /b


:: ####################################################################
:: COMMON HEADER
:: ####################################################################

:Header

cls
color 0B

:: Get live system information
set "HEADER_PC=%COMPUTERNAME%"
set "HEADER_USER=%USERNAME%"
set "HEADER_WIN=%WINVER%"

if not defined HEADER_PC set "HEADER_PC=Unknown"
if not defined HEADER_USER set "HEADER_USER=Unknown"
if not defined HEADER_WIN set "HEADER_WIN=Windows"

:: Pad values to maintain the box layout
for /f "delims=" %%A in (
    'powershell -NoProfile -Command "$s=$env:COMPUTERNAME; if($s.Length -gt 52){$s=$s.Substring(0,52)}; '{0,-52}' -f $s"'
) do set "PCPAD=%%A"

for /f "delims=" %%A in (
    'powershell -NoProfile -Command "$s=$env:USERNAME; if($s.Length -gt 52){$s=$s.Substring(0,52)}; '{0,-52}' -f $s"'
) do set "USERPAD=%%A"

for /f "delims=" %%A in (
    'powershell -NoProfile -Command "$s=$env:WINVER; if($s.Length -gt 52){$s=$s.Substring(0,52)}; '{0,-52}' -f $s"'
) do set "WINPAD=%%A"

echo.
echo  +------------------------------------------------------------------+
echo  ^|                                                                  ^|
echo  ^|             ULTIMATE IT SUPPORT TOOLKIT                         ^|
echo  ^|                  PROFESSIONAL EDITION                            ^|
echo  ^|                                                                  ^|
echo  ^|             Developed ^& Maintained By                            ^|
echo  ^|                    HASIF KHAN                                    ^|
echo  ^|                                                                  ^|
echo  +------------------------------------------------------------------+
echo  ^|  SYSTEM STATUS                                                   ^|
echo  ^|  Computer : %PCPAD%^|
echo  ^|  User     : %USERPAD%^|
echo  ^|  Windows  : %WINPAD%^|
echo  +------------------------------------------------------------------+
echo.
echo                         %~1
echo.

exit /b


:: ####################################################################
:: CONFIRMATION
:: ####################################################################

:Confirm

echo.

set "CONFIRM="
set /p "CONFIRM=  %~1 [Y/N]: "

if /I "%CONFIRM%"=="Y" exit /b 0
if /I "%CONFIRM%"=="YES" exit /b 0

echo.
echo  Operation cancelled.

exit /b 1


:: ####################################################################
:: TIMESTAMP
:: ####################################################################

:CreateStamp

for /f "delims=" %%A in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss"') do set "STAMP=%%A"

exit /b


:: ####################################################################
:: LOGGING
:: ####################################################################

:Log

call :CreateStamp

>>"%LOGFILE%" echo [%date% %time%] [HASIF KHAN] [Project:%PROJECT_ID%] [%COMPUTERNAME%] [%USERNAME%] %~1

exit /b


:: ####################################################################
:: PAUSE
:: ####################################################################

:Pause

echo.
echo  ------------------------------------------------------------------
pause

exit /b


:: ####################################################################
:: INVALID INPUT
:: ####################################################################

:Invalid

echo.
echo  ------------------------------------------------------------------
echo   Invalid selection.
echo   Please select one of the available options.
echo  ------------------------------------------------------------------

timeout /t 2 /nobreak >nul

exit /b