#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }, PsDac, PsSqlTestServer

Describe New-Diagram {

    BeforeAll {
        [cultureinfo]::CurrentUICulture = 'en-US'
        Import-Module $PSScriptRoot\..\src\PsSqlDevTools.psd1 -Force -ErrorAction Stop -PassThru
    }

    It exists {
        Get-Command -Module PsSqlDevTools -Name New-SqlDevDiagram -ErrorAction Stop
    }

    Context Database {
        BeforeAll {
            $Instance = New-SqlTestInstance
            $InstanceConnection = $Instance | Connect-TSqlInstance
            $Database = New-SqlTestDatabase -Instance $Instance -InstanceConnection $InstanceConnection
            $DacService = $Database | Connect-DacService
            Import-DacPackage -Path $PSScriptRoot\sql-server-samples\samples\databases\wide-world-importers\wwi-ssdt\wwi-ssdt\bin\Debug\WideWorldImporters.dacpac |
            Install-DacPackage `
                -DatabaseName $Database.Name `
                -Service $DacService `
                -UpgradeExisting
        }

        AfterAll {
            $DacService | Disconnect-DacService
            $Database | Remove-SqlTestDatabase
            $InstanceConnection | Disconnect-TSqlInstance
            $Instance | Remove-SqlTestInstance
        }

        It works {

        }
    }
}