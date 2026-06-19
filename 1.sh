curl -fsSL https://claude.ai/install.sh | bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.config/fish/config.fish && source
    ~/.config/fish/config.fish
read -p "请输入你的 API Key: " API_KEY

if [ -z "$API_KEY" ]; then
    echo "错误：API Key 不能为空！"
    exit 1
fi

echo "1) DeepSeek (deepseek-v4-flash)"
read -p "请输入选项: " choice

if [ "$choice" != "1" ]; then
    echo "错误：无效选项"
    exit 1
fi

if [ "$choice" = "1" ]; then
    BASE_URL="https://api.deepseek.com/anthropic"
    MODEL="deepseek-v4-flash"
fi
