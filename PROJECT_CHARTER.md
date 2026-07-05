# 《五输穴与原穴经典汇编》
# PROJECT CHARTER
Version 3.0
Status：FINAL

---

# 一、项目定位

项目名称：《五输穴与原穴经典汇编》

定位：出版级中医学术工程。

最终成果：
- EPUB3
- PDF
- DOCX
- Markdown
- KnowledgeBase
- FullTextIndex

项目长期维护。

---

# 二、团队职责

## 作者

负责：学术方向、临床经验、图片、医案、最终审核。
不得：修改工程结构、修改模板。

## GPT

负责：古籍校勘、古籍译文、正文撰写、古今对照、学术润色、出版风格统一、参考文献规范。
不得：修改工程目录、修改Git、修改数据库。

## Codex

负责：工程维护、Markdown、Git、EPUB、DOCX、PDF、KnowledgeBase、FullTextIndex、Build、Backup。
不得：编写医学正文、编造古籍、修改GPT正文、修改作者观点。

---

# 三、目录结构（固定）

根目录：G:\中医文库

```
G:\中医文库├── Project/          ← 出版工程
├── KnowledgeBase/    ← 穴位资料库
├── FullTextIndex/    ← 全文检索数据库
├── References/       ← 参考文献档案
├── Images/           ← 插图与图片
├── Books/            ← 原始古籍（扫描/文本）
└── Archive/          ← 历史归档
```

不得新增一级目录。

---

# 四、Project 目录

```
Project/
├── README.md
├── VERSION.md
├── CHANGELOG.md
├── TODO.md
├── STYLE.md
├── CONTRIBUTING.md
├── PROJECT_CHARTER.md
├── ROADMAP.md
├── book.yaml
├── chapters/
├── docs/
├── references/
├── scripts/
├── output/
└── images/
```

---

# 五、KnowledgeBase 结构

```
KnowledgeBase/
├── 01 肝经/
├── 02 胆经/
├── 03 心经/
├── 04 小肠经/
├── 05 脾经/
├── 06 胃经/
├── 07 肺经/
├── 08 大肠经/
├── 09 肾经/
├── 10 膀胱经/
├── 11 心包经/
└── 12 三焦经/
```

每个穴位目录：
- 01_经典原文.md
- 02_历代医家.md
- 03_现代教材.md
- 04_现代文献.md
- 05_经典配穴.md
- 06_医案.md
- 07_参考文献.md

KnowledgeBase 仅保存资料，不得写正文。

---

# 六、FullTextIndex

数据库：G:\中医文库\FullTextIndex\FullTextIndex.sqlite

全文数据库唯一，禁止复制，禁止建立第二份数据库。

正文写作前必须首先检索数据库。
数据库无结果时注明：「全文数据库暂无可检索文本（可能为扫描版）」，不得使用网络资料代替。

---

# 七、章节顺序（固定）

01 肝经 → 02 胆经 → 03 心经 → 04 小肠经 → 05 脾经 → 06 胃经 → 07 肺经 → 08 大肠经 → 09 肾经 → 10 膀胱经 → 11 心包经 → 12 三焦经 → 13 附录

不得调整顺序。

---

# 八、穴位模板（固定，22 字段）

# 穴名
## 拼音
## 别名
## 出处
## 所属经络
## 穴性
## 五行属性
## 定位
## 取穴方法
## 针刺
## 艾灸
## 功效
## 主治
## 古籍原文
## 古籍译文
## 古籍应用总结
## 经典配穴
## 现代临床应用
## 作者按
## 注意事项
## 记忆口诀
## 参考文献

不得增加、删除、修改顺序。

---

# 九、工作流程（固定）

① 作者提出需求 → ② Codex 检索 FullTextIndex → ③ Codex 更新 KnowledgeBase → ④ GPT 编写正文 → ⑤ Codex 保存 Markdown → ⑥ 更新目录 → ⑦ 更新参考文献 → ⑧ Git Commit → ⑨ Build → ⑩ 输出 EPUB、PDF、DOCX

---

# 十、KnowledgeBase 检索规则

每个穴位检索以下内容并分类保存：
1. 穴名（如「太冲」）
2. 所属经络（如「足厥阴肝经」）
3. 五输穴类别（原穴、输穴等）
4. 原穴
5. 五行属性
6. 功效
7. 主治
8. 配穴
9. 常见病证

保存字段：原文、出处、书名、卷、篇、作者、年代、备注。

不得修改、翻译、总结原文。

---

# 十一、正文规则

正文来源：仅限作者或 GPT。

Codex 收到 GPT 正文后：
保存 Markdown → 更新目录 → 更新引用 → 更新索引 → 更新 VERSION → 更新 CHANGELOG → Git Commit

不得修改正文内容。

---

# 十二、Git 规范

完成穴位：`feat(acupoint): 完成 太冲`
完成章节：`feat(chapter): 完成 第一章 肝经`
Project 必须保持 Working Tree Clean。

---

# 十三、Build

scripts/build.ps1 输出 EPUB、PDF、DOCX 至 output/。

---

# 十四、Backup

scripts/backup.ps1 执行 git add → git commit → git push。

---

# 十五、每日启动汇报

汇报：版本、Git状态、数据库状态、KnowledgeBase状态、完成章节、完成穴位、剩余任务、TODO。

---

# 十六、永久原则

- 工程目录结构：永久固定
- 模板字段：永久固定
- KnowledgeBase：只能增加，不得删除
- 数据库：唯一，禁止复制
- 正文来源：仅限作者和GPT
- Codex：永远不写医学正文

---

# 十七、最终目标

《五输穴与原穴经典汇编》达到：
- 出版级
- 学术级
- 古籍可追溯
- 引文规范
- EPUB 可发布
- PDF 可印刷
- DOCX 可继续编辑
- Git 可长期维护
- KnowledgeBase 可持续扩展
- FullTextIndex 可全文检索
