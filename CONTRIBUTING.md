# CONTRIBUTING.md — 协作规范

## 角色分工

| 角色 | 职责 | 禁止行为 |
|------|------|----------|
| **作者** | 临床经验、图片、思路、医案、原始资料 | 修改工程配置 |
| **GPT** | 古籍校勘、正文编写、译文、现代解释、统一风格、参考文献 | 修改工程配置 |
| **Codex（本工程）** | 文件维护、Git、版本、构建脚本、全文索引 | 编写医学内容 |

## 工作流程

1. 作者提供原始资料 → GPT 处理 → Codex 执行工程流程。
2. 所有正文内容必须经过 GPT 审核，不得由 Codex 直接生成医学内容。
3. Codex 收到 GPT 正文后：保存 Markdown → 更新目录 → 更新索引 → 更新 References → 更新 TODO → 更新 CHANGELOG → 更新 VERSION → Git Commit。

## Git 提交规范

```bash
# 穴位完成
git commit -m "feat(acupoint): 完成 太冲"

# 工程初始化
git commit -m "chore(project): 完成出版工程初始化"

# 配置文件更新
git commit -m "chore(config): 更新 book.yaml"

# 文献索引更新
git commit -m "refactor(index): 更新全文索引映射"
```

## Commit 规则

- 每完成一个穴位独立提交一次。
- 不得在单次提交中混合多个穴位的正文。
- 不得在工程配置修改中混入内容提交。
- Commit message 使用中文。

## 分支策略

- 主分支：`main`（仅接受正式版本合并）
- 开发分支：`dev/`（可选，用于多人协作）
- 穴位分支：`feat/acupoint-xxx`（可选）

## 文件命名

- 章节文件：`chapters/01 肝经.md`
- 穴位文件：在对应章节 Markdown 内以二级标题区分
- 图片文件：`images/chXX_穴位名_说明.png`
- 文献副本：`references/书名/卷名.md`

## 审查流程

- Codex 在每次提交前检查：模板字段完整性、标题层级、无未闭合的 Markdown 语法。
- 发现问题在提交前修复，不带病提交。
- 医学内容正确性由作者和 GPT 共同保证，Codex 不负医审责任。

## 冲突处理

- 多人同时修改穴位正文时，以最新提交的 GPT 正文为准。
- 工程配置文件冲突：由 Codex 判断，保留更完整的版本。
- 遇到不确定情况，暂停工作，等待人工决策。
