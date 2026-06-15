param(
    [string]$ClaudeHome = (Join-Path $HOME ".claude")
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

$SourceRoot = Join-Path $PSScriptRoot "claude"
if (-not (Test-Path -LiteralPath $SourceRoot -PathType Container)) {
    throw "Source directory not found: $SourceRoot"
}

$ResolvedSourceRoot = (Resolve-Path -LiteralPath $SourceRoot).ProviderPath
$ResolvedScriptRoot = (Resolve-Path -LiteralPath $PSScriptRoot).ProviderPath
New-Item -ItemType Directory -Force -Path $ClaudeHome | Out-Null
$ResolvedClaudeHome = (Resolve-Path -LiteralPath $ClaudeHome).ProviderPath

if (Test-IsSameOrChildPath $ResolvedClaudeHome $ResolvedSourceRoot) {
    throw "ClaudeHome must not be the source directory or inside it: $ResolvedClaudeHome"
}
if ((Test-IsSameOrChildPath $ResolvedClaudeHome $ResolvedScriptRoot) -or
    (Test-IsSameOrChildPath $ResolvedScriptRoot $ResolvedClaudeHome)) {
    throw "ClaudeHome must not overlap this repository: $ResolvedClaudeHome"
}

$RootFiles = @(
    "CLAUDE.md",
    "CLAUDE.zh-CN.md"
)

foreach ($file in $RootFiles) {
    $source = Join-Path $SourceRoot $file
    if (Test-Path -LiteralPath $source -PathType Leaf) {
        Copy-Item -LiteralPath $source -Destination (Join-Path $ClaudeHome $file) -Force
    }
}

Write-Host "Installed Claude configuration from $SourceRoot to $ClaudeHome"
