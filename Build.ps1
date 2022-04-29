dotnet build

$dir = Split-Path -Path (Get-Location) -Leaf
# Edit $NeosDir to be the path to the neos directory on your own system
$NeosDir = "D:\Games\Neos\app\"
$NeosExe = "$NeosDir\Neos.exe"
$AssemblyLocation = "$(Get-Location)\bin\Debug\$dir.dll"
$nml_mods = "$NeosDir\nml_mods\"

Copy-Item -Force -Path $AssemblyLocation -Destination $nml_mods

$LogJob = Start-Job {Start-Sleep -Seconds 8
    Get-Content "D:\Games\Neos\app\Logs\$(Get-ChildItem -Path D:\Games\Neos\app\Logs | Sort-Object LastWriteTime | Select-Object -last 1)" -Wait
}

$NeosProc = Start-Process -FilePath $NeosExe -WorkingDirectory $NeosDir -ArgumentList "-DontAutoOpenCloudHome", "-SkipIntroTutorial", "-Screen", "-LoadAssembly `"D:\Games\Neos\app\Libraries\NeosModLoader.dll`"" -passthru

while(!$NeosProc.HasExited) {
    Start-Sleep -Seconds 1
    Receive-Job $LogJob.Id
}

Stop-Job $LogJob.Id