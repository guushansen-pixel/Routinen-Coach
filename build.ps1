<#
.SYNOPSIS
    Baut den RoutinenCoach ueber apk-builder.
.DESCRIPTION
    Die App braucht keine native Bruecke: kein Dateizugriff, keine Sensoren,
    keine Zwischenablage. Der Wrapper erzeugt das Projekt nur mit den
    richtigen Schaltern (Hochformat, Display bleibt beim Spielen an) und legt
    die signierte APK als dist\routinencoach-<Version>.apk ab (aeltere dist-APKs
    werden entfernt). Kommt spaeter doch eine Bruecke dazu, das Muster aus
    reha-coach\build.ps1 uebernehmen.
.EXAMPLE
    .\build.ps1 -VersionName 1.1 -VersionCode 2 -Release
#>
[CmdletBinding()]
param(
    [string]$VersionName = '1.0',
    [int]$VersionCode = 1,
    [switch]$Release,
    [switch]$Install
)

$ErrorActionPreference = 'Stop'

$ProjectRoot = $PSScriptRoot
$ApkBuilder  = "D:\claude code projects\apk-builder"
$PackageId   = "com.daniel.routinencoach"
$AppName     = "RoutinenCoach"

& "$ApkBuilder\new-app.ps1" -Name $AppName -PackageId $PackageId `
    -WebRoot (Join-Path $ProjectRoot 'web') `
    -Icon (Join-Path $ProjectRoot 'icon.xml') `
    -IconBackground "#12171E" -Portrait -KeepScreenOn `
    -VersionName $VersionName -VersionCode $VersionCode -Force

$buildArgs = @{ App = $AppName }
if ($Release) { $buildArgs.Release = $true }
if ($Install) { $buildArgs.Install = $true }
& "$ApkBuilder\build-apk.ps1" @buildArgs

if ($Release) {
    $latest = Get-ChildItem (Join-Path $ApkBuilder 'out') -Filter "$AppName-release-*.apk" |
        Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $latest) { throw "Keine Release-APK in apk-builder\out gefunden" }
    $dist = Join-Path $ProjectRoot 'dist'
    if (-not (Test-Path $dist)) { New-Item -ItemType Directory -Path $dist | Out-Null }
    Get-ChildItem $dist -Filter 'routinencoach-*.apk' | Remove-Item -Force
    $target = Join-Path $dist "routinencoach-$VersionName.apk"
    Copy-Item $latest.FullName $target -Force
    Write-Host "  [ok] $target" -ForegroundColor Green
}
