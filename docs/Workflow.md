# Workflow.md — 工作流程

## 整体流程

```
作者资料 → GPT 正文编写 → Codex 工程执行 → 构建输出
   ↓              ↓               ↓
  医案        古籍校勘        文件保存
  临床经验     译文           Git Commit
  图片资料     现代解释       索引更新
                                ↓
                           EPUB / DOCX / PDF
```

## 穴位编写流程

### 第一步：全文检索（Codex 执行）

Codex 收到穴位名称后，执行七步检索：

```
① 搜索穴名（如"太冲"）
② 搜索所属经络（如"足厥阴肝经"）
③ 搜索类别（原穴/输穴/五输穴）
④ 搜索功效（疏肝/平肝/熄风/理气）
⑤ 搜索主治（头痛/眩晕/失眠/疝气）
⑥ 搜索经典配穴（太冲 合谷等）
⑦ 自动分类：经典原文 / 历代医家 / 现代教材 / 现代文献 / 配穴 / 医案
```

### 第二步：资料整理（Codex 执行）

- 将每条检索结果保存为结构化记录（含原文、出处、书名、卷、篇、作者、年代、备注）
- 在 `KnowledgeBase/穴位名/` 下建立对应资料夹
- 分类存储，不得修改原文

### 第三步：正文编写（GPT 执行）

- GPT 读取 `KnowledgeBase/穴位名/` 下所有资料
- 按 22 字段模板编写正文
- 输出 Markdown 格式正文

### 第四步：工程执行（Codex 执行）

GPT 提供正文后，Codex 执行以下步骤（不可跳过）：

```
① 保存 Markdown 到 chapters/01 肝经.md（对应穴位章节位置）
② 更新目录（更新 book.yaml 的 chapters.path）
③ 更新索引（更新 references/source-map.yaml）
④ 更新参考文献（更新对应穴位的参考文献列表）
⑤ 更新 TODO（勾选已完成穴位）
⑥ 更新 CHANGELOG（记录本次变更）
⑦ 更新 VERSION（Patch 版本号 +1）
⑧ Git Commit（feat(acupoint): 完成 XXX）
```

### 第五步：构建（自动/手动）

运行 `scripts/build.ps1`，生成 EPUB、DOCX、PDF 至 `output/`。

## 章节编写流程

每章（12 经脉）为独立 Markdown 文件。

顺序：
1. 章节标题：`# XX经`
2. 经脉概述（一段）
3. 各穴位正文（按五输穴排序：井→荥→输→经→合，原穴单独章节）
4. 章节参考文献

## 版本管理

| 事件 | 版本变化 |
|------|----------|
| 完成一个穴位正文 | Patch +1（如 v0.1.0 → v0.1.1）|
| 完成一整章（12 经脉之一）| Minor +1（如 v0.2.0）|
| 完成全部 13 章 | Major +1（v1.0.0）|

## 构建流程

### build.ps1

```powershell
# 输出 EPUB
pandoc chapters/*.md -o output/五输穴与原穴经典汇编.epub --epub-chapter-level=2

# 输出 DOCX
pandoc chapters/*.md -o output/五输穴与原穴经典汇编.docx

# 输出 PDF（需要 WeasyPrint 或 pandoc + xelatex）
pandoc chapters/*.md -o output/五输穴与原穴经典汇编.pdf
```

### backup.ps1

```powershell
git add .
git commit -m "$(Get-Date -Format 'yyyy-MM-dd HH:mm') 更新"
git push
```

## 紧急回滚

```powershell
# 查看最近 5 次提交
git log --oneline -5

# 回滚到上一个版本（保留修改）
git revert HEAD

# 强制回滚（丢弃修改，谨慎使用）
git reset --hard HEAD~1
```

## 知识库维护

新增穴位时，同步在 `KnowledgeBase/` 下建立：

```
KnowledgeBase/
└── 太冲/
    ├── 01_经典原文.md
    ├── 02_历代医家.md
    ├── 03_现代教材.md
    ├── 04_现代文献.md
    ├── 05_配穴.md
    ├── 06_医案.md
    └── 07_参考文献.md
```

每份文件格式：Markdown，UTF-8，文件末尾注明来源。
