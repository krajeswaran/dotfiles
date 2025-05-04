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
  { "folke/persistence.nvim", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  { "folke/flash.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      indent = { enabled = false },
      words = { enabled = false },
      terminal = { enabled = true },
      picker = { enabled = true },
    },
    keys = {},
  },

  -- project mainily for yarn workspaces
  -- {
  --   "ahmedkhalf/project.nvim",
  --   lazy = true,
  --   config = function()
  --     require("project_nvim").setup({
  --       patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "project.clj" },
  --       ignore_lsp = { "tsserver", "eslint" },
  --     })
  --   end,
  -- },

  -- -- tsserver bullshit
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       ts_ls = {
  --         enabled = false,
  --         root_dir = require("lspconfig").util.root_pattern(".git"),
  --       },
  --     },
  --   },
  -- },

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

  -- -- status line
  {
    "nvim-lualine/lualine.nvim",

    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons

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
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
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
  -- noice
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        -- {
        --   filter = {
        --     event = "msg_show",
        --     ["not"] = { kind = { "confirm", "confirm_sub" } },
        --   },
        --   opts = { view = true },
        -- },
        {
          -- Disable messages
          opts = { skip = true },
          filter = {
            any = {
              { event = "msg_show", find = "%d+B written$" },
              { event = "msg_show", find = "%-%-No lines in buffer%-%-" },
              { event = "msg_show", find = "No more valid diagnostics to move to" },
              { event = "msg_show", find = "^%[nvim%-treesitter%]" },
              { event = "msg_show", find = "fewer lines$" },
              { event = "msg_show", find = "^E486:" },
              { event = "msg_show", find = "^/" },
              { event = "notify", find = "^Codeium*completion" },
              { event = "notify", find = "^codeium/codeium.log*" },
              { event = "notify", find = "All parsers are up%-to%-date" },
              { event = "msg_show", find = "%d+ lines, %d+ bytes" },
              { event = "msg_show", find = "%d+L, %d+B" },
              { event = "msg_show", find = "^Hunk %d+ of %d" },
              { event = "msg_show", find = "%d+ change" },
              { event = "msg_show", find = "%d+ line" },
              { event = "msg_show", find = "%d+ more line" },
              { event = "notify", find = "completion request failed" }, -- Codeium
              { event = "notify", find = "No information available" }, -- Hover doc
            },
          },
        },
      },
    },
  },

  -- blink
  {
    "saghen/blink.cmp",
    dependencies = {
      "moyiz/blink-emoji.nvim",
      {
        "Kaiser-Yang/blink-cmp-dictionary",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    opts = {

      -- experimental signature help support
      -- signature = { enabled = true },
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        default = function()
          if isEditor() then
            return { "lsp", "path", "buffer", "dictionary", "emoji" }
          else
            return { "lsp", "path", "buffer", "snippets", "emoji" }
          end
        end,
        cmdline = {},
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15, -- Tune by preference
            opts = { insert = true }, -- Insert emoji (default) or complete its name
          },
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            -- Make sure this is at least 2.
            -- 3 is recommended
            min_keyword_length = 3,
            opts = {
              dictionary_files = { vim.fn.expand("/usr/share/dict/words") },
              -- options for blink-cmp-dictionary
            },
          },
        },
      },

      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },

  -- fzf-lua override default mapping
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", vim.NIL },
    },
  },

  -- undotree
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>z", "<cmd>lua require('undotree').toggle()<cr>", desc = "Undo tree" },
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
        "fixjson",
        "debugpy",
        "js-debug-adapter",
        "node-debug2-adapter",
        "chrome-debug-adapter",
        "yamlfmt",
        "ruff",
        "textlint",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "yaml-language-server",
        "marksman",
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
  -- Mason-nvim-dap
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      ensure_installed = {
        "python",
        "delve",
        "js",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*]],
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = { "DapContinue", "DapLoadLaunchJSON" },
    config = function()
      local dap = require("dap")
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }
      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }

      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            runtimeExecutable = "tsx",
            args = { "${file}" },
            sourceMaps = true,
            cwd = "${workspaceFolder}/src",
            protocol = "inspector",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            resolveSourceMapLocations = {
              "${workspaceFolder}/src/**",
              "!**/node_modules/**",
            },
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            restart = true,
            sourceMaps = true,
            webRoot = "${workspaceFolder}/src",
            outDir = "${workspaceFolder}/dist",
            -- cwd = "${workspaceFolder}/src",
            -- protocol = "inspector",
            -- localRoot = "${workspaceFolder}/src",
            -- remoteRoot = "/home/kumaresan/src/tange-server/",
            -- outFiles = { "${workspaceFolder}/dist/**/**/*", "!**/node_modules/**" },
            -- resolveSourceMapLocations = {
            --   "${workspaceFolder}/src/**",
            --   "!**/node_modules/**",
            -- },
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Start Chrome on port",
            url = function()
              local port = vim.fn.input({
                prompt = "Port ",
                completion = "file",
              })
              return "http://localhost:3000" .. port
            end,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}/src",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            sourceMaps = true,
            cwd = "${workspaceFolder}/src",
            resolveSourceMapLocations = {
              "${workspaceFolder}/src/**",
              "!**/node_modules/**",
            },
          },
        }
      end
    end,
  },
  -- {
  --   "stevearc/overseer.nvim",
  --   cmd = {
  --     "OverseerRun",
  --     "OverseerRunCmd",
  --     "OverseerToggle",
  --   },
  -- },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "angular", "svelte" },
  --   opts = {},
  -- },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "biome-check" },
        javascriptreact = { "biome-check" },
        typescript = { "biome-check" },
        typescriptreact = { "biome-check" },
      },
    },
  },
  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   ft = { "python", "golang", "typescript", "typescriptreact", "javascript", "javascriptreact", "angular", "svelte" },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  -- },
  { "samoshkin/vim-mergetool", cmd = "MergetoolStart", lazy = false },
  {
    "folke/zen-mode.nvim",
    -- lazy = true,
    -- event = { "BufReadPre", "BufNewFile" },
    -- enabled = isEditor(),
    opts = {
      window = {
        backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 75, -- width of the Zen window
        height = 0.9, -- height of the Zen window
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },
        gitsigns = { enabled = false }, -- disables git signs
      },
    },
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
    "krajeswaran/taskpaper.vim",
    lazy = true,

    event = { "BufReadPre", "BufNewFile" },
    ft = { "markdown", "taskpaper" },
    cond = isEditor,
  },
}
