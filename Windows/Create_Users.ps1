<#
.SYNOPSIS
    Erstellt eindeutige AD-Benutzer für osWDo.local. Existierende Benutzer werden vorher gelöscht.

.NOTES
    Autor : Silvan Oehri
    Datum : 2025-05-29
#>

$domain   = "osWDo.local"
$baseDN   = "OU=osWDo,DC=osWDo,DC=local"
$password = ConvertTo-SecureString "Start123!" -AsPlainText -Force

$users = @(
    @{"FirstName" = "Lisa"; "LastName" = "Roth"; "Department" = "GF"},
    @{"FirstName" = "Nina"; "LastName" = "Maurer"; "Department" = "Sekretariat"},
    @{"FirstName" = "Moritz"; "LastName" = "Zimmermann"; "Department" = "Sekretariat"},
    @{"FirstName" = "Nina"; "LastName" = "Roth"; "Department" = "Sekretariat"},
    @{"FirstName" = "Felix"; "LastName" = "Gerber"; "Department" = "Sekretariat"},
    @{"FirstName" = "Clara"; "LastName" = "Graf"; "Department" = "Sekretariat"},
    @{"FirstName" = "Timo"; "LastName" = "Hofer"; "Department" = "Sekretariat"},
    @{"FirstName" = "David"; "LastName" = "Haas"; "Department" = "Sekretariat"},
    @{"FirstName" = "Timo"; "LastName" = "Huber"; "Department" = "Sekretariat"},
    @{"FirstName" = "Jonas"; "LastName" = "Keller"; "Department" = "Technik"},
    @{"FirstName" = "Marie"; "LastName" = "Graf"; "Department" = "Technik"},
    @{"FirstName" = "Paul"; "LastName" = "Weber"; "Department" = "Technik"},
    @{"FirstName" = "Sara"; "LastName" = "Peter"; "Department" = "Technik"},
    @{"FirstName" = "Paul"; "LastName" = "Schuster"; "Department" = "Technik"},
    @{"FirstName" = "Laura"; "LastName" = "Meyer"; "Department" = "Technik"},
    @{"FirstName" = "Lena"; "LastName" = "Schneider"; "Department" = "Technik"},
    @{"FirstName" = "Anna"; "LastName" = "Vogel"; "Department" = "Technik"},
    @{"FirstName" = "Felix"; "LastName" = "Hofer"; "Department" = "Technik"},
    @{"FirstName" = "Max"; "LastName" = "Haas"; "Department" = "Technik"},
    @{"FirstName" = "Jana"; "LastName" = "Huber"; "Department" = "Technik"},
    @{"FirstName" = "Tom"; "LastName" = "Mueller"; "Department" = "Technik"},
    @{"FirstName" = "Mia"; "LastName" = "Beck"; "Department" = "Entwicklung"},
    @{"FirstName" = "Erik"; "LastName" = "Bader"; "Department" = "Entwicklung"},
    @{"FirstName" = "Laura"; "LastName" = "Bader"; "Department" = "Entwicklung"},
    @{"FirstName" = "Lukas"; "LastName" = "Schuster"; "Department" = "Entwicklung"},
    @{"FirstName" = "Emma"; "LastName" = "Kuhn"; "Department" = "Entwicklung"},
    @{"FirstName" = "Marie"; "LastName" = "Frei"; "Department" = "Entwicklung"},
    @{"FirstName" = "Johanna"; "LastName" = "Huber"; "Department" = "Entwicklung"},
    @{"FirstName" = "Jana"; "LastName" = "Zimmermann"; "Department" = "Entwicklung"},
    @{"FirstName" = "Timo"; "LastName" = "Suter"; "Department" = "Entwicklung"},
    @{"FirstName" = "Tim"; "LastName" = "Kuhn"; "Department" = "Entwicklung"},
    @{"FirstName" = "Moritz"; "LastName" = "Hofer"; "Department" = "Entwicklung"},
    @{"FirstName" = "Nina"; "LastName" = "Suter"; "Department" = "Entwicklung"},
    @{"FirstName" = "Marie"; "LastName" = "Mueller"; "Department" = "Entwicklung"},
    @{"FirstName" = "Paul"; "LastName" = "Roth"; "Department" = "Entwicklung"},
    @{"FirstName" = "Lukas"; "LastName" = "Arnold"; "Department" = "Entwicklung"},
    @{"FirstName" = "Emma"; "LastName" = "Schmid"; "Department" = "Entwicklung"},
    @{"FirstName" = "Nina"; "LastName" = "Graf"; "Department" = "Entwicklung"},
    @{"FirstName" = "Tom"; "LastName" = "Schmid"; "Department" = "Entwicklung"},
    @{"FirstName" = "Anna"; "LastName" = "Suter"; "Department" = "Entwicklung"},
    @{"FirstName" = "Mia"; "LastName" = "Schmid"; "Department" = "Schulung"},
    @{"FirstName" = "David"; "LastName" = "Wagner"; "Department" = "Schulung"},
    @{"FirstName" = "Emma"; "LastName" = "Wirth"; "Department" = "Schulung"},
    @{"FirstName" = "Jan"; "LastName" = "Vogel"; "Department" = "Schulung"},
    @{"FirstName" = "Marie"; "LastName" = "Meyer"; "Department" = "Schulung"},
    @{"FirstName" = "Tom"; "LastName" = "Wagner"; "Department" = "Schulung"},
    @{"FirstName" = "Emma"; "LastName" = "Vogel"; "Department" = "Schulung"},
    @{"FirstName" = "Jonas"; "LastName" = "Zimmermann"; "Department" = "Schulung"},
    @{"FirstName" = "Erik"; "LastName" = "Beck"; "Department" = "Schulung"},
    @{"FirstName" = "Paul"; "LastName" = "Hofer"; "Department" = "Schulung"},
    @{"FirstName" = "Paul"; "LastName" = "Baumgartner"; "Department" = "Kurse"},
    @{"FirstName" = "Simon"; "LastName" = "Arnold"; "Department" = "Kurse"},
    @{"FirstName" = "Tim"; "LastName" = "Baumgartner"; "Department" = "Kurse"},
    @{"FirstName" = "Lea"; "LastName" = "Brunner"; "Department" = "Kurse"},
    @{"FirstName" = "Erik"; "LastName" = "Zimmermann"; "Department" = "Kurse"},
    @{"FirstName" = "Max"; "LastName" = "Vogel"; "Department" = "Produktion"},
    @{"FirstName" = "Paul"; "LastName" = "Zimmermann"; "Department" = "Produktion"},
    @{"FirstName" = "Simon"; "LastName" = "Meier"; "Department" = "Produktion"},
    @{"FirstName" = "Johanna"; "LastName" = "Beck"; "Department" = "Produktion"},
    @{"FirstName" = "Emma"; "LastName" = "Ziegler"; "Department" = "Produktion"},
    @{"FirstName" = "Laura"; "LastName" = "Huber"; "Department" = "Produktion"},
    @{"FirstName" = "Noah"; "LastName" = "Vogel"; "Department" = "Produktion"},
    @{"FirstName" = "Mia"; "LastName" = "Graf"; "Department" = "Produktion"},
    @{"FirstName" = "Clara"; "LastName" = "Maurer"; "Department" = "Produktion"},
    @{"FirstName" = "Lukas"; "LastName" = "Keller"; "Department" = "Produktion"},
    @{"FirstName" = "Felix"; "LastName" = "Brunner"; "Department" = "Produktion"},
    @{"FirstName" = "Tom"; "LastName" = "Roth"; "Department" = "Produktion"},
    @{"FirstName" = "Lena"; "LastName" = "Haas"; "Department" = "Produktion"},
    @{"FirstName" = "Laura"; "LastName" = "Hofer"; "Department" = "Produktion"},
    @{"FirstName" = "Tom"; "LastName" = "Hofer"; "Department" = "Produktion"},
    @{"FirstName" = "Sara"; "LastName" = "Frei"; "Department" = "Produktion"},
    @{"FirstName" = "Timo"; "LastName" = "Vogel"; "Department" = "Produktion"},
    @{"FirstName" = "Clara"; "LastName" = "Schneider"; "Department" = "Produktion"},
    @{"FirstName" = "Tim"; "LastName" = "Haas"; "Department" = "Produktion"},
    @{"FirstName" = "Clara"; "LastName" = "Baumgartner"; "Department" = "Produktion"},
    @{"FirstName" = "Paul"; "LastName" = "Wirth"; "Department" = "Produktion"},
    @{"FirstName" = "Ben"; "LastName" = "Graf"; "Department" = "Produktion"},
    @{"FirstName" = "Anna"; "LastName" = "Zimmermann"; "Department" = "Produktion"},
    @{"FirstName" = "Johanna"; "LastName" = "Frei"; "Department" = "Produktion"},
    @{"FirstName" = "Anna"; "LastName" = "Arnold"; "Department" = "Produktion"}
)

foreach ($user in $users) {
    $username = ("{0}.{1}" -f $user.FirstName, $user.LastName).ToLower()
    $ouPath   = "OU=$($user.Department),OU=Users,$baseDN"

    $existing = Get-ADUser -Filter { SamAccountName -eq $username } -ErrorAction SilentlyContinue
    if ($existing) {
        try {
            Remove-ADUser -Identity $existing -Confirm:$false
            Write-Host "❌ Alter Benutzer gelöscht: $username"
        } catch {
            Write-Host "⚠️ Fehler beim Löschen von $username: $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }

    try {
        New-ADUser `
            -Name "$($user.FirstName) $($user.LastName)" `
            -GivenName $user.FirstName `
            -Surname $user.LastName `
            -SamAccountName $username `
            -UserPrincipalName "$username@$domain" `
            -DisplayName "$($user.FirstName) $($user.LastName)" `
            -Path $ouPath `
            -AccountPassword $password `
            -Enabled $true `
            -ChangePasswordAtLogon $false
        Write-Host "✔ Benutzer erstellt: $username in $($user.Department)"
    } catch {
        Write-Host "❌ Fehler bei $username: $($_.Exception.Message)" -ForegroundColor Red
    }
}