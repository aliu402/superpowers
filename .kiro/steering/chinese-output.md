---
inclusion: always
---

# 中文输出规则

## 核心要求

当使用 Superpowers 技能系统时，所有对外输出和生成的文档必须使用中文（简体中文）。

## 适用范围

### 必须使用中文的内容

1. **用户交流**
   - 所有回复和说明
   - 进度报告和状态更新
   - 问题询问和澄清
   - 错误消息和警告

2. **生成的文档**
   - 设计文档 (`docs/plans/*-design.md`)
   - 实现计划 (`docs/plans/*.md`)
   - README 文件
   - 技术文档
   - 注释和说明

3. **代码注释**
   - 函数和类的文档注释
   - 行内注释
   - TODO 和 FIXME 注释

4. **Git 提交信息**
   - 提交消息主题
   - 提交消息正文
   - 分支名称可以使用英文（技术约定）

### 可以保留英文的内容

1. **代码本身**
   - 变量名、函数名、类名
   - 标准编程语言关键字
   - API 名称和库函数调用

2. **技术术语**
   - 专业术语可以保留英文，但需要在首次出现时提供中文解释
   - 例如："TDD（测试驱动开发）"、"API（应用程序接口）"

3. **配置文件**
   - JSON、YAML 等配置文件的键名
   - 环境变量名称

## 实施指南

### 文档模板

**设计文档示例：**
```markdown
# [功能名称] 设计文档

> **给 Claude：** 必需的子技能：使用 superpowers:executing-plans 来逐任务实现此计划。

**目标：** [用一句话描述要构建的内容]

**架构：** [2-3 句话说明方法]

**技术栈：** [关键技术/库]

---
```

**实现计划示例：**
```markdown
### 任务 N：[组件名称]

**文件：**
- 创建：`exact/path/to/file.py`
- 修改：`exact/path/to/existing.py:123-145`
- 测试：`tests/exact/path/to/test.py`

**步骤 1：编写失败的测试**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

**步骤 2：运行测试验证其失败**

运行：`pytest tests/path/test.py::test_name -v`
预期：失败，显示 "function not defined"
```

### 代码注释示例

```python
def retry_operation(fn, max_retries=3):
    """
    重试失败的操作
    
    参数：
        fn: 要执行的函数
        max_retries: 最大重试次数（默认 3 次）
    
    返回：
        函数执行的结果
    
    异常：
        如果所有重试都失败，抛出最后一次的异常
    """
    for i in range(max_retries):
        try:
            return fn()
        except Exception as e:
            if i == max_retries - 1:
                raise
            # 记录重试信息
            print(f"重试 {i + 1}/{max_retries}")
```

### Git 提交信息示例

```
feat: 添加重试机制

- 实现了带指数退避的重试逻辑
- 添加了最大重试次数配置
- 包含完整的单元测试覆盖
```

## 技能使用中的中文输出

### 宣告技能使用

**英文原版：**
> "I'm using the brainstorming skill to refine this idea."

**中文版本：**
> "我正在使用头脑风暴技能来细化这个想法。"

### 常见技能名称翻译

| 英文技能名 | 中文翻译 | 使用场景 |
|-----------|---------|---------|
| brainstorming | 头脑风暴 | 设计阶段 |
| writing-plans | 编写计划 | 计划阶段 |
| executing-plans | 执行计划 | 实施阶段 |
| test-driven-development | 测试驱动开发 (TDD) | 编码阶段 |
| systematic-debugging | 系统化调试 | 调试阶段 |
| subagent-driven-development | 子代理驱动开发 | 实施阶段 |
| requesting-code-review | 请求代码审查 | 审查阶段 |
| finishing-a-development-branch | 完成开发分支 | 收尾阶段 |

### 进度报告示例

**批量执行报告：**
```markdown
## 批次 1 完成情况

已完成的任务：
- ✅ 任务 1：创建加法函数
- ✅ 任务 2：创建乘法函数
- ✅ 任务 3：添加输入验证

验证结果：
- 所有测试通过 (8/8)
- 代码覆盖率：95%
- 无 lint 错误

准备好接收反馈。
```

## 例外情况

### 用户明确要求英文

如果用户明确要求使用英文输出，则遵循用户的要求：
- "Please respond in English"
- "用英文回复"

### 引用原文

引用英文文档或错误消息时，保留原文并提供中文解释：

```markdown
错误信息：
```
TypeError: Cannot read property 'length' of undefined
```

说明：这个错误表示尝试访问 undefined 值的 length 属性。通常是因为变量未正确初始化。
```

## 质量标准

1. **准确性** - 技术术语翻译准确，不产生歧义
2. **自然性** - 使用自然流畅的中文表达，避免生硬的直译
3. **一致性** - 同一术语在整个项目中保持一致的翻译
4. **专业性** - 使用行业标准的技术术语翻译

## 检查清单

在完成工作前，确认：

- [ ] 所有用户可见的输出都使用中文
- [ ] 生成的文档使用中文撰写
- [ ] 代码注释使用中文
- [ ] Git 提交信息使用中文
- [ ] 技术术语有适当的中文解释
- [ ] 代码本身（变量名、函数名）使用英文
- [ ] 保持了专业性和准确性
