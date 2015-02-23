@echo off
Echo Execution du script normal
%LECTEUR%cpcdos\pilotes\reseau\script2.bat
exit

:copie
SET LectV=%1
md %LectV%\cpcdos
md %LectV%\cpcdos\pilotes
md %LectV%\cpcdos\pilotes\reseau
Echo Copie des fichiers sur le lecteur %lectV% en cours ...
xcopy /s /y %LECTEUR%cpcdos\pilotes\reseau %LectV%\cpcdos\pilotes\reseau
Echo Execution virtuel du script
%LectV%\cpcdos\pilotes\reseau\script2.bat
