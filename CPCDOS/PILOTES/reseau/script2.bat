@echo off

IF %1==KRNL32 SET DEMKRNL=1

set ramd=%LECTEUR%cpcdos\pilotes\reseau
cd > %ramd%\CD.TMP
CD %ramd%
:Suitee

if %PCIscan%==0 goto NoScan
SHOWMENU Autodetection de la carte reseau
%ramd%\pciscan.exe %ramd%\ndis.map
if not %PCI0%0==0 goto Detected
REM *** Rien detecte, dump PCI infos ***
echo Aucune carte PCI connu detecte
%ramd%\pciscan.exe -v
goto Detected
:NoScan
SHOWMENU *** ATTENTION *** Detection automatique de la carte PCI desactive
:Detected

SHOWMENU Execution du menu
%ramd%\ShowMenu.exe

SHOWMENU Configuration des variables d'environements
ctty nul
call %ramd%\MenuPref.bat >nul
call %ramd%\settemp.bat
del %ramd%\settemp.bat
ctty con
SHOWMENU Sauvegarde des parametres
ctty nul
%COMSPEC% /f /c copy %ramd%\menupref.bat %a%\NetBoot\menupref.bat
ctty con

SHOWMENU Sauvegarde de LMHOSTS
ctty nul
%COMSPEC% /f /c copy %ramd%\LMHOSTS %a%\NetBoot\FILECOPY\LMHOSTS
ctty con

SHOWMENU Installation du partage de fichier
SHARE

SHOWMENU Chargement de IFSHLP.SYS
%ramd%\DEVLOAD /H %ramd%\ifshlp.sys

rem ** Hack for SiS900 autodetect speed/duplex issues **
if %NETCARD%==SIS900_1 copy %ramd%\SIS900_1.INI %ramd%\SIS900.INI
if %NETCARD%==SIS900_2 copy %ramd%\SIS900_2.INI %ramd%\SIS900.INI
if %NETCARD%==SIS900_3 copy %ramd%\SIS900_3.INI %ramd%\SIS900.INI
if %NETCARD%==SIS900_4 copy %ramd%\SIS900_4.INI %ramd%\SIS900.INI
if %NETCARD%==SIS900_1 SET NETCARD=SIS900
if %NETCARD%==SIS900_2 SET NETCARD=SIS900
if %NETCARD%==SIS900_3 SET NETCARD=SIS900
if %NETCARD%==SIS900_4 SET NETCARD=SIS900


SHOWMENU Creation de PROTOCOL.INI
type %ramd%\protocol.1 > %ramd%\PROTOCOL.INI
type %ramd%\%NETCARD%.ini >> %ramd%\PROTOCOL.INI
echo. >> %ramd%\PROTOCOL.INI
type %ramd%\protoADD.txt >> %ramd%\PROTOCOL.INI
echo. >> %ramd%\PROTOCOL.INI
type %ramd%\protocol.2 >> %ramd%\PROTOCOL.INI


SHOWMENU Mise a jour de SYSTEM.INI

REM ** POKE SETTINGS IN TO SYSTEM.INI **
%ramd%\inifile set %ramd%\system.ini -sNetwork -klogondomain -v%WORKGROUP%
%ramd%\inifile set %ramd%\system.ini -sNetwork -kworkgroup -v%WORKGROUP%
%ramd%\inifile set %ramd%\system.ini -sNetwork -kcomputername -v%wkstn%
%ramd%\inifile set %ramd%\system.ini -sNetwork -klanroot -v%ramd%
%ramd%\inifile set %ramd%\system.ini -sNetwork -kpreferredredir -v%REDIRECTOR%
%ramd%\inifile set %ramd%\system.ini -s"network drivers" -kdevdir -v%ramd%
%ramd%\inifile set %ramd%\system.ini -s"network drivers" -knetcard -v%NETCARD%.DOS
 
if %packet%==1 goto P
SHOWMENU Unbinding Packet Driver
%ramd%\inifile set %ramd%\system.ini -s"network drivers" -ktransport -vtcpdrv.dos,nemm.dos
:P

if %DISABLEDHCP%==0 goto D
SHOWMENU Application des parametres TCP/IP
%ramd%\inifile set %ramd%\protocol.ini -stcpip -kDisableDHCP -v%DISABLEDHCP%
if not %DEFAULTGATEWAY0%0==0 %ramd%\inifile set %ramd%\protocol.ini -stcpip -kDEFAULTGATEWAY0 -v"%DEFAULTGATEWAY0%"
%ramd%\inifile set %ramd%\protocol.ini -stcpip -kIPADDRESS0 -v"%IPADDRESS0%"
if not %SUBNETMASK0%0==0 %ramd%\inifile set %ramd%\protocol.ini -stcpip -kSUBNETMASK0 -v"%SUBNETMASK0%"
if not %dns%0==0 %ramd%\inifile set %ramd%\tcputils.ini -sdnr -kNAMESERVER0 -v"%dns%"
if not %WINS%0==0 %ramd%\inifile set %ramd%\protocol.ini -stcpip -kWINS_SERVER0 -v"%WINS%"
:D

