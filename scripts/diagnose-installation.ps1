# Superpowers 安装诊断脚本
# 用于检查本地安装配置是否正确

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Superpowers 安装诊断工具" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# 1. 检查项目路径
Write-Host "1. 检查项目路径..." -ForegroundColor Yellow
$projectPath = "D:\My-MCP-Servers\superpowers"
if (Test-Path $projectPath) {
    Write-Host "   ✓ 项目目录存在: $projectPath" -ForegroundColor Green
} else {
    Write-Host "   ✗ 项目目录不存在: $projectPath" -ForegroundColor Red
    Write-Host "   请修改脚本中的路径为实际路径" -ForegroundColor Yellow
    exit 1
}

# 2. 检查 marketplace.json
Write-Host ""
Write-Host "2. 检查 marketplace.json..." -ForegroundColor Yellow
$marketplacePath = Join-Path $projectPath ".claude-plugin\marketplace.json"
if (Test-Path $marketplacePath) {
    Write-Host "   ✓ marketplace.json 存在" -ForegroundColor Green
    
    # 验证 JSON 格式
    try {
        $marketplace = Get-Content $marketplacePath -Raw | ConvertFrom-Json
        Write-Host "   ✓ JSON 格式正确" -ForegroundColor Green
        Write-Host "   - 插件名称: $($marketplace.plugins[0].name)" -ForegroundColor Gray
        Write-Host "   - 版本: $($marketplace.plugins[0].version)" -ForegroundColor Gray
        Write-Host "   - Source: $($marketplace.plugins[0].source)" -ForegroundColor Gray
    } catch {
        Write-Host "   ✗ JSON 格式错误: $_" -ForegroundColor Red
    }
} else {
    Write-Host "   ✗ marketplace.json 不存在" -ForegroundColor Red
}

# 3. 检查 plugin.json
Write-Host ""
Write-Host "3. 检查 plugin.json..." -ForegroundColor Yellow
$pluginPath = Join-Path $projectPath ".claude-plugin\plugin.json"
if (Test-Path $pluginPath) {
    Write-Host "   ✓ plugin.json 存在" -ForegroundColor Green
    
    try {
        $plugin = Get-Content $pluginPath -Raw | ConvertFrom-Json
        Write-Host "   ✓ JSON 格式正确" -ForegroundColor Green
        Write-Host "   - 插件名称: $($plugin.name)" -ForegroundColor Gray
        Write-Host "   - 版本: $($plugin.version)" -ForegroundColor Gray
    } catch {
        Write-Host "   ✗ JSON 格式错误: $_" -ForegroundColor Red
    }
} else {
    Write-Host "   ✗ plugin.json 不存在" -ForegroundColor Red
}

# 4. 检查 Claude Code 配置
Write-Host ""
Write-Host "4. 检查 Claude Code 配置..." -ForegroundColor Yellow
$settingsPath = Join-Path $env:USERPROFILE ".claude\settings.json"
if (Test-Path $settingsPath) {
    Write-Host "   ✓ settings.json 存在" -ForegroundColor Green
    
    try {
        $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json
        Write-Host "   ✓ JSON 格式正确" -ForegroundColor Green
        
        # 检查 marketplace 配置
        if ($settings.pluginMarketplaces) {
            Write-Host "   ✓ pluginMarketplaces 已配置" -ForegroundColor Green
            $settings.pluginMarketplaces.PSObject.Properties | ForEach-Object {
                Write-Host "     - $($_.Name): $($_.Value)" -ForegroundColor Gray
            }
        } else {
            Write-Host "   ✗ pluginMarketplaces 未配置" -ForegroundColor Red
        }
        
        # 检查 enabled plugins
        if ($settings.enabledPlugins) {
            Write-Host "   ✓ enabledPlugins 已配置" -ForegroundColor Green
            $settings.enabledPlugins.PSObject.Properties | ForEach-Object {
                Write-Host "     - $($_.Name): $($_.Value)" -ForegroundColor Gray
            }
        } else {
            Write-Host "   ✗ enabledPlugins 未配置" -ForegroundColor Red
        }
    } catch {
        Write-Host "   ✗ JSON 格式错误: $_" -ForegroundColor Red
    }
} else {
    Write-Host "   ✗ settings.json 不存在" -ForegroundColor Red
    Write-Host "   路径: $settingsPath" -ForegroundColor Gray
}

# 5. 检查技能文件
Write-Host ""
Write-Host "5. 检查技能文件..." -ForegroundColor Yellow
$skillsPath = Join-Path $projectPath "skills"
if (Test-Path $skillsPath) {
    $skillCount = (Get-ChildItem $skillsPath -Directory).Count
    Write-Host "   ✓ skills 目录存在，包含 $skillCount 个技能" -ForegroundColor Green
    
    # 列出几个关键技能
    $keySkills = @("using-superpowers", "brainstorming", "test-driven-development")
    foreach ($skill in $keySkills) {
        $skillPath = Join-Path $skillsPath "$skill\SKILL.md"
        if (Test-Path $skillPath) {
            Write-Host "   ✓ $skill 存在" -ForegroundColor Green
        } else {
            Write-Host "   ✗ $skill 不存在" -ForegroundColor Red
        }
    }
} else {
    Write-Host "   ✗ skills 目录不存在" -ForegroundColor Red
}

# 6. 检查中文输出配置
Write-Host ""
Write-Host "6. 检查中文输出配置..." -ForegroundColor Yellow
$chineseOutputPath = Join-Path $projectPath ".kiro\steering\chinese-output.md"
if (Test-Path $chineseOutputPath) {
    Write-Host "   ✓ 中文输出配置存在" -ForegroundColor Green
} else {
    Write-Host "   ✗ 中文输出配置不存在" -ForegroundColor Red
}

# 7. 生成建议的配置
Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "建议的配置" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "如果插件未加载，请确保 settings.json 包含以下内容：" -ForegroundColor Yellow
Write-Host ""
Write-Host '{' -ForegroundColor White
Write-Host '  "pluginMarketplaces": {' -ForegroundColor White
Write-Host "    `"superpowers-local`": `"file:///$($projectPath.Replace('\', '/'))/.claude-plugin/marketplace.json`"" -ForegroundColor White
Write-Host '  },' -ForegroundColor White
Write-Host '  "enabledPlugins": {' -ForegroundColor White
Write-Host '    "superpowers@superpowers-local": true' -ForegroundColor White
Write-Host '  }' -ForegroundColor White
Write-Host '}' -ForegroundColor White
Write-Host ""

# 8. 下一步操作
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "下一步操作" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. 如果配置正确但插件未显示，尝试：" -ForegroundColor Yellow
Write-Host "   - 完全关闭 Claude Code（包括所有窗口）" -ForegroundColor Gray
Write-Host "   - 重新启动 Claude Code" -ForegroundColor Gray
Write-Host "   - 运行: claude plugin list" -ForegroundColor Gray
Write-Host ""
Write-Host "2. 如果仍然无法加载，尝试：" -ForegroundColor Yellow
Write-Host "   - 删除 settings.json 中的配置" -ForegroundColor Gray
Write-Host "   - 重新添加配置" -ForegroundColor Gray
Write-Host "   - 重启 Claude Code" -ForegroundColor Gray
Write-Host ""
Write-Host "3. 查看详细日志：" -ForegroundColor Yellow
Write-Host "   - 运行: claude --log-level debug" -ForegroundColor Gray
Write-Host ""

Write-Host "诊断完成！" -ForegroundColor Green
