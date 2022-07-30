#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe ModuleManifest {
    It isValid {
        $Manifest = Test-ModuleManifest -Path "$PSScriptRoot\..\src\PsSqlDevTools.psd1" -ErrorAction Stop
        $Manifest.RootModule | Should -Not -BeNullOrEmpty
        $Manifest.Prefix | Should -Be 'SqlDev'
        $Manifest | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
    }
}