<#
.SYNOPSIS
    Erstellt Fileshares mit NTFS-Berechtigungen via icacls und SMB-Freigaben (mit korrektem Format).
.NOTES
    Autor: Silvan Oehri
    Datum: 2025-05-29
#>

$basePath = "E:\Daten\Administration"
$domain = "osWDo"

# Verzeichnis erstellen falls nicht vorhanden
if (-not (Test-Path $basePath)) {
    New-Item -Path $basePath -ItemType Directory -Force | Out-Null
    Write-Host "✔ Basisverzeichnis erstellt: $basePath"
} else {
    Write-Host "⚠️ Basisverzeichnis existiert bereits: $basePath" -ForegroundColor Yellow
}

Import-Module SmbShare -ErrorAction SilentlyContinue

$departments = @("GF", "GL", "Sekretariat", "Technik", "Entwicklung", "Schulung", "Kurse")

foreach ($dept in $departments) {
    $folder = Join-Path $basePath $dept
    if (-not (Test-Path $folder)) {
        New-Item -Path $folder -ItemType Directory | Out-Null
        Write-Host "✔ Ordner erstellt: $folder"
    } else {
        Write-Host "⚠️ Ordner existiert bereits: $folder" -ForegroundColor Yellow
    }

    $groups = @("DL_${dept}_RW", "DL_GF_RW", "DL_GL_RW") | ForEach-Object { "$domain\$_" }

    foreach ($group in $groups) {
        $grant = "$group:(OI)(CI)F"
        $result = icacls $folder /grant:r $grant 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✔ Berechtigung gesetzt für $group auf $folder"
        } else {
            Write-Host "❌ Fehler beim Setzen der Berechtigung für $group $result" -ForegroundColor Red
        }
    }

    $shareName = $dept

# Alte Freigabe ggf. entfernen
$existingShare = Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue
if ($existingShare) {
    try {
        Remove-SmbShare -Name $shareName -Force -Confirm:$false
        Write-Host "🗑 Alte Freigabe gelöscht: $shareName"
    } catch {
        Write-Host "❌ Fehler beim Entfernen alter Freigabe $shareName $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Neue Freigabe anlegen
try {
    New-SmbShare -Name $shareName -Path $folder -FullAccess $groups -ErrorAction Stop
    Write-Host "✔ Freigabe erstellt: $shareName → $folder"
} catch {
    Write-Host "❌ Fehler beim Erstellen der Freigabe $shareName $($_.Exception.Message)" -ForegroundColor Red
}

}