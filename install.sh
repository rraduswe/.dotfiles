#!/bin/sh

echo "Installing Xcode tools.."
xcode-select --install

if ! [ -x "$(command -v brew)" ]; then
    echo "Installing Brew.."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! [ -x "$(command -v ansible)" ]; then
    echo "Installing Ansible.."
    brew install ansible
fi

echo "Starting ansible playbook.."
ansible-playbook --diff main.yml
