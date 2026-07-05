# build.ps1 — 构建脚本
# 生成 EPUB3、DOCX、PDF 输出

$ErrorActionPreference = "Stop"

$ProjectRoot = "G:\中医文库\Project"
Set-Location $ProjectRoot

$OutputDir = Join-Path $ProjectRoot "output"
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

# 合并所有章节为一个文件（用于 pandoc 构建）
$AllChapters = @(
    "chapters/_TEMPLATE.md",
    "chapters/01 肝经.md",
    "chapters/02 胆经.md",
    "chapters/03 心经.md",
    "chapters/04 小肠经.md",
    "chapters/05 脾经.md",
    "chapters/06 胃经.md",
    "chapters/07 肺经.md",
    "chapters/08 大肠经.md",
    "chapters/09 肾经.md",
    "chapters/10 膀胱经.md",
    "chapters/11 心包经.md",
    "chapters/12 三焦经.md",
    "chapters/13 附录.md"
)

# 过滤存在的文件
$ExistingChapters = $AllChapters | Where-Object { Test-Path $_ }
Write-Output "构建文件列表（共 $($ExistingChapters.Count) 个章节）"

# EPUB3
$EPUB = Join-Path $OutputDir "五输穴与原穴经典汇编.epub"
Write-Output "正在生成 EPUB3 ..."
pandoc $ExistingChapters `
    -o $EPUB `
    --epub-chapter-level=2 `
    --epub-metadata="metadata.xml" `
    --wrap=preserve `
    -s
Write-Output "完成: $EPUB"

# DOCX
$DOCX = Join-Path $OutputDir "五输穴与原穴经典汇编.docx"
Write-Output "正在生成 DOCX ..."
pandoc $ExistingChapters `
    -o $DOCX `
    --reference-doc="template.docx" `
    --wrap=preserve
Write-Output "完成: $DOCX"

# PDF（xelatex）
$PDF = Join-Path $OutputDir "五输穴与原穴经典汇编.pdf"
Write-Output "正在生成 PDF ..."
pandoc $ExistingChapters `
    -o $PDF `
    --pdf-engine=xelatex `
    -V mainfont="SimSun" `
    -V geometry:"top=2.5cm, bottom=2.5cm, left=3cm, right=2cm" `
    --wrap=preserve
Write-Output "完成: $PDF"

# 输出文件大小
Write-Output "`n输出文件："
foreach ($f in @($EPUB, $DOCX, $PDF)) {
    if (Test-Path $f) {
        $size = (Get-Item $f).Length / 1MB
        Write-Output "  $(Split-Path $f -Leaf) - $([math]::Round($size, 2)) MB"
    }
}

Write-Output "`n构建完成。"
