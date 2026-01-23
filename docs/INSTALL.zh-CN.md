# Superpowers 安装指南（Claude Code）

本指南说明如何在 Claude Code CLI 终端中安装和使用 Superpowers。

## 前提条件

- 已安装 Claude Code CLI
- 可以在终端中运行 `claude` 命令

## 安装步骤

### 方法一：从插件市场安装（推荐）

#### 1. 注册插件市场

首先，在终端中注册 Superpowers 插件市场：

```bash
claude plugin marketplace add obra/superpowers-marketplace
```

**预期输出：**
```
✓ Added marketplace: obra/superpowers-marketplace
```

#### 2. 安装 Superpowers 插件

从市场安装插件：

```bash
claude plugin install superpowers@superpowers-marketplace
```

**预期输出：**
```
✓ Installing superpowers from superpowers-marketplace...
✓ Plugin installed successfully
```

#### 3. 验证安装

检查插件是否正确安装：

```bash
claude plugin list
```

**预期输出：**
```
Installed plugins:
  - superpowers (v4.1.0) from superpowers-marketplace
```

查看可用的命令：

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

### 方法二：从本地开发版本安装

如果你正在开发或测试 Superpowers，可以从本地目录安装：

#### 1. 克隆仓库

```bash
git clone https://github.com/obra/superpowers.git
cd superpowers
```

#### 2. 配置本地市场

编辑 Claude Code 配置文件 `~/.claude/settings.json`，添加本地市场：

```json
{
  "pluginMarketplaces": {
    "superpowers-dev": "file:///path/to/superpowers/.claude-plugin/marketplace.json"
  },
  "enabledPlugins": {
    "superpowers@superpowers-dev": true
  }
}
```

**注意：** 将 `/path/to/superpowers` 替换为实际的绝对路径。

#### 3. 重启 Claude Code

配置修改后需要重启 Claude Code 才能生效。

## 使用 Superpowers

### 启动会话

安装完成后，每次启动 Claude Code 会话时，Superpowers 会自动加载：

```bash
claude
```

**你会看到：**
```
<EXTREMELY_IMPORTANT>
你拥有超能力。

**以下是你的 'superpowers:using-superpowers' 技能的完整内容...**
</EXTREMELY_IMPORTANT>
```

### 使用命令

#### 头脑风暴

```bash
claude
> /superpowers:brainstorm
```

这会启动交互式设计细化流程。

#### 编写计划

```bash
claude
> /superpowers:write-plan
```

这会根据设计创建详细的实施计划。

#### 执行计划

```bash
claude
> /superpowers:execute-plan
```

这会批量执行实施计划。

### 使用技能

技能会自动触发，但你也可以明确请求使用特定技能：

```bash
claude
> 我想使用测试驱动开发来实现这个功能
```

Claude 会自动加载并使用 `test-driven-development` 技能。

### 在项目中使用

在项目目录中启动 Claude：

```bash
cd /path/to/your/project
claude
```

Superpowers 会自动：
1. 检测项目上下文
2. 加载相关技能
3. 提供工作流程指导

## 中文输出配置

### 自动生效

如果你的项目中有 `.kiro/steering/chinese-output.md` 文件（如本项目），中文输出会自动生效。

### 手动配置

如果你想在其他项目中使用中文输出，可以：

#### 选项 1：复制 steering 文件

```bash
# 在你的项目根目录
mkdir -p .kiro/steering
cp /path/to/superpowers/.kiro/steering/chinese-output.md .kiro/steering/
```

#### 选项 2：创建全局配置

在用户级别配置中文输出：

```bash
mkdir -p ~/.kiro/steering
cp /path/to/superpowers/.kiro/steering/chinese-output.md ~/.kiro/steering/
```

**注意：** 工作区级别的配置优先于全局配置。

## 验证中文输出

启动 Claude 并测试：

```bash
claude
> 你好，请介绍一下你的超能力
```

**预期响应：**
```
你好！我拥有 Superpowers 技能系统，这是一套完整的软件开发工作流程。

我的主要能力包括：

1. **头脑风暴** - 在编写代码前，通过对话细化需求和设计
2. **编写计划** - 将工作分解为 2-5 分钟的小任务
3. **测试驱动开发** - 强制执行 RED-GREEN-REFACTOR 循环
...
```