SHOWMENU Installation de la carte reseau & demarrage du reseau...
@call %ramd%\startnet.bat

SHOWMENU Recherche de l'adresse MAC
%ramd%\nbmac.exe|%ramd%\set2var mac>%temp%\mac.bat
call %temp%\mac.bat

SHOWMENU Generation d'un IP Config Summary...
echo @echo off > %ramd%\IPCONFIG.BAT
if %DISABLEDHCP%==0 echo echo *** DHCP IP CONFIGURATION *** >> %ramd%\IPCONFIG.BAT
if %DISABLEDHCP%==0 echo @ipconfg %ramd% >> %ramd%\IPCONFIG.BAT
if %DISABLEDHCP%==1 echo echo *** CONFIGURATION IP *** >> %ramd%\IPCONFIG.BAT
if %DISABLEDHCP%==1 echo echo. >> %ramd%\IPCONFIG.BAT
if %DISABLEDHCP%==1 echo echo Adresse IP     : %IPADDRESS0% >> %ramd%\IPCONFIG.BAT
if %DISABLEDHCP%==1 echo echo Masque SR      : %SUBNETMASK0% >> %ramd%\IPCONFIG.BAT
if %DISABLEDHCP%==1 echo echo Passerelle     : %DEFAULTGATEWAY0% >> %ramd%\IPCONFIG.BAT
if %DISABLEDHCP%==1 echo echo Serveur DNS    : %DNS% >> %ramd%\IPCONFIG.BAT
if %DISABLEDHCP%==1 echo echo Serveur WINS   : %WINS% >> %ramd%\IPCONFIG.BAT
if %DISABLEDHCP%==1 echo echo. >> %ramd%\IPCONFIG.BAT
if %DNSENABLE%==1 echo echo DNS Support: Active >> %ramd%\IPCONFIG.BAT 
if %DNSENABLE%==0 echo echo DNS Support: Desactive >> %ramd%\IPCONFIG.BAT
if %PACKET%==1 echo echo Packet Driver Support: Active>> %ramd%\IPCONFIG.BAT 
if %PACKET%==0 echo echo Packet Driver Support: Desactive >> %ramd%\IPCONFIG.BAT
echo echo Adresse MAC: %MAC% >> %ramd%\IPCONFIG.BAT

REM Creer un fichier CpcdosC+ pour recuperer la configuration IP via le noyau
echo REM/ Fichier cree automatiquement lors de l'installation reseau, vous ne pouvez le modifier > %ramd%\..\..\SYSTEME\KRNL\IPCONFIG\IPCONFIG.CPC
echo FIX/ ADRESSE_IP = %IPADDRESS0% >> %ramd%\..\..\SYSTEME\KRNL\IPCONFIG\IPCONFIG.CPC
echo FIX/ MASQUE_SR = %SUBNETMASK0% >> %ramd%\..\..\SYSTEME\KRNL\IPCONFIG\IPCONFIG.CPC
echo FIX/ PASSERELLE = %DEFAULTGATEWAY0% >> %ramd%\..\..\SYSTEME\KRNL\IPCONFIG\IPCONFIG.CPC
echo FIX/ DNS = %DNS% >> %ramd%\..\..\SYSTEME\KRNL\IPCONFIG\IPCONFIG.CPC
echo FIX/ MAC = %MAC% >> %ramd%\..\..\SYSTEME\KRNL\IPCONFIG\IPCONFIG.CPC

if %PROBLEM%==1 goto Stuffed
echo Nom du PC: \\%WKSTN%.  Adresse MAC: %MAC%
if %DISABLEDHCP%==0 echo Pour voir les parametres du DHCP, tapez: IPCONFIG
if %DISABLEDHCP%==1 echo Adresse IP: %IPADDRESS0% Masque SR: %SUBNETMASK0% Passerelle: %DEFAULTGATEWAY0%
SHOWMENU Demarrage du serveur SMB
Net share /yes 
if not %LOGONSCRIPT%0==0 SHOWMENU Executing Logon Script...
if not %LOGONSCRIPT%0==0 call %LOGONSCRIPT%
:endq
Set WORKGROUP=
Set USERNAME=
Set PASSWORD=
Set DISABLEDHCP=
Set IPADDRESS0=
Set SUBNETMASK0=
Set DEFAULTGATEWAY0=
Set DNS=
Set DNSEnable=
Set Packet=
Set LOGONSCRIPT=
Set PCI0=
set CMDLINE=
set PROBLEM=
set MOUSE=
set REDIRECTOR=
set CD=
set UDMA=
set WINS=
goto TheEnd

:Stuffed
echo ERROR! Part of the Network Client and/or Drivers has failed to load. 
echo The scripted failed while executing this command: %CMDLINE%
echo Please note any error message(s) given above.
echo.
echo Now Aborting...
goto TheEnd
:TheEnd
set /p VAR= < CD.TMP
cd %VAR%

IF %DEMKRNL%==1 KRNL32.BAT

