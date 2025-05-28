<#
.SYNOPSIS
    Creates predefined AD users for the osWDo.local domain based on a fixed list.

.NOTES
    Author : Dein Name
    Date   : 2025-05-28
#>

# ==== CONFIGURATION ====
$domain = "osWDo.local"
$baseDN = "OU=osWDo,DC=osWDo,DC=local"
$password = ConvertTo-SecureString "Start123!" -AsPlainText -Force

# ==== USER DEFINITION ====
$users = @(
    # GF
    @{ FirstName = "Lukas"; LastName = "Meyer"; Department = "GF" },

    # Sekretariat (8)
    @{ FirstName = "Anna"; LastName = "Keller"; Department = "Sekretariat" },
    @{ FirstName = "Mia"; LastName = "Huber"; Department = "Sekretariat" },
    @{ FirstName = "Noah"; LastName = "Müller"; Department = "Sekretariat" },
    @{ FirstName = "Lea"; LastName = "Schmid"; Department = "Sekretariat" },
    @{ FirstName = "Ben"; LastName = "Weber"; Department = "Sekretariat" },
    @{ FirstName = "Nina"; LastName = "Meier"; Department = "Sekretariat" },
    @{ FirstName = "Tom"; LastName = "Frei"; Department = "Sekretariat" },
    @{ FirstName = "Sara"; LastName = "Graf"; Department = "Sekretariat" },

    # Technik (12)
    @{ FirstName = "Max"; LastName = "Baumgartner"; Department = "Technik" },
    @{ FirstName = "Lukas"; LastName = "Keller"; Department = "Technik" },
    @{ FirstName = "Anna"; LastName = "Huber"; Department = "Technik" },
    @{ FirstName = "Mia"; LastName = "Müller"; Department = "Technik" },
    @{ FirstName = "Noah"; LastName = "Schmid"; Department = "Technik" },
    @{ FirstName = "Lea"; LastName = "Weber"; Department = "Technik" },
    @{ FirstName = "Ben"; LastName = "Meier"; Department = "Technik" },
    @{ FirstName = "Nina"; LastName = "Frei"; Department = "Technik" },
    @{ FirstName = "Tom"; LastName = "Graf"; Department = "Technik" },
    @{ FirstName = "Sara"; LastName = "Baumgartner"; Department = "Technik" },
    @{ FirstName = "Max"; LastName = "Meyer"; Department = "Technik" },
    @{ FirstName = "Lukas"; LastName = "Huber"; Department = "Technik" },

    # Entwicklung (19)
    @{ FirstName = "Anna"; LastName = "Müller"; Department = "Entwicklung" },
    @{ FirstName = "Mia"; LastName = "Schmid"; Department = "Entwicklung" },
    @{ FirstName = "Noah"; LastName = "Weber"; Department = "Entwicklung" },
    @{ FirstName = "Lea"; LastName = "Meier"; Department = "Entwicklung" },
    @{ FirstName = "Ben"; LastName = "Frei"; Department = "Entwicklung" },
    @{ FirstName = "Nina"; LastName = "Graf"; Department = "Entwicklung" },
    @{ FirstName = "Tom"; LastName = "Baumgartner"; Department = "Entwicklung" },
    @{ FirstName = "Sara"; LastName = "Meyer"; Department = "Entwicklung" },
    @{ FirstName = "Max"; LastName = "Keller"; Department = "Entwicklung" },
    @{ FirstName = "Lukas"; LastName = "Müller"; Department = "Entwicklung" },
    @{ FirstName = "Anna"; LastName = "Schmid"; Department = "Entwicklung" },
    @{ FirstName = "Mia"; LastName = "Weber"; Department = "Entwicklung" },
    @{ FirstName = "Noah"; LastName = "Meier"; Department = "Entwicklung" },
    @{ FirstName = "Lea"; LastName = "Frei"; Department = "Entwicklung" },
    @{ FirstName = "Ben"; LastName = "Graf"; Department = "Entwicklung" },
    @{ FirstName = "Nina"; LastName = "Baumgartner"; Department = "Entwicklung" },
    @{ FirstName = "Tom"; LastName = "Meyer"; Department = "Entwicklung" },
    @{ FirstName = "Sara"; LastName = "Keller"; Department = "Entwicklung" },
    @{ FirstName = "Max"; LastName = "Huber"; Department = "Entwicklung" },

    # Schulung (10)
    @{ FirstName = "Lukas"; LastName = "Schmid"; Department = "Schulung" },
    @{ FirstName = "Anna"; LastName = "Weber"; Department = "Schulung" },
    @{ FirstName = "Mia"; LastName = "Meier"; Department = "Schulung" },
    @{ FirstName = "Noah"; LastName = "Frei"; Department = "Schulung" },
    @{ FirstName = "Lea"; LastName = "Graf"; Department = "Schulung" },
    @{ FirstName = "Ben"; LastName = "Baumgartner"; Department = "Schulung" },
    @{ FirstName = "Nina"; LastName = "Keller"; Department = "Schulung" },
    @{ FirstName = "Tom"; LastName = "Huber"; Department = "Schulung" },
    @{ FirstName = "Sara"; LastName = "Schmid"; Department = "Schulung" },
    @{ FirstName = "Max"; LastName = "Weber"; Department = "Schulung" },

    # Kurse (5)
    @{ FirstName = "Lukas"; LastName = "Meier"; Department = "Kurse" },
    @{ FirstName = "Anna"; LastName = "Frei"; Department = "Kurse" },
    @{ FirstName = "Mia"; LastName = "Graf"; Department = "Kurse" },
    @{ FirstName = "Noah"; LastName = "Baumgartner"; Department = "Kurse" },
    @{ FirstName = "Lea"; LastName = "Keller"; Department = "Kurse" },

    # Produktion (25)
    @{ FirstName = "Ben"; LastName = "Huber"; Department = "Produktion" },
    @{ FirstName = "Nina"; LastName = "Schmid"; Department = "Produktion" },
    @{ FirstName = "Tom"; LastName = "Weber"; Department = "Produktion" },
    @{ FirstName = "Sara"; LastName = "Meier"; Department = "Produktion" },
    @{ FirstName = "Max"; LastName = "Frei"; Department = "Produktion" },
    @{ FirstName = "Lukas"; LastName = "Graf"; Department = "Produktion" },
    @{ FirstName = "Anna"; LastName = "Baumgartner"; Department = "Produktion" },
    @{ FirstName = "Mia"; LastName = "Keller"; Department = "Produktion" },
    @{ FirstName = "Noah"; LastName = "Huber"; Department = "Produktion" },
    @{ FirstName = "Lea"; LastName = "Schmid"; Department = "Produktion" },
    @{ FirstName = "Ben"; LastName = "Weber"; Department = "Produktion" },
    @{ FirstName = "Nina"; LastName = "Meier"; Department = "Produktion" },
    @{ FirstName = "Tom"; LastName = "Frei"; Department = "Produktion" },
    @{ FirstName = "Sara"; LastName = "Graf"; Department = "Produktion" },
    @{ FirstName = "Max"; LastName = "Baumgartner"; Department = "Produktion" },
    @{ FirstName = "Lukas"; LastName = "Keller"; Department = "Produktion" },
    @{ FirstName = "Anna"; LastName = "Huber"; Department = "Produktion" },
    @{ FirstName = "Mia"; LastName = "Müller"; Department = "Produktion" },
    @{ FirstName = "Noah"; LastName = "Schmid"; Department = "Produktion" },
    @{ FirstName = "Lea"; LastName = "Weber"; Department = "Produktion" },
    @{ FirstName = "Ben"; LastName = "Meier"; Department = "Produktion" },
    @{ FirstName = "Nina"; LastName = "Frei"; Department = "Produktion" },
    @{ FirstName = "Tom"; LastName = "Graf"; Department = "Produktion" },
    @{ FirstName = "Sara"; LastName = "Baumgartner"; Department = "Produktion" },
    @{ FirstName = "Max"; LastName = "Meyer"; Department = "Produktion" }
)

# ==== CREATE USERS ====
foreach ($user in $users) {
    $username = ("{0}.{1}" -f $user.FirstName, $user.LastName).ToLower()
    $ouPath = "OU=$($user.Department),OU=Users,$baseDN"

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

        Write-Host "Created user: $username in $($user.Department)"
    }
    catch {
        Write-Host "Error creating $username: $($_.Exception.Message)" -ForegroundColor Red
    }
}
