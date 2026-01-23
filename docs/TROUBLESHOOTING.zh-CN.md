# 故障排除指南

## 问题：配置正确但插件不显示

### 症状

- `settings.json` 配置正确
- `marketplace.json` 文件存在
- 但在 Claude Code 的 marketplace 和 plugin 列表中看不到插件

### 可能的原因和解决方案

#### 1. marketplace.json 中的 source 路径问题

**问题：** marketplace.json 使用了相对路径 `"./"`

**解决方案：** 使用绝对路径

```json
{
  "plugins": [
    {
      "name": "superpowers",
      "source": "file:///D:/My-MCP-Servers/superpowers"
    }
  ]
}
```

**已修复！** 最新版本已经使用绝对路径。

#### 2. Claude Code 未重启

**问题：** 配置更改后 Claude Code 未完全重启

**解决方案：**

1. 关闭所有 Claude Code 窗口（包括后台进程）
2. 打开任务管理器，确保没有 claude.exe 进程
3. 重新启动 Claude Code

**Windows 快速重启：**
```powershell
# 结束所有 Claude 进程
taskkill /F /IM claude.exe /T

# 等待几秒
Start-Sleep -Seconds 2

# 重新启动
claude
```

#### 3. 配置文件缓存问题

**问题：** Claude Code 可能缓存了旧配置

**解决方案：**

1. 备份当前配置：
```powershell
copy %USERPROFILE%\.claude\settings.json %USERPROFILE%\.claude\settings.json.backup
```

2. 删除配置：
```powershell
del %USERPROFILE%\.claude\settings.json
```

3. 重新创建配置：
```powershell
notepad %USERPROFILE%\.claude\settings.json
```

添加：
```json
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///D:/My-MCP-Servers/superpowers/.claude-plugin/marketplace.json"
  },
  "enabledPlugins": {
    "superpowers@superpowers-local": true
  }
}
```

4. 重启 Claude Code

#### 4. 文件权限问题

**问题：** Claude Code 无法读取文件

**解决方案：**

检查文件权限：
```powershell
# 检查 marketplace.json 是否可读
Get-Acl "D:\My-MCP-Servers\superpowers\.claude-plugin\marketplace.json" | Format-List
```

如果有权限问题，添加读取权限：
```powershell
$path = "D:\My-MCP-Servers\superpowers"
$acl = Get-Acl $path
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($env:USERNAME, "Read", "Allow")
$acl.SetAccessRule($rule)
Set-Acl $path $acl
```

#### 5. 路径中的特殊字符

**问题：** 路径包含空格或特殊字符

**解决方案：**

如果路径包含空格，确保使用正确的格式：

```json
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///C:/Users/My%20Name/Projects/superpowers/.claude-plugin/marketplace.json"
  }
}
```

或者不使用 URL 编码（Claude Code 应该支持）：
```json
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///C:/Users/My Name/Projects/superpowers/.claude-plugin/marketplace.json"
  }
}
```

## 验证步骤

### 1. 验证文件存在

```powershell
# 检查 marketplace.json
Test-Path "D:\My-MCP-Servers\superpowers\.claude-plugin\marketplace.json"

# 检查 plugin.json
Test-Path "D:\My-MCP-Servers\superpowers\.claude-plugin\plugin.json"

# 检查 settings.json
Test-Path "$env:USERPROFILE\.claude\settings.json"
```

所有命令都应该返回 `True`。

### 2. 验证 JSON 格式

```powershell
# 验证 marketplace.json
Get-Content "D:\My-MCP-Servers\superpowers\.claude-plugin\marketplace.json" -Raw | ConvertFrom-Json

# 验证 settings.json
Get-Content "$env:USERPROFILE\.claude\settings.json" -Raw | ConvertFrom-Json
```

如果有语法错误，会显示错误信息。

### 3. 验证配置内容

```powershell
# 查看 settings.json 内容
Get-Content "$env:USERPROFILE\.claude\settings.json" -Raw
```

确保包含：
- `pluginMarketplaces` 配置
- `enabledPlugins` 配置
- 路径使用 `file:///` 前缀
- 路径使用正斜杠 `/`

