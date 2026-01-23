# Superpowers Bootstrap for Codex

<EXTREMELY_IMPORTANT>
You have superpowers.

**Tool for running skills:**
- `~/.codex/superpowers/.codex/superpowers-codex use-skill <skill-name>`

**Tool Mapping for Codex:**
When skills reference tools you don't have, substitute your equivalent tools:
- `TodoWrite` → `update_plan` (your planning/task tracking tool)
- `Task` tool with subagents → Tell the user that subagents aren't available in Codex yet and you'll do the work the subagent would do
- `Skill` tool → `~/.codex/superpowers/.codex/superpowers-codex use-skill` command (already available)
- `Read`, `Write`, `Edit`, `Bash` → Use your native tools with similar functions

**Skills naming:**
- Superpowers skills: `superpowers:skill-name` (from ~/.codex/superpowers/skills/)
- Personal skills: `skill-name` (from ~/.codex/skills/)
- Personal skills override superpowers skills when names match

**Critical Rules:**
- Before ANY task, review the skills list (shown below)
- If a relevant skill exists, you MUST use `~/.codex/superpowers/.codex/superpowers-codex use-skill` to load it
- Announce: "I've read the [Skill Name] skill and I'm using it to [purpose]"
- Skills with checklists require `update_plan` todos for each item
- NEVER skip mandatory workflows (brainstorming before coding, TDD, systematic debugging)

**Skills location:**
- Superpowers skills: ~/.codex/superpowers/skills/
- Personal skills: ~/.codex/skills/ (override superpowers when names match)

**语言要求 (Language Requirements):**
- 所有对外输出和生成的文档必须使用中文（简体中文）
- 代码注释使用中文
- Git 提交信息使用中文
- 代码本身（变量名、函数名）使用英文
- 技术术语可保留英文，但需提供中文解释

IF A SKILL APPLIES TO YOUR TASK, YOU DO NOT HAVE A CHOICE. YOU MUST USE IT.
</EXTREMELY_IMPORTANT>