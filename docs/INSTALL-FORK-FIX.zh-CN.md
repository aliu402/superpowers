# Fork 版本安装问题修复

## 问题：Claude Code UI 不支持本地路径

Claude Code 的 "Add Marketplace" 界面不支持 Windows 绝对路径格式。

## 解决方案：直接编辑配置文件

### 步骤 1：找到配置文件

**Windows:**
```
%USERPROFILE%\.claude\settings.json
```

完整路径通常是：
```
C:\Users\你的用户名\.claude\settings.json
```

### 步骤 2：打开配置文件

**使用记事本：**
```bash
notepad %USERPROFILE%\.claude\settings.json
```

**或使用 VS Code：**
```bash
code %USERPROFILE%\.claude\settings.json
```

### 步骤 3：编辑配置

如果文件不存在或为空，创建以下内容：

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

**如果文件已有内容，**合并配置：

```json
{
  "pluginMarketplaces": {
    "existing-marketplace": "...",
    "superpowers-local": "file:///D:/My-MCP-Servers/superpowers/.claude-plugin/marketplace.json"
  },
  "enabledPlugins": {
    "existing-plugin@existing-marketplace": true,
    "superpowers@superpowers-local": true
  }
}
```

### 步骤 4：验证 JSON 格式

确保：
- ✅ 所有字符串用双引号 `"`
- ✅ 对象和数组的最后一项**不要**逗号
- ✅ 路径使用正斜杠 `/`
- ✅ 使用 `file:///` 前缀（三个斜杠）

**常见错误：**

```json
// ❌ 错误 - 最后一项有逗号
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///D:/My-MCP-Servers/superpowers/.claude-plugin/marketplace.json",
  }
}

// ✅ 正确 - 最后一项没有逗号
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///D:/My-MCP-Servers/superpowers/.claude-plugin/marketplace.json"
  }
}
```

### 步骤 5：保存并重启

1. 保存文件
2. 关闭所有 Claude Code 窗口
3. 重新启动 Claude Code

### 步骤 6：验证安装

打开终端，运行：

```bash
claude plugin list
```

**预期输出：**
```
Installed plugins:
  - superpowers (v4.1.0) from superpowers-local
```

如果看到这个输出，说明安装成功！

## 完整配置示例

### 最小配置（只有 Superpowers）

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

### 完整配置（包含其他插件）

```json
{
  "pluginMarketplaces": {
    "official": "anthropic/claude-code-marketplace",
    "superpowers-local": "file:///D:/My-MCP-Servers/superpowers/.claude-plugin/marketplace.json"
  },
  "enabledPlugins": {
    "some-plugin@official": true,
    "superpowers@superpowers-local": true
  },
  "theme": "dark",
  "fontSize": 14
}
```

## 故障排除

### 问题 1：插件未显示

**检查配置文件：**
```bash
type %USERPROFILE%\.claude\settings.json
```

**验证内容：**
- 路径是否正确
- JSON 格式是否有效
- 是否使用了 `file:///` 前缀

### 问题 2：JSON 格式错误

**使用在线工具验证：**
1. 复制你的 `settings.json` 内容
2. 访问 https://jsonlint.com/
3. 粘贴并点击 "Validate JSON"
4. 修复显示的错误

**或使用命令行：**
```bash
python -c "import json; json.load(open(r'%USERPROFILE%\.claude\settings.json'))"
```

如果没有输出，说明格式正确。

### 问题 3：marketplace.json 不存在

**验证文件存在：**
```bash
dir D:\My-MCP-Servers\superpowers\.claude-plugin\marketplace.json
```

**如果不存在，检查：**
```bash
# 查看目录内容
dir D:\My-MCP-Servers\superpowers\.claude-plugin\
```

文件应该存在于你的项目中。

### 问题 4：路径包含空格

如果路径包含空格，不需要转义，直接使用：

```json
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///C:/Users/My Name/Projects/superpowers/.claude-plugin/marketplace.json"
  }
}
```

或使用 URL 编码（空格 → `%20`）：

```json
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///C:/Users/My%20Name/Projects/superpowers/.claude-plugin/marketplace.json"
  }
}
```

## 验证清单

安装完成后，检查：

- [ ] `settings.json` 文件存在
- [ ] JSON 格式正确（无语法错误）
- [ ] 路径使用 `file:///` 前缀
- [ ] 路径使用正斜杠 `/`
- [ ] `.claude-plugin/marketplace.json` 文件存在
- [ ] 重启了 Claude Code
- [ ] `claude plugin list` 显示 superpowers
- [ ] 启动 claude 会话时看到 "你拥有超能力"

## 测试安装

```bash
# 1. 检查插件列表
claude plugin list

# 2. 启动会话
claude

# 3. 测试中文输出
> 你好，请介绍一下你的超能力
```

如果 Claude 用中文回复并介绍 Superpowers 功能，说明安装成功！

## 为什么 UI 不支持本地路径？

Claude Code 的 marketplace UI 设计用于：
- GitHub 仓库（`owner/repo`）
- Git SSH URL
- HTTP/HTTPS URL
- 相对路径（项目内）

**不支持：**
- Windows 绝对路径（`C:\...` 或 `D:\...`）
- `file:///` URL（虽然配置文件支持）

这是 UI 的限制，但配置文件完全支持本地路径。

## 替代方案：使用相对路径（不推荐）

如果你在项目目录内工作，可以使用相对路径：

```json
{
  "pluginMarketplaces": {
    "superpowers-local": "./.claude-plugin/marketplace.json"
  }
}
```

**缺点：**
- 只在项目目录内有效
- 切换到其他目录会失效

**推荐：**
仍然使用绝对路径的 `file:///` 格式。

## 下一步

1. ✅ 直接编辑 `settings.json`
2. ✅ 使用 `file:///` 格式的绝对路径
3. ✅ 验证 JSON 格式
4. ✅ 重启 Claude Code
5. ✅ 测试安装

## 获取帮助

如果仍有问题：
- 📖 查看 [完整安装指南](INSTALL-FORK.zh-CN.md)
- 🐛 在 GitHub 上提交 Issue
- 💬 提供你的 `settings.json` 内容（隐藏敏感信息）

---

**提示：** 直接编辑配置文件是最可靠的方法，绕过了 UI 的限制。