## 常见问题

### Q: 插件没有自动加载怎么办？

**A:** 检查插件是否已启用：

```bash
claude plugin list
```

如果插件显示为禁用，启用它：

```bash
claude plugin enable superpowers
```

### Q: 命令不可用怎么办？

**A:** 确保插件版本正确：

```bash
claude plugin list
```

如果版本过旧，更新插件：

```bash
claude plugin update superpowers
```

### Q: 中文输出没有生效怎么办？

**A:** 检查 steering 文件是否存在：

```bash
# 检查工作区配置
ls -la .kiro/steering/chinese-output.md

# 检查全局配置
ls -la ~/.kiro/steering/chinese-output.md
```

如果文件不存在，按照上面的"手动配置"步骤创建。

### Q: 如何在特定会话中禁用中文输出？

**A:** 在对话中明确说明：

```bash
claude
> Please respond in English for this session.
```

### Q: 如何更新 Superpowers？

**A:** 运行更新命令：

```bash
claude plugin update superpowers
```

### Q: 如何卸载 Superpowers？

**A:** 运行卸载命令：

```bash
claude plugin uninstall superpowers
```

## 高级配置

### 自定义技能

你可以创建自己的技能来扩展 Superpowers：

```bash
# 创建个人技能目录
mkdir -p ~/.claude/skills/my-custom-skill

# 创建技能文件
cat > ~/.claude/skills/my-custom-skill/SKILL.md << 'EOF'
---
name: my-custom-skill
description: 使用场景 - 功能描述
---

# 我的自定义技能

## 概述

这是一个自定义技能的示例。

## 使用方法

1. 步骤一
2. 步骤二
3. 步骤三
EOF
```

个人技能会自动被 Claude Code 发现和使用。

### 配置钩子

Superpowers 使用会话启动钩子来自动加载。你可以查看钩子配置：

```bash
cat ~/.claude/plugins/superpowers/hooks/session-start.sh
```

### 调试模式

如果遇到问题，可以启用调试模式：

```bash
claude --log-level debug
```

这会显示详细的插件加载和技能触发信息。

## 命令行选项

### 在命令行中直接使用

你可以在命令行中直接提问，而不需要进入交互模式：

```bash
# 单次提问
claude -p "请帮我设计一个用户认证系统"

# 使用特定技能
claude -p "使用头脑风暴技能来设计一个 API"

# 在项目目录中执行
cd /path/to/project
claude -p "分析这个项目的结构"
```

### 权限控制

某些操作可能需要权限：

```bash
# 允许所有工具
claude --allowed-tools=all

# 添加目录访问权限
claude --add-dir /path/to/directory

# 绕过权限检查（谨慎使用）
claude --permission-mode bypassPermissions
```

### 会话管理

```bash
# 查看会话历史
claude sessions list

# 恢复之前的会话
claude sessions resume <session-id>

# 删除会话
claude sessions delete <session-id>
```

## 工作流程示例

### 完整的功能开发流程

```bash
# 1. 启动 Claude
cd /path/to/your/project
claude

# 2. 头脑风暴（自动触发）
> 我想添加一个用户认证功能

# Claude 会自动使用 brainstorming 技能
# 通过对话细化需求和设计

# 3. 创建 Git worktree（自动建议）
# Claude 会建议创建隔离的工作空间

# 4. 编写计划（自动触发）
# Claude 会创建详细的实施计划

# 5. 执行计划
> 开始执行计划

# Claude 会使用 subagent-driven-development 或 executing-plans
# 逐任务实施，带有自动审查

# 6. 完成开发
# Claude 会使用 finishing-a-development-branch
# 验证测试，提供合并选项
```

## 资源链接

- **项目主页**：https://github.com/obra/superpowers
- **问题反馈**：https://github.com/obra/superpowers/issues
- **插件市场**：https://github.com/obra/superpowers-marketplace
- **博客文章**：https://blog.fsck.com/2025/10/09/superpowers/

## 获取帮助

如果遇到问题：

1. 查看 [中文输出指南](chinese-output-guide.md)
2. 查看 [常见问题](chinese-output-guide.md#常见问题)
3. 在 GitHub 上提交 Issue
4. 查看项目文档

---

**English version:** See [Installation Guide](../README.md#installation)
