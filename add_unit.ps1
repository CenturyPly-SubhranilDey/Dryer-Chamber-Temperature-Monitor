param (
    [Parameter(Mandatory=$true)]
    [int]$UnitNumber,

    [Parameter(Mandatory=$true)]
    [string]$GasUrl
)

$scriptDir = $PSScriptRoot
if (-not $scriptDir) { $scriptDir = (Get-Location).Path }

$targetDir = Join-Path $scriptDir "unit$UnitNumber"
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

$templatePath = Join-Path $scriptDir "unit1\index.html"
if (-not (Test-Path $templatePath)) {
    Write-Error "Template $templatePath not found!"
    exit 1
}

$content = Get-Content -Raw $templatePath -Encoding utf8

# Replace the DEFAULT_GAS_URL with the new unit's GAS URL
$regex = "const DEFAULT_GAS_URL = '.*?';"
$replacement = "const DEFAULT_GAS_URL = '$GasUrl';"
$newContent = [regex]::Replace($content, $regex, $replacement)

$destFile = Join-Path $targetDir "index.html"
$newContent | Out-File -FilePath $destFile -Encoding utf8
Write-Host "✅ Created $destFile with GAS URL: $GasUrl" -ForegroundColor Green

# Update root index.html to add the new unit button & JS config if not already present
$rootIndex = Join-Path $scriptDir "index.html"
if (Test-Path $rootIndex) {
    $rootContent = Get-Content -Raw $rootIndex -Encoding utf8
    $needle = "unit$UnitNumber/"
    if ($rootContent -notmatch $needle) {
        $btnHtml = @"
            <!-- Unit $UnitNumber -->
            <a href="unit$UnitNumber/" class="unit-btn" id="btn-unit$UnitNumber">
                <div class="unit-info">
                    <span class="unit-title">📊 UNIT $UnitNumber MONITOR</span>
                    <span class="unit-meta" id="meta-unit$UnitNumber">Connecting telemetry...</span>
                </div>
                <div class="unit-status-wrap">
                    <span class="unit-tag checking" id="tag-unit$UnitNumber">CHECKING...</span>
                </div>
            </a>
            <!-- Additional units (e.g. unit3/, unit4/) can be added here -->
"@
        $rootContent = $rootContent.Replace("<!-- Additional units (e.g. unit3/, unit4/) can be added here -->", $btnHtml)

        $jsEntry = @"
            {
                id: 'unit$UnitNumber',
                name: 'UNIT $UnitNumber MONITOR',
                path: 'unit$UnitNumber/',
                defaultGasUrl: '$GasUrl'
            },
            // NEXT_UNIT_CONFIG
"@
        if ($rootContent -match "// NEXT_UNIT_CONFIG") {
            $rootContent = $rootContent.Replace("// NEXT_UNIT_CONFIG", $jsEntry)
        }

        $rootContent | Out-File -FilePath $rootIndex -Encoding utf8
        Write-Host "✅ Added Unit $UnitNumber to root portal ($rootIndex)" -ForegroundColor Cyan
    }
}

Write-Host "🎉 Unit $UnitNumber is ready! Commit and push to GitHub to activate." -ForegroundColor Yellow
