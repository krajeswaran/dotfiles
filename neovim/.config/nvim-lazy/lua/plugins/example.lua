-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

local isEditor = function()
  return os.getenv("TERMPURPOSE") == "editor"
end

return {
  -- disable trouble
  { "folke/trouble.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "goolord/alpha-nvim", enabled = false },
  { "folke/persistence.nvim", enabled = false },
  { "dstein64/vim-startuptime", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  { "SmiteshP/nvim-navic", enabled = false },
  { "folke/flash.nvim", enabled = false },
  { "ggandor/leap.nvim", enabled = false },

  -- project mainily for yarn workspaces
  {
    "ahmedkhalf/project.nvim",
    lazy = true,
    opts = { ignore_lsp = { "null-ls" } },
  },

  -- themes
  { "pgdouyon/vim-yin-yang", enabled = isEditor() },

  -- git signs not in editor mode
  {
    "lewis6991/gitsigns.nvim",
    enabled = not isEditor(),
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_gunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
          map("v", "<leader>gs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)
          map("v", "<leader>gr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)
          map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>gb", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame line" })
          map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
          map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
          map("n", "<leader>gD", function()
            gs.diffthis("~")
          end, { desc = "Diff buffer" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",

    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util")

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          section_separators = "",
          component_separators = "",
          disabled_filetypes = { statusline = { "taskpaper", "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = {
            { "filename", path = 0, symbols = { modified = "  ", readonly = "", unnamed = "" }, color = "LineNr" },
          },
          lualine_b = { { "branch", color = "LineNr" } },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
          lualine_x = {
            -- stylua: ignore
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 }, color = 'LineNr' },
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = Util.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.fg("Debug"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 }, color = "LineNr" },
          },
          lualine_z = {
            { "location", padding = { left = 0, right = 1 }, color = "LineNr" },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
  -- override nvim-cmp and add cmp-emojiex
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    --@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  -- noice
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            ["not"] = { kind = { "confirm", "confirm_sub" } },
          },
          opts = { view = true },
        },
      },
    },
  },
  -- undotree
  { "simnalamburt/vim-mundo", cmd = "MundoToggle" },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        '<leader>n',
        "<cmd>lua require('telescope.builtin').find_files({cwd='~/notes'})<CR>",
        desc = "Search notes"
      },
      {
        "<leader>C",
        "[[:e $MYVIMRC <CR>]]",
        desc = "Edit config",
      },
      {
        "<leader>o",
        "<cmd>Telescope find_files<cr>",
        desc = "Project files",
      },
      { "<leader>p", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      {
        "<leader>k",
        "<cmd>lua require('telescope.builtin').help_tags()<CR>",
        desc = "Search help tags",
      },
      {
        "z=",
        "<cmd>lua require('telescope.builtin').spell_suggest()<CR>",
        desc = "Spelling suggestions",
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "prettierd",
        "eslint_d",
        "autopep8",
        "black",
        "fixjson",
        "goimports",
        "yamlfmt",
        "actionlint",
        "golangci-lint",
        "textlint",
        "vale",
        "css-lsp",
        "dockerfile-language-server",
        "golangci-lint-langserver",
        "gopls",
        "grammarly-languageserver",
        "html-lsp",
        "json-lsp",
        "marksman",
        "pyright",
        "sqlls",
        "svelte-language-server",
        "typescript-language-server",
        "chrome-debug-adapter",
        "delve",
        "json-to-struct",
        "go-debug-adapter",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewFileHistory", "DiffviewOpen" },
    lazy = true,
  },
  {
    "rest-nvim/rest.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.keymap.set("n", "<Leader>ht", "<Plug>RestNvim<CR>", { desc = "Execute RestNvim" })
    end,
  },
  { "samoshkin/vim-mergetool" },
  {
    "junegunn/goyo.vim",
    cmd = "Goyo",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    enabled = isEditor(),
  },
  {
    "Wansmer/treesj",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter" },
    config = function()
      require("treesj").setup({ --[[ your config ]]
      })
    end,
  },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surroundng
        replace = "sr", -- Replace surroundng
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },

  {
    "krajeswaran/taskpaper.vim",
    lazy = true,

    event = { "BufReadPre", "BufNewFile" },
    ft = { "markdown", "taskpaper" },
    cond = isEditor,
  },
  {
    "uga-rosa/cmp-dictionary",
    cond = isEditor,
    config = function()
      require("cmp_dictionary").setup({
        dic = {
          ["*"] = { "/usr/share/dict/words" },
          spelllang = { en = "/usr/share/hunspell/en_US.dic" },
        },
      })
    end,
  }, -- coding
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local luasnip = require("luasnip")
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_next_item()
  --           -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
  --           -- this way you will only jump inside the snippet region
  --         elseif luasnip.expand_or_jumpable() then
  --           luasnip.expand_or_jump()
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif luasnip.jumpable(-1) then
  --           luasnip.jump(-1)
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --   end,
  -- },
}
