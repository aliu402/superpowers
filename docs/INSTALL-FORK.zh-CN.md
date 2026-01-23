# Fork 版本安装指南

本指南适用于从 fork 的仓库（如 `https://github.com/aliu402/superpowers`）安装 Superpowers。

## ⚠️ 重要提示

**不要使用 Claude Code 的 "Add Marketplace" UI！**

Claude Code 的 UI 不支持 Windows 绝对路径。你需要**直接编辑配置文件**。

详细说明请参见：📖 [安装问题修复指南](INSTALL-FORK-FIX.zh-CN.md)

## 为什么从本地安装？

当你 fork 了 Superpowers 项目后：
- ✅ 可以自定义和修改代码
- ✅ 可以添加自己的技能
- ✅ 可以测试新功能
- ✅ 更改会立即生效
- ✅ 可以贡献回上游项目

## 安装步骤

### 1. 克隆你的 Fork

```bash
# 克隆你的 fork 仓库
git clone https://github.com/aliu402/superpowers.git
cd superpowers

# 添加上游仓库（可选，用于同步更新）
git remote add upstream https://github.com/obra/superpowers.git
```

### 2. 配置 Claude Code

**⚠️ 重要：不要使用 UI，直接编辑配置文件！**

Claude Code 的 "Add Marketplace" UI 不支持 Windows 绝对路径。

#### 打开配置文件

编辑 Claude Code 配置文件：

**Windows:**
```bash
notepad %USERPROFILE%\.claude\settings.json
```

**macOS/Linux:**
```bash
nano ~/.claude/settings.json
```

#### 如果文件不存在

创建文件并添加以下内容：

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

#### 如果文件已存在

在现有内容中添加 marketplace 和 plugin 配置：

```json
{
  "pluginMarketplaces": {
    "existing-marketplace": "...",
    "superpowers-local": "file:///D:/My-MCP-Servers/superpowers/.claude-plugin/marketplace.json"
  },
  "enabledPlugins": {
    "existing-plugin@existing-marketplace": true,
    "superpowers@superpowers-local": true
  },
  "theme": "dark"
}
```

**注意：** 将路径 `D:/My-MCP-Servers/superpowers` 替换为你实际的项目路径。

### 3. 添加本地市场配置

在 `settings.json` 中添加或修改以下内容：

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

**重要：** 将路径 `D:/My-MCP-Servers/superpowers` 替换为你实际的项目路径。

#### 路径格式说明

**Windows 路径转换：**
```
实际路径：D:\My-MCP-Servers\superpowers
配置路径：file:///D:/My-MCP-Servers/superpowers/.claude-plugin/marketplace.json
```

**macOS/Linux 路径：**
```
实际路径：/Users/username/projects/superpowers
配置路径：file:///Users/username/projects/superpowers/.claude-plugin/marketplace.json
```

**注意事项：**
- 使用 `file:///` 前缀（三个斜杠）
- Windows 路径使用正斜杠 `/` 而不是反斜杠 `\`
- 路径必须是绝对路径
- 路径末尾添加 `/.claude-plugin/marketplace.json`

### 4. 验证配置文件

确保你的 `settings.json` 格式正确：

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

**常见错误：**
- ❌ 忘记 `file:///` 前缀
- ❌ 使用反斜杠 `\` 而不是正斜杠 `/`
- ❌ 路径不是绝对路径
- ❌ JSON 格式错误（缺少逗号、引号等）

### 5. 重启 Claude Code

配置修改后，重启 Claude Code 或启动新会话：

```bash
claude
```

### 6. 验证安装

检查插件是否正确加载：

```bash
claude plugin list
```

**预期输出：**
```
Installed plugins:
  - superpowers (v4.1.0) from superpowers-local
```

查看可用命令：

```bash
claude help
```

**应该看到：**
```
Superpowers commands:
  /superpowers:brainstorm       - 交互式设计细化
  /superpowers:write-plan       - 创建实施计划
  /superpowers:execute-plan     - 批量执行计划
```

## 开发工作流

### 修改代码后

修改技能或配置后，更改会立即生效：

```bash
# 1. 修改文件
nano skills/brainstorming/SKILL.md

# 2. 启动新会话测试
claude

# 更改会自动加载，无需重新安装
```

### 同步上游更新

定期从原始仓库同步更新：

```bash
# 1. 获取上游更新
git fetch upstream

# 2. 合并到你的主分支
git checkout main
git merge upstream/main

# 3. 推送到你的 fork
git push origin main
```

### 创建新技能

```bash
# 1. 创建技能目录
mkdir -p skills/my-custom-skill

# 2. 创建技能文件
cat > skills/my-custom-skill/SKILL.md << 'EOF'
---
name: my-custom-skill
description: 使用场景 - 功能描述
---

# 我的自定义技能

## 概述
技能说明

## 使用方法
1. 步骤一
2. 步骤二
EOF

# 3. 测试新技能
claude
> 使用 my-custom-skill
```

### 贡献回上游

如果你的改进对其他人有用，可以贡献回原项目：

```bash
# 1. 创建功能分支
git checkout -b feature/my-improvement

# 2. 提交更改
git add .
git commit -m "feat: 添加新功能"

