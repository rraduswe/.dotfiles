local M = {}

local function packer_verify()
  local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.api.nvim_command "packadd packer.nvim"
  end
end

local function packer_setup()
    local packer = require("packer")
    packer.init()
    packer.startup(function(use)
    	use "wbthomason/packer.nvim"

        use {
            "folke/tokyonight.nvim",
            config = function()
                local theme = require("plugins.theme")
                theme.init()
            end
        }

        use {
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = function()
                local lualine = require("plugins.lualine")
                lualine.init()
            end
        }
    
    	use {
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons"
            },
            config = function()
		        local tree = require("plugins.tree")
		        tree.init()
            end
        } 

        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make"
        }
        use {
            "nvim-telescope/telescope-fzy-native.nvim"
        }
	    use {
  	        "nvim-telescope/telescope.nvim",
            requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
	        config = function()
		        local telescope = require("plugins.telescope")
		        telescope.init()
	        end
   	    }

	    use {
	        "mbbill/undotree",
	        config = function()
		        local undotree = require("plugins.undotree")
		        undotree.init()
	        end
        }

        use {
            "windwp/nvim-autopairs",
            config = function()
                local autopairs = require("plugins.autopairs")
                autopairs.init()
            end
        }

	    use { "neovim/nvim-lspconfig", event = "BufRead" }
        use { "hrsh7th/cmp-nvim-lsp" }
	    use {
	        "tzachar/cmp-tabnine",
	        run = "./install.sh",
	        after = "nvim-cmp",
	        config = function()
		        local tabnine = require("plugins.tabnine")
		        tabnine.init()
	        end
        }
    	use {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter *",
            config = function()
		        local cmp = require("plugins.cmp")
		        cmp.init()

                local lsp = require("plugins.lsp")
                lsp.init()
            end
        }
        use { "hrsh7th/cmp-path", after = "nvim-cmp" }
	    use { "hrsh7th/cmp-vsnip", after = "nvim-cmp" }
	    use { "hrsh7th/vim-vsnip", after = "nvim-cmp" }
        use {
            "mfussenegger/nvim-jdtls",
            config = function()
                local jdtls = require("plugins.jdtls")
                jdtls.init()
            end
        }
        use { "rafamadriz/friendly-snippets" }

        use {
            "rinx/lspsaga.nvim",
            config = function()
                local saga = require("plugins.saga")
                saga.init()
            end
        }
        use { "onsails/lspkind-nvim" }
        use {
            "RishabhRD/nvim-lsputils",
            requires = { "RishabhRD/popfix" }
        }
        use { "ray-x/lsp_signature.nvim" }

        use {
            "mfussenegger/nvim-dap",
            config = function()
                local dap = require("plugins.dap")
                dap.init()
            end
        }
        use { "theHamsta/nvim-dap-virtual-text" }
        use {
            "rcarriga/nvim-dap-ui",
            requires = { "mfussenegger/nvim-dap" },
            config = function()
                local dapui = require("plugins.dapui")
                dapui.init()
            end
        }

        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufWinEnter",
            run = ":TSUpdate",
            config = function()
                local treesitter = require("plugins.treesitter")
                treesitter.init()
            end
        }
        use {
            "p00f/nvim-ts-rainbow",
            after = "nvim-treesitter"
        }
        use {
            "windwp/nvim-ts-autotag",
            after = "nvim-treesitter"
        }

        use {
            "b3nj5m1n/kommentary",
            config = function()
                local kommentary = require("plugins.kommentary")
                kommentary.init()
            end
        }

        use {
            "mhartington/formatter.nvim",
            config = function()
                local formatter = require("plugins.formatter")
                formatter.init()
            end
        }

        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                local indent = require("plugins.indent")
                indent.init()
            end
        }

        use {
            "editorconfig/editorconfig-vim",
            config = function()
                local editorconfig  = require("plugins.editorconfig")
                editorconfig.init()
            end
        }
    end)
end

function M.init()
    packer_verify()
    packer_setup()
end

return M
