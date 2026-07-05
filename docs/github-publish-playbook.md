# GitHub 发布操作手册

**最后更新：2026-07-05**

## 仓库

- **本地路径**：`G:\中医文库\Project`
- **远端**：`https://github.com/xc106346/AcupointBook.git`
- **分支**：`master`（注：GitHub 新建仓库默认 `main`，本项目沿用 master）
- **认证**：复用 GitHub Desktop 已登录的 `xc106346` 账号

## 推送步骤

### 常规推送（commit 已有）

```powershell
cd G:\中医文库\Project
git push origin master
git push origin --tags
```

### 首次发布（本地 → 新空仓库）

```powershell
# 1. 在 GitHub 网页创建空仓库（不要勾选 "Initialize with README"）
# 2. 切换 origin
git remote set-url origin https://github.com/xc106346/AcupointBook.git
# 3. 推送
git push -u origin master
git push origin --tags
```

## 已知坑：ghproxy 代理

历史背景：原 `~/.gitconfig` 有过代理规则

```ini
[url "https://ghproxy.com/https://github.com/"]
    insteadOf = https://github.com/
```

**问题**：`ghproxy.com` 不稳定（2026-07-05 已不可达），连不上时所有 `git push`/`ls-remote` 全部失败。

**症状**：
```
fatal: unable to access 'https://ghproxy.com/https://github.com/...':
Failed to connect to ghproxy.com port 443
```

### 当前状态（2026-07-05 之后）

- 原代理规则已删除
- 当前全局 `~/.gitconfig` 留有一条无害的反向 rule：

```ini
[url "https://github.com/"]
    insteadOf = https://ghproxy.com/https://github.com/
```

这条规则只在 URL 含 `https://ghproxy.com/https://github.com/` 前缀时才生效，平时不影响直连 GitHub。

### 临时推送方案（当任何代理规则导致 push 卡住时）

```powershell
# 1. 列出所有 url.* rules
git config --list --global | Select-String "insteadof"

# 2. 删除卡住的那条
git config --global --unset-all url."https://ghproxy.com/https://github.com/".insteadof

# 3. 推送
git push origin master
git push origin --tags

# 4. 如果需要恢复，参考上面的"当前状态"section重建
```

## 验证清单

推送完成后用以下方式确认：

1. 浏览器访问 https://github.com/xc106346/AcupointBook
2. 检查分支列表（应有 `master`）
3. 检查 tags（应有 `v0.2.1` 等）
4. 检查 `releases/` 目录是否有版本快照
5. 检查 `chapters/` 13 章目录是否齐全

## 仓库命名说明

- 旧仓库：`xc106346/Project`（已存在但不再使用）
- 新仓库：`xc106346/AcupointBook`（本草/穴位书专用）
- 本地文件夹仍叫 `Project`，不强制改名

## 后续约定

- 所有大版本（每章 Gold Standard 审校完成）打 tag：`v0.x.0`
- 小修小补直接 commit，不打 tag
- 推送频率：每完成一章审校后 push 一次
