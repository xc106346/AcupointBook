# backup.ps1 — 备份与推送脚本

$ErrorActionPreference = "Stop"

$ProjectRoot = "G:\中医文库\Project"
Set-Location $ProjectRoot

# 检查 Git 状态
if (-not (Test-Path ".git")) {
    Write-Output "[ERROR] Git 未初始化，请先运行 git init"
    exit 1
}

$status = git status --porcelain
if ($status.Count -eq 0) {
    Write-Output "[INFO] 没有需要提交的更改。"
    exit 0
}

Write-Output "检测到 $($status.Count) 个文件变更："
$status | ForEach-Object { Write-Output "  $_" }

# Stage 所有文件
Write-Output "`n正在 git add ..."
git add .

# 读取上次 commit 信息作为默认消息参考
$lastMsg = git log -1 --pretty=%B 2>$null
if ($lastMsg) {
    Write-Output "上次提交: $lastMsg"
}

# 自动生成 commit 消息（时间戳 + 文件变更数）
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
$changedFiles = $status.Count
$autoMsg = "chore: $($timestamp) 更新 ($changedFiles 文件)"

Write-Output "`nCommit 消息: $autoMsg"
git commit -m $autoMsg

# 推送到远程
Write-Output "`n正在 git push ..."
$pushResult = git push 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Output "推送成功: $pushResult"
} else {
    Write-Output "[WARN] 推送失败: $pushResult"
    Write-Output "[INFO] 请检查网络或远程仓库配置。"
}

Write-Output "`n备份完成。"
