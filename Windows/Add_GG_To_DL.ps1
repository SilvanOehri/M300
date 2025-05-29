<#
.SYNOPSIS
    Verschachtelt globale Gruppen in ihre zugehörigen DL-Gruppen (z. B. GG_Technik → DL_Technik_RW)
.NOTES
    Autor: Silvan Oehri
    Datum: 2025-05-29
#>

Import-Module ActiveDirectory

# GG_GF → DL_GF_RW
Try {
    Add-ADGroupMember -Identity "DL_GF_RW" -Members "GG_GF" -ErrorAction Stop
    Write-Host "✔ Zugewiesen: GG_GF → DL_GF_RW"
} Catch {
    Write-Host "⚠️ Fehler bei Zuweisung: GG_GF → DL_GF_RW: $($_.Exception.Message)" -ForegroundColor Yellow
}

# GG_Sekretariat → DL_Sekretariat_RW
Try {
    Add-ADGroupMember -Identity "DL_Sekretariat_RW" -Members "GG_Sekretariat" -ErrorAction Stop
    Write-Host "✔ Zugewiesen: GG_Sekretariat → DL_Sekretariat_RW"
} Catch {
    Write-Host "⚠️ Fehler bei Zuweisung: GG_Sekretariat → DL_Sekretariat_RW: $($_.Exception.Message)" -ForegroundColor Yellow
}

# GG_Technik → DL_Technik_RW
Try {
    Add-ADGroupMember -Identity "DL_Technik_RW" -Members "GG_Technik" -ErrorAction Stop
    Write-Host "✔ Zugewiesen: GG_Technik → DL_Technik_RW"
} Catch {
    Write-Host "⚠️ Fehler bei Zuweisung: GG_Technik → DL_Technik_RW: $($_.Exception.Message)" -ForegroundColor Yellow
}

# GG_Entwicklung → DL_Entwicklung_RW
Try {
    Add-ADGroupMember -Identity "DL_Entwicklung_RW" -Members "GG_Entwicklung" -ErrorAction Stop
    Write-Host "✔ Zugewiesen: GG_Entwicklung → DL_Entwicklung_RW"
} Catch {
    Write-Host "⚠️ Fehler bei Zuweisung: GG_Entwicklung → DL_Entwicklung_RW: $($_.Exception.Message)" -ForegroundColor Yellow
}

# GG_Schulung → DL_Schulung_RW
Try {
    Add-ADGroupMember -Identity "DL_Schulung_RW" -Members "GG_Schulung" -ErrorAction Stop
    Write-Host "✔ Zugewiesen: GG_Schulung → DL_Schulung_RW"
} Catch {
    Write-Host "⚠️ Fehler bei Zuweisung: GG_Schulung → DL_Schulung_RW: $($_.Exception.Message)" -ForegroundColor Yellow
}

# GG_Kurse → DL_Kurse_RW
Try {
    Add-ADGroupMember -Identity "DL_Kurse_RW" -Members "GG_Kurse" -ErrorAction Stop
    Write-Host "✔ Zugewiesen: GG_Kurse → DL_Kurse_RW"
} Catch {
    Write-Host "⚠️ Fehler bei Zuweisung: GG_Kurse → DL_Kurse_RW: $($_.Exception.Message)" -ForegroundColor Yellow
}

# GG_Produktion → DL_Produktion_RW
Try {
    Add-ADGroupMember -Identity "DL_Produktion_RW" -Members "GG_Produktion" -ErrorAction Stop
    Write-Host "✔ Zugewiesen: GG_Produktion → DL_Produktion_RW"
} Catch {
    Write-Host "⚠️ Fehler bei Zuweisung: GG_Produktion → DL_Produktion_RW: $($_.Exception.Message)" -ForegroundColor Yellow
}
