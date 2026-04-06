@echo off
echo Creating deployment zip files...

REM Remove old zip files if they exist
if exist server.zip del server.zip
if exist dist.zip del dist.zip

REM Zip server folder excluding node_modules
echo Zipping server folder (excluding node_modules)...
powershell -Command "Get-ChildItem -Path 'server' -Recurse | Where-Object { $_.FullName -notmatch '\\node_modules\\' -and $_.FullName -notmatch '\\node_modules$' } | Compress-Archive -DestinationPath 'server.zip' -Force"

REM Zip dist folder from client
echo Zipping client/dist folder...
powershell -Command "Compress-Archive -Path 'client\dist\*' -DestinationPath 'dist.zip' -Force"

echo.
echo Done! Created:
echo   server.zip (excluding node_modules)
echo   dist.zip
pause
