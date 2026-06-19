curl -fsSL https://claude.ai/install.sh | bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
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

# 导出为环境变量（Fish 语法）
set -x API_KEY "$API_KEY"
set -x BASE_URL "$BASE_URL"
set -x MODEL "$MODEL"

echo "✅ 配置完成！"
echo "API: $BASE_URL"
echo "Model: $MODEL"
