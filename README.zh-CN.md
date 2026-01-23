# Superpowers（超能力）

Superpowers 是为编程助手 AI 设计的完整软件开发工作流系统，基于一套可组合的"技能（Skills）"构建，并提供初始指令确保 AI 助手能够正确使用这些技能。

## 工作原理

从启动编程助手的那一刻开始，当它发现你要构建某个功能时，它不会直接跳入编写代码。相反，它会退一步，询问你真正想要实现什么。

一旦从对话中梳理出规格说明，它会将其分成足够短的片段展示给你，让你能够真正阅读和理解。

在你批准设计后，你的助手会制定一个实施计划，这个计划清晰到即使是一个热情但品味欠佳、缺乏判断力、没有项目背景、厌恶测试的初级工程师也能遵循。它强调真正的红-绿-重构 TDD、YAGNI（你不会需要它）和 DRY（不要重复自己）原则。

接下来，一旦你说"开始"，它会启动一个**子代理驱动开发**流程，让多个代理完成每个工程任务，检查和审查它们的工作，然后继续前进。Claude 能够自主工作几个小时而不偏离你们共同制定的计划，这并不罕见。

还有更多功能，但这就是系统的核心。因为技能会自动触发，你不需要做任何特殊操作。你的编程助手就是拥有了超能力。

## 赞助

如果 Superpowers 帮助你完成了能赚钱的工作，并且你愿意的话，我会非常感激你考虑[赞助我的开源工作](https://github.com/sponsors/obra)。

谢谢！

- Jesse

## 安装

**注意：** 不同平台的安装方式不同。Claude Code 有内置的插件系统。Codex 和 OpenCode 需要手动设置。

### Claude Code（通过插件市场）

#### 快速安装

在 Claude Code CLI 终端中运行：

```bash
# 1. 注册插件市场
claude plugin marketplace add obra/superpowers-marketplace

# 2. 安装插件
claude plugin install superpowers@superpowers-marketplace

# 3. 验证安装
claude plugin list
```

#### 详细安装指南

完整的安装步骤、配置说明和故障排除，请参见：

📖 **[Claude Code 详细安装指南](docs/INSTALL.zh-CN.md)**

### 验证安装

检查命令是否出现：

```bash
claude help
```

```
# 应该看到：
# /superpowers:brainstorm - 交互式设计细化
# /superpowers:write-plan - 创建实施计划
# /superpowers:execute-plan - 批量执行计划
```

### Codex

告诉 Codex：

```
获取并遵循 https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.codex/INSTALL.md 中的指令
```

**详细文档：** [docs/README.codex.md](docs/README.codex.md)

### OpenCode

告诉 OpenCode：

```
获取并遵循 https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.opencode/INSTALL.md 中的指令
```

**详细文档：** [docs/README.opencode.md](docs/README.opencode.md)

## 基本工作流程

1. **头脑风暴（brainstorming）** - 在编写代码前激活。通过提问细化粗略的想法，探索替代方案，分段展示设计以供验证。保存设计文档。

2. **使用 Git Worktrees（using-git-worktrees）** - 设计批准后激活。在新分支上创建隔离的工作空间，运行项目设置，验证干净的测试基线。

3. **编写计划（writing-plans）** - 有了批准的设计后激活。将工作分解为小任务（每个 2-5 分钟）。每个任务都有确切的文件路径、完整的代码、验证步骤。

4. **子代理驱动开发（subagent-driven-development）** 或 **执行计划（executing-plans）** - 有了计划后激活。为每个任务派发新的子代理，进行两阶段审查（规格合规性，然后代码质量），或者在人工检查点处批量执行。

5. **测试驱动开发（test-driven-development）** - 实施期间激活。强制执行 RED-GREEN-REFACTOR：编写失败的测试，观察它失败，编写最小代码，观察它通过，提交。删除在测试之前编写的代码。

6. **请求代码审查（requesting-code-review）** - 任务之间激活。根据计划审查，按严重程度报告问题。关键问题会阻止进度。

7. **完成开发分支（finishing-a-development-branch）** - 任务完成时激活。验证测试，展示选项（合并/PR/保留/丢弃），清理 worktree。

**代理在任何任务前都会检查相关技能。** 这是强制性工作流程，不是建议。

## 内容概览

### 技能库

**测试**
- **test-driven-development** - RED-GREEN-REFACTOR 循环（包含测试反模式参考）

**调试**
- **systematic-debugging** - 四阶段根因分析流程（包含根因追踪、纵深防御、基于条件的等待技术）
- **verification-before-completion** - 在声称成功前确保问题真正修复

**协作**
- **brainstorming** - 苏格拉底式设计细化
- **writing-plans** - 详细的实施计划
- **executing-plans** - 带检查点的批量执行
- **dispatching-parallel-agents** - 并发子代理工作流
- **requesting-code-review** - 预审查清单
- **receiving-code-review** - 响应反馈
- **using-git-worktrees** - 并行开发分支
- **finishing-a-development-branch** - 合并/PR 决策工作流
- **subagent-driven-development** - 快速迭代与两阶段审查（规格合规性，然后代码质量）

**元技能**
- **writing-skills** - 遵循最佳实践创建新技能（包含测试方法）
- **using-superpowers** - 技能系统介绍

## 设计哲学

- **测试驱动开发** - 始终先编写测试
- **系统化而非临时** - 流程优于猜测
- **降低复杂性** - 简单性是首要目标
- **证据优于声明** - 在宣布成功前进行验证

了解更多：[Superpowers for Claude Code](https://blog.fsck.com/2025/10/09/superpowers/)

## 贡献

技能直接存放在此仓库中。要贡献：

1. Fork 此仓库
2. 为你的技能创建一个分支
3. 遵循 `writing-skills` 技能来创建和测试新技能
4. 提交 PR

完整指南请参见 `skills/writing-skills/SKILL.md`。

## 更新

技能会在你更新插件时自动更新：

```bash
/plugin update superpowers
```

## 许可证

MIT 许可证 - 详见 LICENSE 文件

## 支持

- **问题反馈**：https://github.com/obra/superpowers/issues
- **插件市场**：https://github.com/obra/superpowers-marketplace

---

**English version:** [README.md](README.md)