### 4. 测试插件加载

```powershell
# 启动 Claude 并检查插件
claude plugin list
```

**预期输出：**
```
Installed plugins:
  - superpowers (v4.1.0) from superpowers-local
```

如果看不到，继续下一步。

### 5. 查看详细日志

```powershell
# 启用调试日志
claude --log-level debug
```

查看输出中是否有关于插件加载的错误信息。

## 完整的重置流程

如果以上方法都不行，尝试完全重置：

### 步骤 1：备份

```powershell
# 备份配置
copy %USERPROFILE%\.claude\settings.json %USERPROFILE%\.claude\settings.json.backup

# 备份项目（如果有修改）
cd D:\My-MCP-Servers
git clone superpowers superpowers-backup
```

### 步骤 2：清理

```powershell
# 结束所有 Claude 进程
taskkill /F /IM claude.exe /T

# 删除配置
del %USERPROFILE%\.claude\settings.json

# 等待
Start-Sleep -Seconds 2
```

### 步骤 3：重新配置

```powershell
# 创建新配置
notepad %USERPROFILE%\.claude\settings.json
```

添加（确保路径正确）：
```json
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///D:/My-MCP-Servers/superpowers/.claude-plugin/marketplace.json"
  },
  "enabledPlugins": {
    "superpowers@superpowers-local": true
  }
}
```

### 步骤 4：验证项目文件

```powershell
cd D:\My-MCP-Servers\superpowers

# 确保 marketplace.json 使用绝对路径
Get-Content .claude-plugin\marketplace.json
```

应该看到：
```json
{
  "plugins": [
    {
      "name": "superpowers",
      "source": "file:///D:/My-MCP-Servers/superpowers",
      ...
    }
  ]
}
```

### 步骤 5：重启并测试

```powershell
# 启动 Claude
claude

# 检查插件
claude plugin list
```

## 替代方案：使用官方市场

如果本地安装仍然有问题，可以暂时使用官方市场：

```powershell
# 卸载本地版本（如果已安装）
claude plugin uninstall superpowers

# 安装官方版本
claude plugin marketplace add obra/superpowers-marketplace
claude plugin install superpowers@superpowers-marketplace
```

**注意：** 官方版本不包含你的自定义修改（如中文输出配置）。

## 常见错误信息

### "Invalid marketplace source format"

**原因：** 路径格式不正确

**解决：** 确保使用 `file:///` 前缀和正斜杠

### "Cannot find marketplace"

**原因：** 文件路径不存在或无法访问

**解决：** 
1. 验证文件存在
2. 检查路径拼写
3. 检查文件权限

### "Plugin not found in marketplace"

**原因：** marketplace.json 中的插件配置有问题

**解决：**
1. 检查 `source` 字段
2. 确保使用绝对路径
3. 验证 JSON 格式

## 获取帮助

如果问题仍未解决：

1. **收集信息：**
```powershell
# 系统信息
claude --version

# 配置内容
Get-Content "$env:USERPROFILE\.claude\settings.json" -Raw

# marketplace 内容
Get-Content "D:\My-MCP-Servers\superpowers\.claude-plugin\marketplace.json" -Raw

# 插件列表
claude plugin list
```

2. **在 GitHub 上提交 Issue：**
   - 仓库：https://github.com/aliu402/superpowers/issues
   - 包含上面收集的信息
   - 描述你尝试过的步骤

3. **查看相关文档：**
   - [Fork 安装指南](INSTALL-FORK.zh-CN.md)
   - [安装问题修复](INSTALL-FORK-FIX.zh-CN.md)
   - [快速开始](QUICK-START.zh-CN.md)

## 成功标志

当一切正常时，你应该看到：

1. **插件列表中显示：**
```
claude plugin list
Installed plugins:
  - superpowers (v4.1.0) from superpowers-local
```

2. **启动会话时自动加载：**
```
claude
<EXTREMELY_IMPORTANT>
你拥有超能力。
...
</EXTREMELY_IMPORTANT>
```

3. **中文输出生效：**
```
> 你好
你好！我拥有 Superpowers 技能系统...
```

如果看到这些，说明安装成功！
