irm https://claude.ai/install.ps1 | iex
# PowerShell 脚本 - 配置 Claude API

# 交互式输入
$API_KEY = Read-Host -Prompt "请输入你的 API Key"

if ([string]::IsNullOrWhiteSpace($API_KEY)) {
    Write-Host "错误：API Key 不能为空！" -ForegroundColor Red
    exit 1
}

Write-Host "请选择要配置的 API 服务："
Write-Host "1) DeepSeek (deepseek-v4-flash)"
Write-Host "2) MiniMax (MiniMax-M3)"
$choice = Read-Host -Prompt "请输入选项"

if ($choice -ne "1" -and $choice -ne "2") {
    Write-Host "错误：无效选项" -ForegroundColor Red
    exit 1
}

if ($choice -eq "1") {
    $BASE_URL = "https://api.deepseek.com/anthropic"
    $MODEL = "deepseek-v4-flash"
} else {
    $BASE_URL = "https://api.minimaxi.com/anthropic"
    $MODEL = "MiniMax-M3"
}

# Windows 路径
$CLAUDE_CONFIG_DIR = "$env:APPDATA\Claude"
$PROFILE_DIR = Split-Path $PROFILE

# 创建配置目录
New-Item -ItemType Directory -Force -Path $CLAUDE_CONFIG_DIR | Out-Null

# 写入 Claude 配置文件
$settings = @'
{
    "permissions": {
        "defaultMode": "bypassPermissions"
    }
}
'@
$settings | Out-File -FilePath "$CLAUDE_CONFIG_DIR\settings.json" -Encoding utf8

# 设置系统环境变量（永久生效）
[Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", $BASE_URL, "User")
[Environment]::SetEnvironmentVariable("ANTHROPIC_AUTH_TOKEN", $API_KEY, "User")
[Environment]::SetEnvironmentVariable("ANTHROPIC_MODEL", $MODEL, "User")

# 同时设置当前会话环境变量
$env:ANTHROPIC_BASE_URL = $BASE_URL
$env:ANTHROPIC_AUTH_TOKEN = $API_KEY
$env:ANTHROPIC_MODEL = $MODEL

Write-Host "✅ 配置完成！" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host "ANTHROPIC_BASE_URL: $BASE_URL"
Write-Host "ANTHROPIC_AUTH_TOKEN: $API_KEY"
Write-Host "ANTHROPIC_MODEL: $MODEL"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host ""
Write-Host "配置已保存到 Windows 用户环境变量（永久生效）" -ForegroundColor Yellow
Write-Host "Claude 配置已保存到: $CLAUDE_CONFIG_DIR\settings.json" -ForegroundColor Yellow
Write-Host ""
Write-Host "注意：环境变量已设置，但可能需要重启 PowerShell 才能在所有程序中生效" -ForegroundColor Cyan

# 运行 claude（如果安装了）
if (Get-Command claude -ErrorAction SilentlyContinue) {
    claude
} else {
    Write-Host "未找到 claude 命令，请确保已安装 Claude Desktop" -ForegroundColor Yellow
}
mkdir -Force ~/.claude
'{"permissions":{"defaultMode":"bypassPermissions"}}' | Out-File -FilePath ~/.claude/settings.json -Encoding utf8
claude
