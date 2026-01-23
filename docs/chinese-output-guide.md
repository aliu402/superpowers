# Superpowers 中文输出指南

本文档说明如何配置和使用 Superpowers 的中文输出功能。

## 概述

Superpowers 支持在所有对外输出和生成的文档中使用中文（简体中文），同时保持代码本身使用英文的最佳实践。

## 自动配置

### Kiro（当前环境）

中文输出规则已通过 steering 文件自动配置：

- **位置**：`.kiro/steering/chinese-output.md`
- **生效范围**：工作区级别（自动加载）
- **优先级**：工作区规则优先于全局规则

### Claude Code

如果你在 Claude Code 中使用 Superpowers，中文输出规则会通过 steering 系统自动生效。

### Codex

中文输出指导已集成到 bootstrap 文件中：

- **位置**：`.codex/superpowers-bootstrap.md`
- **生效时机**：每次会话启动时自动加载

### OpenCode

中文输出指导已集成到插件中：

- **位置**：`.opencode/plugin/superpowers.js`
- **生效时机**：通过系统提示转换自动注入

## 使用效果

### 用户交流

AI 助手会使用中文进行所有交流：

```
我正在使用头脑风暴技能来细化这个想法。

让我先了解一下当前项目的状态...

我有几个问题需要澄清：

1. 这个功能的主要用户是谁？
2. 预期的并发用户数量是多少？
3. 是否需要支持离线模式？
```

### 生成的文档

所有文档都会使用中文撰写：

**设计文档示例** (`docs/plans/2026-01-23-用户认证-design.md`)：

```markdown
# 用户认证系统设计文档

> **给 Claude：** 必需的子技能：使用 superpowers:executing-plans 来逐任务实现此计划。

**目标：** 实现一个安全的用户认证系统，支持邮箱/密码登录和 JWT 令牌管理。

**架构：** 使用 Express.js 构建 RESTful API，采用 bcrypt 进行密码哈希，使用 jsonwebtoken 生成和验证令牌。数据存储使用 PostgreSQL，通过 Sequelize ORM 访问。

**技术栈：** Node.js, Express.js, PostgreSQL, Sequelize, bcrypt, jsonwebtoken

---

## 核心组件

### 1. 用户模型

用户表包含以下字段：
- id (UUID, 主键)
- email (字符串, 唯一, 必需)
- password_hash (字符串, 必需)
- created_at (时间戳)
- updated_at (时间戳)
```

**实施计划示例** (`docs/plans/2026-01-23-用户认证.md`)：

```markdown
# 用户认证系统实施计划

> **给 Claude：** 必需的子技能：使用 superpowers:executing-plans 来逐任务实现此计划。

**目标：** 实现用户认证系统

**架构：** RESTful API + JWT 令牌

**技术栈：** Express.js, PostgreSQL, bcrypt, jsonwebtoken

---

### 任务 1：创建用户模型

**文件：**
- 创建：`src/models/User.js`
- 创建：`tests/models/User.test.js`

**步骤 1：编写失败的测试**

```javascript
const { User } = require('../../src/models/User');

describe('User 模型', () => {
  test('应该创建有效的用户', async () => {
    const user = await User.create({
      email: 'test@example.com',
      password: 'securePassword123'
    });
    
    expect(user.email).toBe('test@example.com');
    expect(user.password_hash).toBeDefined();
    expect(user.password_hash).not.toBe('securePassword123');
  });
});
```

**步骤 2：运行测试验证其失败**

运行：`npm test tests/models/User.test.js`
预期：失败，显示 "Cannot find module '../../src/models/User'"
```

### 代码注释

代码注释会使用中文：

```javascript
/**
 * 重试失败的操作
 * 
 * @param {Function} fn - 要执行的函数
 * @param {number} maxRetries - 最大重试次数（默认 3 次）
 * @returns {Promise<any>} 函数执行的结果
 * @throws {Error} 如果所有重试都失败，抛出最后一次的异常
 */
async function retryOperation(fn, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (error) {
      if (i === maxRetries - 1) {
        throw error;
      }
      // 记录重试信息
      console.log(`重试 ${i + 1}/${maxRetries}`);
    }
  }
}
```

### Git 提交信息

提交信息会使用中文：

```bash
git log --oneline

a1b2c3d feat: 添加用户认证功能
e4f5g6h test: 添加用户模型测试
i7j8k9l refactor: 提取密码哈希逻辑
```

详细提交信息：

```
feat: 添加用户认证功能

- 实现了用户注册和登录 API
- 使用 bcrypt 进行密码哈希
- 使用 JWT 生成访问令牌
- 添加了令牌验证中间件
- 包含完整的单元测试和集成测试

相关问题：#123
```

### 进度报告

批量执行的进度报告：

```markdown
## 批次 1 完成情况

已完成的任务：
- ✅ 任务 1：创建用户模型
- ✅ 任务 2：实现密码哈希
- ✅ 任务 3：添加用户注册 API

验证结果：
- 所有测试通过 (15/15)
- 代码覆盖率：92%
- 无 ESLint 错误
- 无 TypeScript 类型错误

准备好接收反馈。
```

