$ModuleRoot = ($env:PSModulePath -split ';' | Where-Object { $_ -like "$HOME*" } | Select-Object -First 1)

New-Item -ItemType Directory -Force -Path $ModuleRoot | Out-Null

git clone https://github.com/catppuccin/powershell.git "$ModuleRoot\Catppuccin"

Import-Module Catppuccin



New-Item -Path $PROFILE.CurrentUserAllHosts -ItemType File -Force
notepad $PROFILE.CurrentUserAllHosts


Add this to the opened profile file:


# Catppuccin PowerShell theme
if (Get-Module -ListAvailable Catppuccin) {
    Import-Module Catppuccin -ErrorAction Stop

    # Pick flavor: Latte, Frappe, Macchiato, Mocha
    $global:Flavor = $Catppuccin['Mocha']

    function global:prompt {
        $reset = "$([char]27)[0m"

        $debug = if (Test-Path variable:/PSDebugContext) {
            "$($global:Flavor.Red.Foreground())[DBG]: "
        } else {
            ""
        }

        "$debug$($global:Flavor.Teal.Foreground())PS $($global:Flavor.Yellow.Foreground())$(Get-Location)$($global:Flavor.Green.Foreground())> $reset"
    }
} else {
    Write-Warning "Catppuccin module not found. Check that it is installed in a PSModulePath folder."
}



. $PROFILE.CurrentUserAllHosts