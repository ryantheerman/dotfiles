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
        border = false,
        defaults = {
          mappings = {
            i = {
              ["<Tab>"] = require("telescope.actions").move_selection_previous,
              ["<S-Tab>"] = require("telescope.actions").move_selection_next,
            },
            n = {
              ["<Tab>"] = require("telescope.actions").move_selection_previous,
              ["<S-Tab>"] = require("telescope.actions").move_selection_next,
            },
          }
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
          },
          buffers = {
            mappings = {
              n = {
                ["x"] = require("telescope.actions").delete_buffer,
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
      -- applies to all LSP servers
      vim.lsp.config('*', {
        on_attach = function(client, bufnr)
          vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buffer = bufnr })
          vim.keymap.set('n', 'K', 'N', { noremap = true, buffer = bufnr })
        end
      })
      vim.lsp.config('lua_ls', {
        root_dir = function(fname)
          return vim.fs.root(fname, { '.luarc.json', '.luarc.jsonc', 'lua', '.git' })
        end
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
--    vim.cmd("colorscheme kanagawa-dragon")
--    vim.cmd("colorscheme kanagawa-lotus")
    end,
  },

  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      vim.opt.termguicolors = true
      vim.cmd('colorscheme bluloco-dark')
      -- your optional config goes here, see below.
      -- use these to switch the colorscheme at runtime
        -- :colorscheme bluloco-dark
        -- :colorscheme bluloco-light
    end,
  },

  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
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

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,  -- ms after prefix before popup appears
      spec = {
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        -- add others as you build them out
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▁" },
        topdelete    = { text = "▔" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(l, r, desc)
          vim.keymap.set("n", l, r, { buffer = bufnr, desc = desc })
        end
  
        map("]h", gs.next_hunk,       "Next hunk")
        map("[h", gs.prev_hunk,       "Prev hunk")
        map("<leader>gs", gs.stage_hunk,      "Git stage hunk")
        map("<leader>gr", gs.reset_hunk,      "Git reset hunk")
        map("<leader>gS", gs.stage_buffer,    "Git stage buffer")
        map("<leader>gu", gs.undo_stage_hunk, "Git undo stage")
        map("<leader>gv", gs.preview_hunk,    "Git preview hunk")
      end,
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", function()
          if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewClose")
          end
        end, desc = "Git diff toggle" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git file history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Git repo history" },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
--        theme = "auto",

        theme = function()
          local theme = require("lualine.themes.auto")
          theme.normal.a  = { bg = "#4a9e4e", fg = "#000000" }
          theme.command.a = { bg = "#4fc1ff", fg = "#000000" }
          return theme
        end,

        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "filename" },
        lualine_c = {
          {
            function()
              local reg = vim.fn.reg_recording()
              if reg ~= "" then return "recording @" .. reg end
              return ""
            end,
          },
          {
            function()
              local ok, sc = pcall(vim.fn.searchcount, { recompute = true })
              if not ok or sc.total == 0 then return "" end
              if sc.incomplete == 1 then return "?/?" end
              return sc.current .. "/" .. sc.total
            end,
          },
          {
            function() return vim.g.yank_msg or "" end,
          },
          {
            "%S"
          },
        },
        lualine_x = {},
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },
    },
  },

})
