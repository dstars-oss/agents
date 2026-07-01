param(
    [string]$CodexHome = (Join-Path $HOME ".codex")
)

$ErrorActionPreference = "Stop"

function Get-FullDirectoryPath {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath($Path)
    if (-not $fullPath.EndsWith([System.IO.Path]::DirectorySeparatorChar)) {
        $fullPath += [System.IO.Path]::DirectorySeparatorChar
    }

    return $fullPath
}

function Test-IsSameOrChildPath {
    param(
        [string]$Path,
        [string]$Parent
    )

    $normalizedPath = Get-FullDirectoryPath $Path
    $normalizedParent = Get-FullDirectoryPath $Parent

    return $normalizedPath.Equals($normalizedParent, [System.StringComparison]::OrdinalIgnoreCase) -or
        $normalizedPath.StartsWith($normalizedParent, [System.StringComparison]::OrdinalIgnoreCase)
}

$SourceRoot = Join-Path $PSScriptRoot "codex"
if (-not (Test-Path -LiteralPath $SourceRoot -PathType Container)) {
    throw "Source directory not found: $SourceRoot"
}

$ResolvedSourceRoot = (Resolve-Path -LiteralPath $SourceRoot).ProviderPath
$ResolvedScriptRoot = (Resolve-Path -LiteralPath $PSScriptRoot).ProviderPath
New-Item -ItemType Directory -Force -Path $CodexHome | Out-Null
$ResolvedCodexHome = (Resolve-Path -LiteralPath $CodexHome).ProviderPath

if (Test-IsSameOrChildPath $ResolvedCodexHome $ResolvedSourceRoot) {
    throw "CodexHome must not be the source directory or inside it: $ResolvedCodexHome"
}
if ((Test-IsSameOrChildPath $ResolvedCodexHome $ResolvedScriptRoot) -or
    (Test-IsSameOrChildPath $ResolvedScriptRoot $ResolvedCodexHome)) {
    throw "CodexHome must not overlap this repository: $ResolvedCodexHome"
}

$RootFiles = @(
    "AGENTS.md",
    "AGENTS.zh-CN.md"
)

foreach ($file in $RootFiles) {
    $source = Join-Path $SourceRoot $file
    if (Test-Path -LiteralPath $source -PathType Leaf) {
        Copy-Item -LiteralPath $source -Destination (Join-Path $ResolvedCodexHome $file) -Force
    }
}

$SourceAgents = Join-Path $SourceRoot "agents"
$TargetAgents = Join-Path $ResolvedCodexHome "agents"
if (Test-Path -LiteralPath $SourceAgents -PathType Container) {
    $ResolvedTargetAgents = [System.IO.Path]::GetFullPath($TargetAgents)
    if ((Test-IsSameOrChildPath $ResolvedTargetAgents $ResolvedScriptRoot) -or
        (Test-IsSameOrChildPath $ResolvedScriptRoot $ResolvedTargetAgents)) {
        throw "Target agents directory must not overlap this repository: $ResolvedTargetAgents"
    }

    New-Item -ItemType Directory -Force -Path $TargetAgents | Out-Null
    Get-ChildItem -LiteralPath $SourceAgents -Force | ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $TargetAgents -Recurse -Force
    }
}

Write-Host "Installed Codex configuration from $SourceRoot to $CodexHome"
