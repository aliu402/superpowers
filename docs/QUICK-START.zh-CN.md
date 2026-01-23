# Superpowers 快速开始指南

## 一分钟安装

```bash
# 1. 注册市场
claude plugin marketplace add obra/superpowers-marketplace

# 2. 安装插件
claude plugin install superpowers@superpowers-marketplace

# 3. 开始使用
claude
```

## 常用命令

### 插件管理

```bash
# 查看已安装的插件
claude plugin list

# 更新插件
claude plugin update superpowers

# 启用/禁用插件
claude plugin enable superpowers
claude plugin disable superpowers

# 卸载插件
claude plugin uninstall superpowers
```

### Superpowers 命令

在 Claude 会话中使用：

```bash
# 头脑风暴 - 设计阶段
/superpowers:brainstorm

# 编写计划 - 计划阶段
/superpowers:write-plan

# 执行计划 - 实施阶段
/superpowers:execute-plan
```

## 基本工作流程

### 1. 启动会话

```bash
cd /path/to/your/project
claude
```

### 2. 描述需求

```
> 我想添加一个用户认证功能
```

### 3. 自动工作流

Superpowers 会自动：
- ✅ 使用头脑风暴技能细化设计
- ✅ 建议创建 Git worktree
- ✅ 编写详细的实施计划
- ✅ 执行计划（带自动审查）
- ✅ 完成开发并提供合并选项

## 核心技能

### 设计阶段

**头脑风暴 (brainstorming)**
- 通过对话细化需求
- 探索多种方案
- 生成设计文档

```
> 我想构建一个 API 服务
```

### 计划阶段

**编写计划 (writing-plans)**
- 分解为 2-5 分钟的小任务
- 包含完整代码和验证步骤
- 保存到 `docs/plans/`

```
> 根据设计创建实施计划
```

### 实施阶段

**测试驱动开发 (TDD)**
- RED: 编写失败的测试
- GREEN: 编写最小实现
- REFACTOR: 重构代码

自动触发，无需手动调用。

**执行计划 (executing-plans)**
- 批量执行任务
- 人工检查点
- 进度报告

```
> 执行计划
```

**子代理驱动开发 (subagent-driven-development)**
- 每个任务派发新代理
- 两阶段审查（规格 + 质量）
- 快速迭代

自动建议使用。

### 调试阶段

**系统化调试 (systematic-debugging)**
- 四阶段根因分析
- 防止症状修复
- 强制测试先行

```
> 这个功能有 bug
```

### 审查阶段

**代码审查 (requesting-code-review)**
- 任务间自动审查
- 按严重程度报告
- 阻止关键问题

自动触发。

## 命令行技巧

### 单次提问

```bash
# 不进入交互模式
claude -p "请分析这个项目的结构"
```

### 指定权限

```bash
# 允许所有工具
claude --allowed-tools=all

# 添加目录权限
claude --add-dir /path/to/dir

# 绕过权限检查
claude --permission-mode bypassPermissions
```

### 会话管理

```bash
# 列出会话
claude sessions list

# 恢复会话
claude sessions resume <session-id>

# 删除会话
claude sessions delete <session-id>
```

## 中文输出

### 自动生效

如果项目中有 `.kiro/steering/chinese-output.md`，中文输出自动生效。

### 手动配置

```bash
# 工作区级别（推荐）
mkdir -p .kiro/steering
cp /path/to/superpowers/.kiro/steering/chinese-output.md .kiro/steering/

# 全局级别
mkdir -p ~/.kiro/steering
cp /path/to/superpowers/.kiro/steering/chinese-output.md ~/.kiro/steering/
```

### 临时切换语言

```bash
# 切换到英文
> Please respond in English

# 切换回中文
> 请用中文回复
```

## 自定义技能

### 创建个人技能

```bash
# 1. 创建技能目录
mkdir -p ~/.claude/skills/my-skill

# 2. 创建技能文件
cat > ~/.claude/skills/my-skill/SKILL.md << 'EOF'
---
name: my-skill
description: 使用场景 - 功能描述
---

# 我的技能

## 概述
技能说明

## 使用方法
1. 步骤一
2. 步骤二
EOF
```

### 使用个人技能

```bash
claude
> 使用 my-skill 来处理这个任务
```

## 故障排除

### 插件未加载

```bash
# 检查插件状态
claude plugin list

# 启用插件
claude plugin enable superpowers

# 重新安装
claude plugin uninstall superpowers
claude plugin install superpowers@superpowers-marketplace
```

### 命令不可用

```bash
# 更新插件
claude plugin update superpowers

# 查看帮助
claude help
```

### 中文输出未生效

```bash
# 检查配置文件
ls -la .kiro/steering/chinese-output.md
ls -la ~/.kiro/steering/chinese-output.md

# 如果不存在，复制配置
mkdir -p .kiro/steering
cp /path/to/superpowers/.kiro/steering/chinese-output.md .kiro/steering/
```

### 调试模式

```bash
# 启用详细日志
claude --log-level debug

# 查看会话日志
ls -la ~/.claude/projects/
```

## 示例场景

### 场景 1：新功能开发

```bash
cd my-project
claude

> 我想添加用户注册功能

# Claude 自动：
# 1. 头脑风暴 - 细化需求
# 2. 创建 worktree
# 3. 编写计划
# 4. 执行实施
# 5. 完成合并
```

### 场景 2：Bug 修复

```bash
claude

> 登录功能有问题，用户无法登录

# Claude 自动：
# 1. 系统化调试 - 根因分析
# 2. 创建失败测试
# 3. 修复实现
# 4. 验证修复
```

### 场景 3：代码重构

```bash
claude

> 这段代码需要重构，太复杂了

# Claude 自动：
# 1. 分析现有代码
# 2. 编写测试（如果没有）
# 3. 逐步重构
# 4. 保持测试通过
```

## 最佳实践

### ✅ 推荐做法

- 让技能自动触发（不要手动指定）
- 遵循 TDD 流程
- 使用 Git worktrees 隔离工作
- 小步提交，频繁验证
- 信任自动审查流程

### ❌ 避免做法

- 跳过测试直接写代码
- 在主分支上直接开发
- 一次性完成大量任务
- 忽略审查反馈
- 手动修复而不写测试

## 快速参考

| 需求 | 技能 | 触发方式 |
|------|------|---------|
| 设计新功能 | brainstorming | 自动 |
| 创建计划 | writing-plans | 自动 |
| 实施功能 | executing-plans | 命令或自动 |
| 编写代码 | test-driven-development | 自动 |
| 修复 Bug | systematic-debugging | 自动 |
| 代码审查 | requesting-code-review | 自动 |
| 完成开发 | finishing-a-development-branch | 自动 |

## 获取帮助

- 📖 [完整安装指南](INSTALL.zh-CN.md)
- 📖 [中文输出指南](chinese-output-guide.md)
- 🐛 [问题反馈](https://github.com/obra/superpowers/issues)
- 💬 [项目主页](https://github.com/obra/superpowers)

## 下一步

1. ✅ 安装完成
2. 📚 阅读 [中文输出指南](chinese-output-guide.md)
3. 🚀 开始你的第一个项目
4. 💡 探索更多技能

---

**需要更多帮助？** 查看 [完整文档](INSTALL.zh-CN.md) 或在 GitHub 上提问。