## 技术术语处理

技术术语可以保留英文，但会在首次出现时提供中文解释：

```markdown
我们将使用 JWT（JSON Web Token，JSON 网络令牌）来实现无状态认证。

API（应用程序接口）将遵循 RESTful 架构风格。

实现 TDD（测试驱动开发）流程：先写测试，再写实现。
```

## 代码本身保持英文

变量名、函数名、类名等代码标识符保持使用英文：

```javascript
// ✅ 正确：代码使用英文，注释使用中文
class UserAuthService {
  /**
   * 验证用户凭据
   * @param {string} email - 用户邮箱
   * @param {string} password - 用户密码
   * @returns {Promise<User|null>} 验证成功返回用户对象，失败返回 null
   */
  async validateCredentials(email, password) {
    const user = await this.findUserByEmail(email);
    if (!user) {
      return null;
    }
    
    // 验证密码
    const isValid = await bcrypt.compare(password, user.password_hash);
    return isValid ? user : null;
  }
}

// ❌ 错误：不要使用拼音或中文作为标识符
class 用户认证服务 {  // 不推荐
  async 验证凭据(邮箱, 密码) {  // 不推荐
    // ...
  }
}
```

## 技能名称翻译对照

在宣告使用技能时，使用中文翻译：

| 英文技能名 | 中文翻译 | 宣告示例 |
|-----------|---------|---------|
| brainstorming | 头脑风暴 | 我正在使用头脑风暴技能来细化这个想法。 |
| writing-plans | 编写计划 | 我正在使用编写计划技能来创建实施计划。 |
| executing-plans | 执行计划 | 我正在使用执行计划技能来实施这个计划。 |
| test-driven-development | 测试驱动开发 (TDD) | 我正在遵循测试驱动开发 (TDD) 流程。 |
| systematic-debugging | 系统化调试 | 我正在使用系统化调试技能来分析这个问题。 |
| subagent-driven-development | 子代理驱动开发 | 我正在使用子代理驱动开发来执行这个计划。 |

## 例外情况

### 用户明确要求英文

如果用户明确要求使用英文，AI 助手会遵循：

```
用户：Please respond in English for this task.

AI：I'll use English for this task as requested.
```

### 引用原始错误消息

引用英文错误消息时，保留原文并提供中文解释：

```markdown
遇到以下错误：

```
TypeError: Cannot read property 'length' of undefined
    at processArray (src/utils.js:42:15)
```

**错误分析：**
这个错误表示尝试访问 undefined 值的 length 属性。根据堆栈跟踪，问题出现在 `src/utils.js` 的第 42 行。通常是因为：

1. 函数参数未正确传递
2. 变量未初始化
3. 异步操作尚未完成

**解决方案：**
在访问 length 属性前添加空值检查...
```

## 验证配置

### 检查 Kiro 配置

```bash
# 查看 steering 文件
cat .kiro/steering/chinese-output.md
```

### 检查 Codex 配置

```bash
# 查看 bootstrap 文件
cat .codex/superpowers-bootstrap.md | grep "语言要求"
```

### 检查 OpenCode 配置

```bash
# 查看插件文件
cat .opencode/plugin/superpowers.js | grep "语言要求"
```

## 质量标准

遵循以下标准确保高质量的中文输出：

1. **准确性** - 技术术语翻译准确，不产生歧义
2. **自然性** - 使用自然流畅的中文表达，避免生硬的直译
3. **一致性** - 同一术语在整个项目中保持一致的翻译
4. **专业性** - 使用行业标准的技术术语翻译

## 常见问题

### Q: 为什么代码标识符不使用中文？

A: 使用英文标识符是国际编程最佳实践：
- 避免编码问题
- 便于国际协作
- 符合大多数编程语言的命名约定
- 与第三方库和框架保持一致

### Q: 如何处理混合语言的技术文档？

A: 优先使用中文，但保留关键技术术语的英文：
- 首次出现时提供中英对照
- 后续可以只使用中文或英文缩写
- 在括号中提供英文原文

### Q: Git 分支名称应该用中文还是英文？

A: 建议使用英文：
- 分支名称是技术标识符
- 避免 URL 编码问题
- 便于命令行操作

示例：
```bash
# ✅ 推荐
git checkout -b feature/user-authentication

# ❌ 不推荐（可能导致编码问题）
git checkout -b feature/用户认证
```

### Q: 如何临时切换回英文输出？

A: 在消息中明确说明：
```
请用英文回复这个问题。
```

或者：
```
Please respond in English.
```

## 相关文档

- [中文输出规则](.kiro/steering/chinese-output.md) - 完整的规则说明
- [README 中文版](../README.zh-CN.md) - 项目中文介绍
- [技能编写指南](../skills/writing-skills/SKILL.md) - 如何创建新技能

## 反馈和改进

如果你发现中文输出有任何问题或有改进建议，请：

1. 在 GitHub 上提交 Issue
2. 提供具体的示例和建议
3. 说明期望的输出格式

我们会持续改进中文输出的质量和准确性。
