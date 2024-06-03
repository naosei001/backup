@echo off
setlocal

REM Define os caminhos das pastas A e B
set "source=A:\"
set "destination=B:\"

REM Define o arquivo de log para registro do backup
set "logfile=backup_log.txt"

REM Define o arquivo de log temporário para registrar arquivos copiados
set "tempfile=temp_backup_log.txt"

REM Verifica se a pasta de destino existe, se não, cria a pasta
if not exist "%destination%" (
    mkdir "%destination%"
)

REM Copia novos arquivos e arquivos modificados da pasta A para a pasta B
robocopy "%source%" "%destination%" /MIR /FFT /Z /XA:H /W:5 /R:3 /LOG+:"%tempfile%" /NP /NDL /NFL

REM Adiciona a data e hora do backup ao arquivo de log
echo Backup realizado em: %date% %time% >> "%logfile%"

REM Adiciona os arquivos copiados ao arquivo de log
type "%tempfile%" >> "%logfile%"

REM Remove o arquivo de log temporário
del "%tempfile%"

echo Backup incremental concluído com sucesso.
endlocal
