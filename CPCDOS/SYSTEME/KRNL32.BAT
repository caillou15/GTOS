@echo off
Echo Initialisation du mode protege.
HXLDR32.EXE
echo Execution du kernel...
DPMILD32 NOYAU.EXE
