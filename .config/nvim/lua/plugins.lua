require("lazy").setup({

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 35 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
        tab = {
          sync = {
            open = true,
            close = true,
          }
        }
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('telescope').setup({
        pickers = {
          buffers = {
            mappings = {
              n = {
                ["d"] = require("telescope.actions").delete_buffer,
              },
            }
          }
        }
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = { "lua", "vim", "vimdoc" },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = { enable = true },
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
      })
    end,
  },

  { "neovim/nvim-lspconfig" },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        enabled = function()
            return vim.fn.expand("%:t") ~= "daybook"
        end,
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })

      -- Restrict to structural pairs only for Lisp-like files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scheme", "racket", "lisp" },
        callback = function()
          local Rule = require("nvim-autopairs.rule")
          local npairs = require("nvim-autopairs")
          npairs.clear_rules()
          npairs.add_rules({
            Rule("(", ")"),
            Rule("[", "]"),
            Rule("{", "}"),
            Rule('"', '"'),
          })
        end,
      })
    end,
  },

  { "jgdavey/tslime.vim" },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
    vim.cmd("colorscheme kanagawa-dragon")
--    vim.cmd("colorscheme kanagawa-lotus")
    end,
  },

  {
    "rmagatti/auto-session",
    config = function()
    require("auto-session").setup({
      post_restore_cmds = {
        function()
          if vim.fn.getcwd() == vim.fn.expand("~/notes") then
            vim.cmd("edit ~/notes/daybook")
          elseif vim.fn.getcwd() == vim.fn.expand("~/projects/sicp/work") then
            vim.cmd("edit ~/projects/sicp/work/notes.rkt")
          end
        end
      },
      pre_save_cmds = {
        function()
          local bufs = vim.api.nvim_list_bufs()
          for _, buf in ipairs(bufs) do
            if vim.bo[buf].filetype == "NvimTree" or vim.bo[buf].buftype == "terminal" then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
        end
      },
    })
    end,
  },

})
