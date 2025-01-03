# OS information - Informácie o operačnom systéme
$osInfo = Get-CimInstance Win32_OperatingSystem
Write-Host "Operačný systém: $($osInfo.Caption)"
Write-Host "Verzia: $($osInfo.Version)"
Write-Host "Architektúra: $($osInfo.OSArchitecture)"
Write-Host "Výrobca: $($osInfo.Manufacturer)"
Write-Host "Inštalovaný dátum: $($osInfo.InstallDate)"
Write-Host "Systémový čas: $($osInfo.CurrentTimeZone)"
Write-Host "Počet používateľských účtov: $($osInfo.NumberOfUsers)"

# CPU information - Informácie o procesore
$cpuInfo = Get-CimInstance Win32_Processor
Write-Host "`nProcesor:"
foreach ($cpu in $cpuInfo) {
    Write-Host "Názov: $($cpu.Name)"
    Write-Host "Počet jadier: $($cpu.NumberOfCores)"
    Write-Host "Počet logických procesorov: $($cpu.NumberOfLogicalProcessors)"
    Write-Host "Maximálna frekvencia: $($cpu.MaxClockSpeed) MHz"
    Write-Host "Výrobca: $($cpu.Manufacturer)"
    Write-Host "ID: $($cpu.DeviceID)"
}

# RAM information - Informácie o pamäti
$memoryInfo = Get-CimInstance Win32_PhysicalMemory
$totalMemory = [math]::round(($memoryInfo | Measure-Object -Property Capacity -Sum).Sum / 1GB, 2)
Write-Host "`nCelková pamäť (RAM): $totalMemory GB"
foreach ($mem in $memoryInfo) {
    Write-Host "Výrobca: $($mem.Manufacturer), Kapacita: $([math]::round($mem.Capacity / 1GB, 2)) GB, Rýchlosť: $($mem.Speed) MHz"
}

# HDDs information - Informácie o diskoch
$diskInfo = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"
Write-Host "`nDiskové jednotky:"
foreach ($disk in $diskInfo) {
    $freeSpace = [math]::round($disk.FreeSpace / 1GB, 2)
    $totalSpace = [math]::round($disk.Size / 1GB, 2)
    Write-Host "$($disk.DeviceID): $freeSpace GB voľného miesta z $totalSpace GB"
    Write-Host "Typ: $($disk.FileSystem), Stav: $($disk.VolumeName)"
}

# Installed progs - Informácie o nainštalovaných programoch
$installedPrograms = Get-CimInstance Win32_Product
Write-Host "`nNainštalované programy:"
foreach ($program in $installedPrograms) {
    Write-Host "$($program.Name) - Verzia: $($program.Version) - Výrobca: $($program.Vendor)"
}

# GPU information - Informácie o grafickej karte
$gpuInfo = Get-CimInstance Win32_VideoController
Write-Host "`nGrafická karta:"
foreach ($gpu in $gpuInfo) {
    Write-Host "Názov: $($gpu.Name)"
    Write-Host "Pamäť: $([math]::round($gpu.AdapterRAM / 1MB, 2)) MB"
    Write-Host "Výrobca: $($gpu.Manufacturer)"
    Write-Host "ID: $($gpu.DeviceID)"
    Write-Host "Verzia ovládača: $($gpu.DriverVersion)"
}

# Network adapter information - Informácie o sieťových adaptérov
$networkAdapters = Get-CimInstance Win32_NetworkAdapter | Where-Object { $_.PhysicalAdapter -eq $true }
Write-Host "`nSieťové adaptéry:"
foreach ($adapter in $networkAdapters) {
    Write-Host "Názov: $($adapter.Name)"
    Write-Host "Výrobca: $($adapter.Manufacturer)"
    Write-Host "Rýchlosť: $($adapter.Speed / 1MB) Mbps"
    Write-Host "Stav: $($adapter.NetConnectionStatus)"
}

# MB information - Informácie o základnej doske
$motherboardInfo = Get-CimInstance Win32_BaseBoard
Write-Host "`nZákladná doska:"
Write-Host "Názov: $($motherboardInfo.Product)"
Write-Host "Výrobca: $($motherboardInfo.Manufacturer)"
Write-Host "Verzia: $($motherboardInfo.Version)"
Write-Host "ID: $($motherboardInfo.SerialNumber)"
