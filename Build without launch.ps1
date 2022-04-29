dotnet build

$dir = Split-Path -Path (Get-Location) -Leaf
# Edit $NeosDir to be the path to the neos directory on your own system
$NeosDir = "D:\Games\Neos\app\"
$NeosExe = "$NeosDir\Neos.exe"
$AssemblyLocation = "$(Get-Location)\bin\Debug\$dir.dll"
$nml_mods = "$NeosDir\nml_mods\"

Copy-Item -Force -Path $AssemblyLocation -Destination $nml_mods
