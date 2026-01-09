#!/usr/bin/env powershell
# Global Color Theme Update Script - All HTML Files
# Updates blue-gray theme to vibrant primary colors (blue, red, yellow) in TONES
# Usage: cd c:\Users\HP\gordonantwi.github.io && .\update_all_colors.ps1

$files = @(
    'index.html',
    'blog.html',
    'blog-business-architecture.html',
    'blog-post-template.html',
    'portfolio.html',
    'testimonials.html',
    'feedback.html',
    'admin-support-case.html',
    'data-cleanup-case.html',
    'tech-marketing-ops.html'
)

# Color replacements - systematically update all color classes
$replacements = @(
    # === BACKGROUND COLORS ===
    # Dark backgrounds - Convert gray-900 to blue gradients
    @{ old = 'bg-gray-900'; new = 'bg-gradient-to-r from-blue-700 via-blue-600 to-indigo-600' },
    @{ old = 'class="bg-gray-900'; new = 'class="bg-gradient-to-r from-blue-800 via-indigo-700 to-blue-900' },
    
    # Gray-800 backgrounds - Convert to blue
    @{ old = 'bg-gray-800'; new = 'bg-gradient-to-r from-blue-700 to-indigo-600' },
    @{ old = 'bg-gray-800 bg-opacity'; new = 'bg-gradient-to-r from-blue-700 to-purple-700 bg-opacity' },
    
    # Gray-50/100 - Light backgrounds - Add yellow tone
    @{ old = 'bg-gray-50'; new = 'bg-gradient-to-r from-blue-50 to-yellow-50' },
    @{ old = 'bg-gray-100'; new = 'bg-gradient-to-br from-white to-blue-50' },
    
    # === TEXT COLORS ===
    # Gray navigation text to yellow
    @{ old = 'text-gray-300'; new = 'text-yellow-100' },
    @{ old = 'text-gray-200'; new = 'text-white' },
    @{ old = 'text-gray-400'; new = 'text-yellow-200' },
    
    # Blue text replacements
    @{ old = 'text-blue-400'; new = 'text-yellow-300' },
    @{ old = 'text-blue-300'; new = 'text-yellow-200' },
    @{ old = 'text-blue-600'; new = 'text-red-600' },
    @{ old = 'text-blue-800'; new = 'text-blue-900' },
    
    # === HOVER EFFECTS ===
    @{ old = 'hover:text-blue-400'; new = 'hover:text-yellow-300' },
    @{ old = 'hover:text-blue-600'; new = 'hover:text-red-500' },
    @{ old = 'hover:bg-gray-700'; new = 'hover:bg-blue-700' },
    @{ old = 'hover:bg-gray-100'; new = 'hover:bg-yellow-50' },
    
    # === BORDERS ===
    # Blue borders to red/yellow
    @{ old = 'border-blue-600'; new = 'border-red-500' },
    @{ old = 'border-blue-500'; new = 'border-yellow-400' },
    @{ old = 'border-blue-400'; new = 'border-yellow-300' },
    @{ old = 'border-t-4 border-blue'; new = 'border-t-4 border-red' },
    @{ old = 'border-b-4 border-blue'; new = 'border-b-4 border-yellow' },
    @{ old = 'border-l-4 border-blue'; new = 'border-l-4 border-red' },
    
    # === BUTTONS ===
    @{ old = 'bg-blue-600 text-white'; new = 'bg-gradient-to-r from-red-500 to-yellow-400 text-blue-900 font-bold' },
    @{ old = 'bg-blue-600'; new = 'bg-gradient-to-r from-blue-600 to-red-500' },
    @{ old = 'bg-blue-700'; new = 'bg-red-600' },
    
    # === ICONS ===
    @{ old = 'data-lucide="zap" class="w-6 h-6 mr-2 text-blue-400'; new = 'data-lucide="zap" class="w-6 h-6 mr-2 text-yellow-300 drop-shadow-lg' },
    @{ old = 'text-blue-400 mb-3'; new = 'text-yellow-300 mb-3' },
    @{ old = 'text-blue-600 mb-4'; new = 'text-gradient bg-gradient-to-r from-blue-600 to-red-500 bg-clip-text text-transparent mb-4 font-bold' },
    
    # === ACCENT BOXES ===
    @{ old = 'bg-blue-50 border-l-4 border-blue-600'; new = 'bg-gradient-to-r from-blue-50 to-yellow-50 border-l-4 border-red-500' },
    @{ old = 'bg-blue-50 border'; new = 'bg-gradient-to-r from-blue-50 to-yellow-50 border' },
    @{ old = 'text-blue-800'; new = 'text-blue-900' },
    
    # === SPECIFIC ELEMENTS ===
    @{ old = 'bg-blue-900'; new = 'bg-gradient-to-br from-blue-900 to-indigo-800' },
    @{ old = 'bg-blue-700'; new = 'bg-gradient-to-r from-blue-700 to-indigo-700' },
)

$updateCount = 0
$totalChanges = 0

Write-Host "🎨 GLOBAL COLOR THEME UPDATE" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""

foreach ($file in $files) {
    if (Test-Path $file) {
        try {
            $content = Get-Content $file -Raw -Encoding UTF8
            $originalContent = $content
            
            $fileChanges = 0
            foreach ($replacement in $replacements) {
                $beforeCount = ($content | Select-String -Pattern ([regex]::Escape($replacement.old)) -AllMatches).Matches.Count
                $content = $content -replace [regex]::Escape($replacement.old), $replacement.new
                $afterCount = ($content | Select-String -Pattern ([regex]::Escape($replacement.new)) -AllMatches).Matches.Count
                
                if ($content -ne $originalContent) {
                    $fileChanges += $beforeCount
                }
            }
            
            if ($content -ne $originalContent) {
                Set-Content $file -Value $content -Encoding UTF8 -Force
                Write-Host "✅ $file" -ForegroundColor Green
                Write-Host "   └─ $fileChanges color replacements applied" -ForegroundColor Gray
                $updateCount++
                $totalChanges += $fileChanges
            } else {
                Write-Host "⏭️  $file (no changes needed)" -ForegroundColor Yellow
            }
        } catch {
            Write-Host "❌ $file - Error: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "⚠️  $file (not found)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "=================================" -ForegroundColor Cyan
Write-Host "✨ UPDATE COMPLETE!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Summary:" -ForegroundColor Cyan
Write-Host "  Files Updated: $updateCount" -ForegroundColor Green
Write-Host "  Total Replacements: $totalChanges" -ForegroundColor Green
Write-Host ""
Write-Host "🎨 New Color Scheme Applied:" -ForegroundColor Cyan
Write-Host "  🔵 Primary Blue: Gradients (blue-700 to indigo-600)" -ForegroundColor Blue
Write-Host "  🔴 Red Accents: Energy & CTAs (red-500 to red-600)" -ForegroundColor Red
Write-Host "  🟡 Yellow Accents: Warmth & Highlights (yellow-300 to yellow-400)" -ForegroundColor Yellow
Write-Host ""
Write-Host "📋 Files Processed:" -ForegroundColor Cyan
$files | ForEach-Object { Write-Host "   • $_" }
Write-Host ""
Write-Host "✅ All pages now feature vibrant primary colors in tones throughout!" -ForegroundColor Green
