local fn = vim.fn

local data_path = fn.stdpath("data")
local install_path = data_path.."/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    })
    vim.cmd("packadd packer.nvim")
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

local function get_config(file_name)
    return string.format('require("plugins/%s")', file_name)
end

return packer.startup({
    function(use)
        use { "wbthomason/packer.nvim" }

        use {
            "folke/tokyonight.nvim",
            config = get_config("theme"),
        }

        use {
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = get_config('lualine'),
        }

        use {
            "lukas-reineke/indent-blankline.nvim",
            config = get_config("indent"),
        }

        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            requires = {
                "p00f/nvim-ts-rainbow",
                "windwp/nvim-ts-autotag",
            },
            config = get_config("treesitter"),
        }

        use {
          "mhartington/formatter.nvim",
          config = get_config('formatter'),
        }

        use {
            "mbbill/undotree",
            config = get_config('undotree'),
        }

        use {
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons"
            },
            config = get_config("tree"),
        }

        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim",
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    run = 'make'
                },
                "nvim-telescope/telescope-fzy-native.nvim",
            },
            config = get_config('telescope'),
        }

        use {
            "windwp/nvim-autopairs",
            config = get_config("autopairs"),
        }

        use {
            "b3nj5m1n/kommentary",
            config = get_config("kommentary"),
        }

        use {
            "editorconfig/editorconfig-vim",
            config = get_config("editorconfig"),
        }

        use { "rafamadriz/friendly-snippets" }

        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "onsails/lspkind-nvim",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lsp-document-symbol",
                "hrsh7th/cmp-vsnip",
                "hrsh7th/vim-vsnip",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
            config = get_config("cmp"),
        }

        use {
            "ray-x/lsp_signature.nvim",
        }

        use { 'neovim/nvim-lspconfig',
            config = get_config('lsp'),
        }

        use {
            "mfussenegger/nvim-jdtls",
            requires = {
                "RishabhRD/nvim-lsputils",
                requires = {
                    "RishabhRD/popfix"
                }
            },
            config = get_config('jdtls'),
        }

        use {
            "glepnir/lspsaga.nvim",
            branch = "main",
            config = get_config("lspsaga"),
        }

        use {
            "mfussenegger/nvim-dap",
            requires = {
                "rcarriga/nvim-dap-ui",
                "theHamsta/nvim-dap-virtual-text",
            },
            config = get_config("dap"),
        }

        if packer_bootstrap then
            packer.sync()
        end
    end
})
