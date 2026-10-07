# INSTALL.ps1 -- provisions the Orchestrator export for the Architect skill.
#
# Run by the agent on the "Hello, Architect" greeting (see SKILL.md beside
# this script), or by hand. Idempotent: an existing install reports its
# revision and exits 0 without touching anything (`-Force` re-exports).
# The export carries no `.git` directory -- just working files. Idempotent,
# plain console output only, PowerShell 5.1 compatible.
param(
  [switch]$Force,
  [string]$TargetDir = ""
)

# NOTE: no $ErrorActionPreference = "Stop" here on purpose. Native stderr
# (git progress lines) becomes a terminating error under Stop and kills the
# installer on success output. Every native call below is judged by
# $LASTEXITCODE explicitly instead (same contract as run.ps1 stages).

$SkillDir = $PSScriptRoot
if ([string]::IsNullOrEmpty($TargetDir)) {
  if ($env:DREAM_ORCHESTRATOR -ne $null -and $env:DREAM_ORCHESTRATOR -ne "") {
    $TargetDir = $env:DREAM_ORCHESTRATOR
  } else {
    $TargetDir = Join-Path $SkillDir ".orchestrator"
  }
}

$Marker = Join-Path $TargetDir ".agents/skills/architect/SKILL.md"
$RevisionFile = Join-Path $TargetDir "REVISION"

function Get-UpstreamHead {
  $out = & git ls-remote https://github.com/bloomstick/dream-orchestrator.git HEAD 2>$null
  if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrEmpty($out)) {
    return ""
  }
  return ($out -split '\s+')[0]
}

if ((Test-Path $Marker) -and (-not $Force)) {
  $rev = ""
  if (Test-Path $RevisionFile) {
    $rev = ((Get-Content $RevisionFile -Raw -ErrorAction SilentlyContinue) | Out-String).Trim()
  }
  Write-Host "orchestrator present ($TargetDir revision ${rev}): nothing to do (use -Force to re-export)"
  exit 0
}

if ((Test-Path $TargetDir) -and $Force) {
  Remove-Item $TargetDir -Recurse -Force
}
$parent = Split-Path -Parent $TargetDir
if (!(Test-Path $parent)) {
  New-Item -ItemType Directory -Force -Path $parent | Out-Null
}
$tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("orchestrator-" + [System.Guid]::NewGuid().ToString("N"))
& git clone --depth 1 https://github.com/bloomstick/dream-orchestrator.git $tmp 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
  Write-Host "INSTALL FAILED: clone unreachable -- check network, then re-run" -ForegroundColor Red
  exit 2
}
Remove-Item (Join-Path $tmp ".git") -Recurse -Force
Move-Item $tmp $TargetDir
$head = Get-UpstreamHead
if ($head -ne "") {
  $head | Out-File -FilePath $RevisionFile -Encoding ascii
}
if (!(Test-Path $Marker)) {
  Write-Host "INSTALL FAILED: export lacks $Marker" -ForegroundColor Red
  exit 3
}
Write-Host "INSTALLED orchestrator revision $head -> $TargetDir"
exit 0
