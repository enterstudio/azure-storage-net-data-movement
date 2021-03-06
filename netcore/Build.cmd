echo off

set BuildMode=Debug
if not {%1} == {} (
    set BuildMode=%1
)

set OriginalPath=%cd%
set TestPath=%~dp0..\test
"%ProgramFiles(x86)%\MSBuild\14.0\Bin\msbuild" %TestPath%\DMLibTest\DMLibTest.csproj /t:Rebuild /p:Configuration=%BuildMode%  >NUL
"%ProgramFiles(x86)%\MSBuild\14.0\Bin\msbuild" %TestPath%\DMLibTestCodeGen\DMLibTestCodeGen.csproj /t:Rebuild /p:Configuration=%BuildMode% >NUL
%TestPath%\DMLibTestCodeGen\bin\Debug\DMLibTestCodeGen.exe %TestPath%\DMLibTest\bin\Debug\DMLibTest.dll %TestPath%\DMLibTest\Generated DNetCore

cd %~dp0
dotnet restore -s https://www.nuget.org/api/v2/
cd %~dp0\Microsoft.WindowsAzure.Storage.DataMovement
dotnet build -c %BuildMode%
cd %~dp0\MsTestLib
dotnet build -c %BuildMode%
cd %~dp0\DMTestLib
dotnet build -c %BuildMode%
cd %~dp0\DMLibTest
dotnet build -c %BuildMode%
cd %OriginalPath%
