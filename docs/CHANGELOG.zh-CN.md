# 中文支持更新日志

## 2026-01-23 - 添加中文输出支持

### 新增功能

为 Superpowers 添加了全面的中文输出支持，使所有对外输出和生成的文档都使用中文（简体中文）。

### 新增文件

1. **`.kiro/steering/chinese-output.md`**
   - Kiro 环境的中文输出规则
   - 自动加载（工作区级别）
   - 包含详细的使用指南和示例

2. **`README.zh-CN.md`**
   - 项目的中文版介绍
   - 包含安装、使用和贡献指南

3. **`docs/chinese-output-guide.md`**
   - 完整的中文输出使用指南
   - 包含示例、最佳实践和常见问题

### 修改文件

1. **`.codex/superpowers-bootstrap.md`**
   - 添加语言要求说明
   - 确保 Codex 环境使用中文输出

2. **`.opencode/plugin/superpowers.js`**
   - 在 bootstrap 内容中添加语言要求
   - 确保 OpenCode 环境使用中文输出

3. **`README.md`**
   - 添加中文文档链接
   - 指向中文版 README 和使用指南

### 功能特性

#### 自动生效

- **Kiro**：通过 steering 系统自动加载
- **Claude Code**：通过 steering 系统自动加载
- **Codex**：通过 bootstrap 文件自动加载
- **OpenCode**：通过插件系统提示转换自动注入

#### 适用范围

**使用中文的内容：**
- 用户交流和对话
- 设计文档和实施计划
- 代码注释
- Git 提交信息
- 进度报告和状态更新
- 错误消息和警告

**保持英文的内容：**
- 代码标识符（变量名、函数名、类名）
- 编程语言关键字
- API 名称和库函数调用
- 配置文件键名
- Git 分支名称（推荐）

#### 技术术语处理

- 专业术语可保留英文
- 首次出现时提供中文解释
- 例如："TDD（测试驱动开发）"

### 使用示例

#### 文档生成

```markdown
# 用户认证系统设计文档

**目标：** 实现一个安全的用户认证系统

**架构：** 使用 Express.js 构建 RESTful API

**技术栈：** Node.js, Express.js, PostgreSQL
```

#### 代码注释

```javascript
/**
 * 重试失败的操作
 * @param {Function} fn - 要执行的函数
 * @returns {Promise<any>} 函数执行的结果
 */
async function retryOperation(fn) {
  // 实现逻辑...
}
```

#### Git 提交

```
feat: 添加用户认证功能

- 实现了用户注册和登录 API
- 使用 bcrypt 进行密码哈希
- 包含完整的单元测试
```

### 质量标准

1. **准确性** - 技术术语翻译准确
2. **自然性** - 使用流畅的中文表达
3. **一致性** - 术语翻译保持一致
4. **专业性** - 使用行业标准翻译

### 验证方法

检查配置是否正确加载：

```bash
# Kiro
cat .kiro/steering/chinese-output.md

# Codex
cat .codex/superpowers-bootstrap.md | grep "语言要求"

# OpenCode
cat .opencode/plugin/superpowers.js | grep "语言要求"
```

### 相关文档

- [中文输出规则](.kiro/steering/chinese-output.md)
- [中文输出使用指南](chinese-output-guide.md)
- [中文版 README](../README.zh-CN.md)

### 反馈

如有问题或建议，请在 GitHub 上提交 Issue。

---

**English version:** See main [RELEASE-NOTES.md](../RELEASE-NOTES.md)
