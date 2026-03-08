#!/bin/bash

# ====================== 第一步: 检测并安装 Homebrew =======================
echo -e "\n======================================================================"
echo -e "🍺 检测/安装 Homebrew 包管理器"
echo -e "======================================================================\n"

# 检测 Homebrew 是否已安装
if command -v brew > /dev/null 2>&1; then
    echo "✅ 检测到 Homebrew 已安装, 跳过安装步骤"
else
    echo -e "ℹ️  未检测到 Homebrew, 开始自动安装..."
    # 执行 Homebrew 官方安装脚本
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # 安装完成后, 自动配置 Homebrew 到 PATH(适配 Apple Silicon/Intel)
    if [ "$(uname -m)" = "arm64" ]; then
        # M1/M2/M3/M4 架构(你的 M4 Pro)
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        # Intel 架构(兼容)
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    
    echo "✅ Homebrew 安装并配置完成, 已添加到 PATH"
fi

# ====================== 第二步: 通过 Homebrew 安装工具 ======================
echo -e "\n======================================================================"
echo -e "📦 开始初始化 Homebrew 环境(安装开发工具/应用)"
echo -e "======================================================================\n"

# 1. 更新 Homebrew 包索引
echo -e "🔄 第一步: 更新 Homebrew 包索引..."
brew update
echo "✅ Homebrew 索引更新完成"

# 2. 升级已安装的包
echo -e "\n🔄 第二步: 升级已安装的 Homebrew 包..."
brew upgrade
echo "✅ Homebrew 包升级完成"

# 3. 初步清理缓存
echo -e "\n🧹 第三步: 清理 Homebrew 旧缓存..."
brew cleanup
echo "✅ Homebrew 缓存初步清理完成"

# 4. 安装常用开发工具(Formula)
echo -e "\n📥 第五步: 安装常用开发工具(Formula)..."
echo -e "   - 安装 OpenClaw..."
brew install openclaw-cli || true
echo "✅ 开发工具(Formula)安装完成"

# 5. 安装常用开发工具(Cask 应用, 移除 VS Code)
echo -e "\n📥 第四步: 安装常用开发应用(Cask)..."
echo -e "   - 安装 Chrome..."
brew install --cask google-chrome || true
echo -e "   - 安装 飞书..."
brew install --cask feishu || true
echo -e "   - 安装 iTerm2..."
brew install --cask iterm2 || true
echo -e "   - 安装 TRAE..."
brew install --cask trae || true
echo "✅ 开发应用(Cask)安装完成"


# 6. 深度清理 Homebrew 缓存
echo -e "\n🧹 第六步: 深度清理 Homebrew 缓存..."
brew cleanup
brew cleanup -s
echo "✅ Homebrew 缓存深度清理完成"

# 7. 自动移除无用依赖
echo -e "\n🧹 第七步: 自动移除无用依赖..."
brew autoremove
echo "✅ Homebrew 无用依赖清理完成"

echo -e "\n======================================================================"
echo -e "✅ Homebrew 环境初始化完成"
echo -e "======================================================================\n"



# Oh My Zsh
echo -e "\n📥 第八步: 安装 Oh My Zsh..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"



