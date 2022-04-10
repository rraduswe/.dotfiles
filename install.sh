#!/bin/bash

echo "Installing Xcode tools.."
xcode-select --install

echo "Installing brew.."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle

echo "Installing oh-my-zsh.."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

source ~/.zshrc

echo "Installing Tmux plugin manager.."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing Tmux plugins.."
~/.tmux/plugins/tpm/bin/install_plugins

echo "Installing GO dependencies.."
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.45.2

echo "Installing Node.js dependencies.."
nvm install --lts
npm install -g typescript typescript-language-server vscode-langservers-extracted @tailwindcss/language-server

echo "Creating Neovim undodir, lsp and dap folders.."
mkdir ~/.config/nvim/undodir
mkdir ~/.config/nvim/lsp
mkdir ~/.config/nvim/dap

echo "Installing vscode GO debug adapter.."
git clone https://github.com/golang/vscode-go ~/.config/nvim/dap/vscode-go
(cd ~/.config/nvim/dap/vscode-go && npm install && npm run compile)

echo "Installing vscode Node.js debug adapter.."
git clone https://github.com/microsoft/vscode-node-debug2.git ~/.config/nvim/dap/vscode-node-debug2
(cd ~/.config/nvim/dap/vscode-node-debug2 && npm install && npm run build)

echo "Installing OmniSharp.."
curl -L https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.38.2/omnisharp-osx-x64-net6.0.tar.gz --output ~/.config/nvim/lsp/omnisharp/omnisharp.tar.gz
tar -xvf ~/.config/nvim/lsp/omnisharp/omnisharp.tar.gz -C ~/.config/nvim/lsp/omnisharp/ --strip=1
find ~/.config/nvim/lsp/omnisharp | xargs xattr -r -d com.apple.quarantine

echo "Installing .NET debugger.."
curl -L https://github.com/Samsung/netcoredbg/releases/download/2.0.0-895/netcoredbg-osx-amd64.tar.gz --output ~/.config/nvim/dap/netcoredbg/netcoredbg.tar.gz
tar -xvf ~/.config/nvim/dap/netcoredbg/netcoredbg.tar.gz -C ~/.config/nvim/dap/netcoredbg/ --strip=1

echo "Installing JDTLS.."
git clone https://github.com/eclipse/eclipse.jdt.ls ~/.config/nvim/lsp/jdtls
(cd ~/.config/nvim/lsp/jdtls && ./mvnw clean install -DskipTests)

echo "Installing Java decompiler.."
git clone https://github.com/dgileadi/vscode-java-decompiler ~/.config/nvim/lsp/jdtls/vscode-java-decompiler

echo "Installing Java debugger.."
git clone https://github.com/microsoft/java-debug ~/.config/nvim/lsp/jdtls/java-debug
(cd ~/.config/nvim/lsp/jdtls/java-debug && ./mvnw clean install)

echo "Installing Java test runner.."
git clone https://github.com/microsoft/vscode-java-test ~/.config/nvim/lsp/jdtls/vscode-java-test
(cd ~/.config/nvim/lsp/jdtls/vscode-java-test && npm install && npm run build-plugin)
