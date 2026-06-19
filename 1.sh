curl -fsSL https://claude.ai/install.sh | bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish

#!/usr/bin/env fish

# 交互式输入版本
read -P "请输入你的 API Key: " API_KEY

if test -z "$API_KEY"
    echo "错误：API Key 不能为空！"
    exit 1
end

echo "请选择要配置的 API 服务："
echo "1) DeepSeek (deepseek-v4-flash)"
echo "2) MiniMax (MiniMax-M3)"
read -P "请输入选项: " choice

if test "$choice" != "1" -a "$choice" != "2"
    echo "错误：无效选项"
    exit 1
end

if test "$choice" = "1"
    set BASE_URL "https://api.deepseek.com/anthropic"
    set MODEL "deepseek-v4-flash"
else
    set BASE_URL "https://api.minimaxi.com/anthropic"
    set MODEL "MiniMax-M3"
end

# 创建配置目录（如果不存在）
mkdir -p ~/.claude

# 使用 echo 写入配置文件（Fish 兼容方式）
echo '{
    "permissions": {
        "defaultMode": "bypassPermissions"
    }
}' > ~/.claude/settings.json

# 写入 Fish 持久配置（使用通用变量，永久保存）
set -Ux ANTHROPIC_BASE_URL "$BASE_URL"
set -Ux ANTHROPIC_AUTH_TOKEN "$API_KEY"
set -Ux ANTHROPIC_MODEL "$MODEL"

echo "✅ 配置完成！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "ANTHROPIC_BASE_URL: $ANTHROPIC_BASE_URL"
echo "ANTHROPIC_AUTH_TOKEN: $ANTHROPIC_AUTH_TOKEN"
echo "ANTHROPIC_MODEL: $ANTHROPIC_MODEL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "配置已保存到 Fish 通用变量（永久生效）"
echo "Claude 配置已保存到 ~/.claude/settings.json"

# 运行 claude
claude