# 3. 推送到你的 fork
git push origin feature/my-improvement

# 4. 在 GitHub 上创建 Pull Request
# 访问 https://github.com/aliu402/superpowers
# 点击 "Pull Request" 按钮
```

## 故障排除

### 问题 1：插件未加载

**症状：**
```bash
claude plugin list
# 没有显示 superpowers
```

**解决方案：**

1. 检查配置文件路径是否正确：
```bash
# Windows
type %USERPROFILE%\.claude\settings.json

# macOS/Linux
cat ~/.claude/settings.json
```

2. 验证 marketplace.json 文件存在：
```bash
# 检查文件是否存在
ls -la .claude-plugin/marketplace.json
```

3. 检查路径格式：
```json
// ✅ 正确
"file:///D:/My-MCP-Servers/superpowers/.claude-plugin/marketplace.json"

// ❌ 错误 - 缺少 file:///
"D:/My-MCP-Servers/superpowers/.claude-plugin/marketplace.json"

// ❌ 错误 - 使用反斜杠
"file:///D:\My-MCP-Servers\superpowers\.claude-plugin\marketplace.json"
```

### 问题 2：路径找不到

**症状：**
```
Error: Cannot find marketplace at file:///...
```

**解决方案：**

1. 使用绝对路径：
```bash
# Windows - 获取当前目录的绝对路径
cd D:\My-MCP-Servers\superpowers
pwd

# macOS/Linux
cd ~/projects/superpowers
pwd
```

2. 确保路径中没有空格或特殊字符，如果有，使用 URL 编码：
```
空格 → %20
例如：file:///D:/My%20Projects/superpowers/.claude-plugin/marketplace.json
```

### 问题 3：JSON 格式错误

**症状：**
```
Error: Invalid JSON in settings.json
```

**解决方案：**

使用 JSON 验证器检查格式：

```bash
# 在线验证：https://jsonlint.com/
# 或使用命令行工具
python -m json.tool ~/.claude/settings.json
```

常见错误：
```json
// ❌ 错误 - 最后一项后面有逗号
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///...",
  }
}

// ✅ 正确 - 最后一项没有逗号
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///..."
  }
}
```

### 问题 4：更改未生效

**症状：**
修改了技能文件，但 Claude 仍使用旧版本。

**解决方案：**

1. 确保文件已保存
2. 启动新的 Claude 会话
3. 检查文件路径是否正确

```bash
# 验证文件内容
cat skills/brainstorming/SKILL.md

# 启动新会话
claude
```

### 问题 5：中文输出未生效

**症状：**
Claude 仍然使用英文回复。

**解决方案：**

1. 检查 steering 文件是否存在：
```bash
ls -la .kiro/steering/chinese-output.md
```

2. 如果不存在，文件应该已经在你的 fork 中：
```bash
# 确认文件存在
cat .kiro/steering/chinese-output.md
```

3. 启动新会话测试：
```bash
claude
> 你好
```

## 完整配置示例

### Windows 配置示例

**项目路径：** `D:\My-MCP-Servers\superpowers`

**settings.json：**
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

### macOS/Linux 配置示例

**项目路径：** `/Users/username/projects/superpowers`

**settings.json：**
```json
{
  "pluginMarketplaces": {
    "superpowers-local": "file:///Users/username/projects/superpowers/.claude-plugin/marketplace.json"
  },
  "enabledPlugins": {
    "superpowers@superpowers-local": true
  }
}
```

## 验证清单

安装完成后，检查以下项目：

- [ ] `settings.json` 文件格式正确
- [ ] 路径使用 `file:///` 前缀
- [ ] 路径使用正斜杠 `/`
- [ ] 路径是绝对路径
- [ ] `.claude-plugin/marketplace.json` 文件存在
- [ ] `claude plugin list` 显示 superpowers
- [ ] `claude help` 显示 superpowers 命令
- [ ] 启动 claude 会话时看到 "你拥有超能力"
- [ ] Claude 使用中文回复
- [ ] `.kiro/steering/chinese-output.md` 文件存在

## 与上游保持同步

### 定期同步

```bash
# 每周或每月执行一次
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

### 解决冲突

如果合并时出现冲突：

```bash
# 1. 查看冲突文件
git status

# 2. 手动解决冲突
# 编辑冲突文件，保留需要的更改

# 3. 标记为已解决
git add <conflicted-file>

# 4. 完成合并
git commit
```

### 保留你的自定义

如果你有自定义技能或配置，建议：

1. 将自定义内容放在单独的分支
2. 使用 Git 的 cherry-pick 选择性合并
3. 或者将自定义技能放在个人技能目录（`~/.claude/skills/`）

## 下一步

1. ✅ 完成本地安装
2. 📝 修改和测试你的更改
3. 🔄 定期同步上游更新
4. 🚀 贡献你的改进回上游

## 获取帮助

- 📖 [快速开始指南](QUICK-START.zh-CN.md)
- 📖 [中文输出指南](chinese-output-guide.md)
- 🐛 [问题反馈](https://github.com/aliu402/superpowers/issues)
- 💬 [上游项目](https://github.com/obra/superpowers)

---

**提示：** 本地安装的优势是可以立即测试你的更改，非常适合开发和自定义！
