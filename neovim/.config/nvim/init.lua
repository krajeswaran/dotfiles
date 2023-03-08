-- pre-requisites
-- Mason it or yarn global add typescript bash-language-server sql-language-server @fsouza/prettierd typescript-language-server vscode-langservers-extracted
--TODO debug mode

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local isEditor = function() 
    return os.getenv("TERMPURPOSE") == "editor"
end

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    '--depth=1',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "matchparen",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "remote_plugins",
        "zip",
        "zipPlugin",
      },
    },
  },

  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "habamax" },
  },

  spec = {

    { "folke/lazy.nvim", version = "*" },

    -- file explorer
    {
      "nvim-neo-tree/neo-tree.nvim",
      cmd = "Neotree",
      keys = {
        {
          "ge",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
      },
      deactivate = function()
        vim.cmd([[Neotree close]])
      end,
      init = function()
        vim.g.neo_tree_remove_legacy_commands = 1
        if vim.fn.argc() == 1 then
          local stat = vim.loop.fs_stat(vim.fn.argv(0))
          if stat and stat.type == "directory" then
            require("neo-tree")
          end
        end
      end,
      opts = {
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = true,
        },
        window = {
          mappings = {
            ["<space>"] = "none",
          },
        },
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
        },
      },
    },

    -- search/replace in multiple files
    {
      "windwp/nvim-spectre",
      -- stylua: ignore
      keys = {
        { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
      },
    },

    -- fuzzy finder
    {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
      },
      config = function()
        require("telescope").load_extension("undo")
        require("telescope").setup({
          extensions = {
            undo = {
              -- telescope-undo.nvim config, see below
            },
          },
          pickers = {
            -- Your special builtin config goes in here
            find_browser = {
              previewer = false,
            },
            oldfiles = {
              theme = "dropdown",
              previewer = false,
            },
            find_files = {
              theme = "dropdown",
              previewer = false,
            },
          },
        })
      end,
      version = false, -- telescope did only one release, so use HEAD for now
      keys = {
        { "<leader>b", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Files..." },
        { "<leader>o", "<cmd>Telescope find_files<cr>", desc = "Open..." },
        { "<leader>p", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        {'<leader>n', "<cmd>lua require('telescope.builtin').find_files({cwd='~/notes'})<CR>", desc = "Search notes" },
        {'<leader>k', "<cmd>lua require('telescope.builtin').help_tags()<CR>", desc = "Search help tags"},
        {'z=', "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", desc = "Spelling suggestions" },
        {
          "<leader>s", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", desc = "Goto Symbol (Workspace)",
        },
      },
      opts = {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            i = {
              ["<C-Down>"] = function(...)
                return require("telescope.actions").cycle_history_next(...)
              end,
              ["<C-Up>"] = function(...)
                return require("telescope.actions").cycle_history_prev(...)
              end,
              ["<C-f>"] = function(...)
                return require("telescope.actions").preview_scrolling_down(...)
              end,
              ["<C-b>"] = function(...)
                return require("telescope.actions").preview_scrolling_up(...)
              end,
            },
            n = {
              ["q"] = function(...)
                return require("telescope.actions").close(...)
              end,
            },
          },
        },
      },
    },

    -- git signs
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      lazy = true,
      cond = not isEditor(),
      opts = {
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          -- stylua: ignore start
          map("n", "]c", gs.next_hunk, "Next Change")
          map("n", "[c", gs.prev_hunk, "Prev Change")
          map({ "n", "v" }, "<leader>cs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>cr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>cS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>cu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>cR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>cp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>cb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>cd", gs.diffthis, "Diff This")
          map("n", "<leader>cD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
      },
    },

    -- treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      version = false, -- last release is way too old and doesn't work on Windows
      build = ":TSUpdate",
      event = { "BufReadPost", "BufNewFile" },
      dependencies = {
        {
          "nvim-treesitter/nvim-treesitter-textobjects",
        },
      },
      keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>", desc = "Decrement selection", mode = "x" },
      },
      ---@type TSConfig
      opts = {
        highlight = { enable = true },
        indent = { enable = true, disable = { "python" } },
        context_commentstring = { enable = true, enable_autocmd = false },
        matchup = {
          enable = true,
        },
        ensure_installed = {
          "bash",
          "c",
          "help",
          "http",
          "html",
          "go",
          "javascript",
          "json",
          "json5",
          "jsonc",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<nop>",
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
      },
      ---@param opts TSConfig
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,	
    },

    -- Better `vim.notify()`
    {
      "rcarriga/nvim-notify",
      keys = {
        {
          "<leader>un",
          function()
            require("notify").dismiss({ silent = true, pending = true })
          end,
          desc = "Delete all Notifications",
        },
      },
      opts = {
        timeout = 1000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
      },
    },

    -- better vim.ui
    {
      "stevearc/dressing.nvim",
      lazy = true,
      init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.input(...)
        end
      end,
    },

    -- indent guides for Neovim
    {
      "lukas-reineke/indent-blankline.nvim",
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        char = "│",
        filetype_exclude = { "mason", "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
        show_trailing_blankline_indent = false,
        show_current_context = false,
      },
    },

    -- active indent guide and indent text objects
    {
      "echasnovski/mini.indentscope",
      version = false, -- wait till new 0.7.0 release to put it back on semver
      event = { "BufReadPre", "BufNewFile" },
      opts = {
        -- symbol = "▏",
        symbol = "│",
        options = { try_as_border = true },
      },
      init = function()
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
          callback = function()
            vim.b.miniindentscope_disable = true
          end,
        })
      end,
      config = function(_, opts)
        require("mini.indentscope").setup(opts)
      end,
    },

    -- noicer ui
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
        routes = {
          {
            filter = { 
              event = "msg_show", 
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
          {
            view = "split",
            filter = { event = "msg_show", min_height = 20 },
          },
        },
      },
      -- stylua: ignore
      keys = {
        { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      },
    },

    -- LSP
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        {
          "b0o/SchemaStore.nvim",
          version = false, -- last release is way too old
        },
        {
          "jose-elias-alvarez/typescript.nvim"
        },
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'nvim-lua/lsp-status.nvim',
        "hrsh7th/cmp-nvim-lsp",
      },
      -- opts = {
      --   diagnostics = {
      --     underline = true,
      --     update_in_insert = false,
      --     virtual_text = { spacing = 4, prefix = "●" },
      --     severity_sort = true,
      --   },
      --   format = {
      --     formatting_options = nil,
      --     timeout_ms = nil,
      --   },
      --   -- make sure mason installs the server
      -- },
    },

    -- formatters
    {
      "jose-elias-alvarez/null-ls.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = { "mason.nvim" },
      opts = function()

        local nls = require("null-ls")
        if isEditor() then
          src = {
            -- completions
            -- null_ls.builtins.completion.spell,
            --null_ls.builtins.diagnostics.vale,

            -- formatting sources
            nls.builtins.formatting.autopep8, 
            nls.builtins.formatting.black, 
          } 
        else 
          src = {
            -- code action sources
            -- nls.builtins.code_actions.gitsigns,
            -- nls.builtins.code_actions.refactoring,
            nls.builtins.code_actions.eslint_d,

            -- completions
            -- nls.builtins.completion.spell,

            -- diagnostic sources
            -- nls.builtins.diagnostics.codespell, 
            -- nls.builtins.diagnostics.cppcheck, 
            nls.builtins.diagnostics.eslint_d, 
            nls.builtins.diagnostics.pylint, 
            nls.builtins.diagnostics.flake8, 
            -- nls.builtins.diagnostics.shellcheck, 

            -- formatting sources
            nls.builtins.formatting.autopep8, 
            nls.builtins.formatting.black, 
            -- nls.builtins.formatting.codespell, 
            -- nls.builtins.formatting.lua_format,
            nls.builtins.formatting.eslint_d,
            nls.builtins.formatting.prettierd.with({
              filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "scss", "less", "graphql", "handlebars" }
            }), 
            -- nls.builtins.formatting.shfmt, 
            nls.builtins.formatting.sqlformat, 
            nls.builtins.formatting.terraform_fmt, 
            -- nls.builtins.formatting.uncrustify, 
          }
        end

        return {
          sources = src,
          debug = false,

          on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({
                    filter = function(client)
                      return client.name == "null-ls"
                    end,
                    bufnr = bufnr,
                  })
                end,
              })
            end
          end,
        }

      end,
    },

    -- cmdline tools and lsp servers
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      opts = {
        ensure_installed = {
          "stylua",
          "flake8",
          "autopep8",
          "black",
          "fixjson",
          "goimports",
          "prettierd",
          "shfmt",
          "yamlfmt",
          "actionlint",
          "eslint_d",
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
          "sqls",
          "svelte-language-server",
          "typescript-language-server",
          "chrome-debug-adapter",
          "delve",
          "go-debug-adapter",
        },
        automatic_installation = true,
      },
    },

    -- snippets
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      opts = {
        history = true,
        delete_check_events = "TextChanged",
      },
      -- stylua: ignore
      keys = {
        {
          "<tab>",
          function()
            return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
          end,
          expr = true, silent = true, mode = "i",
        },
        { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
        { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
      },
    },

    -- auto completion
    {
      "hrsh7th/nvim-cmp",
      version = false, -- last release is way too old
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "saadparwaiz1/cmp_luasnip",
      },
      opts = function()
        local cmp = require("cmp")
        local LSP_KIND_SIGNS = {
          Class = " ",
          Color = " ",
          Constant = " ",
          Constructor = " ",
          Enum = "了 ",
          EnumMember = " ",
          Field = " ",
          File = " ",
          Folder = " ",
          Function = " ",
          Interface = "ﰮ ",
          Keyword = " ",
          Method = "ƒ ",
          Module = " ",
          Property = " ",
          Snippet = "﬌ ",
          Struct = " ",
          Text = " ",
          Unit = " ",
          Value = " ",
          Variable = " ",
        }

        local has_words_before = function()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
        end

        return {
          completion = {
            completeopt = "menu,menuone,noselect",
          },
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          mapping = {
            ['<C-Space>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            },

            ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.

            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),

            ['<CR>'] =  cmp.mapping(cmp.mapping.confirm { select = true }),
          },

          sources = cmp.config.sources({
            { name = 'nvim_lsp', priority=8, max_item_count = 25 },
            { name = "luasnip", priority=6 },
            { name = 'buffer', priority=7, keyword_length = 4},
            { name = "nvim_lsp_signature_help" },
            { name = 'path', priority=6, keyword_length = 4 },
            { name = 'dictionary', priority=6, keyword_length = 5 },
          }),

          formatting = {
            format = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = 'C',
                buffer   = 'B',
                path = 'P',
                snippet = 'S',
              })[entry.source.name]

              -- vim_item.kind = string.format("%s %s", LSP_KIND_SIGNS[vim_item.kind], vim_item.kind)
              vim_item.kind = LSP_KIND_SIGNS[vim_item.kind]
              return vim_item
            end
          },

          sorting = {
            comparators = {
              cmp.config.compare.offset,
              cmp.config.compare.exact,
              cmp.config.compare.score,
              cmp.config.compare.kind,
              cmp.config.compare.sort_text,
              cmp.config.compare.length,
              cmp.config.compare.order,
            },
          },

          experimental = {
            ghost_text = {
              hl_group = "LspCodeLens",
            },
          },

          -- Set configuration for specific filetype.
          cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
              { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
                { name = 'buffer' },
              })
          }),  

          -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
          cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = 'buffer' }
            }
          }),

          -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
          cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = 'path' }
            }, {
                { name = 'cmdline' }
              })
          })

        }
      end,
    },

    -- auto pairs
    {
      "echasnovski/mini.pairs",
      event = "VeryLazy",
      config = function(_, opts)
        require("mini.pairs").setup(opts)
      end,
    },

    -- comments
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = { "BufReadPre", "BufNewFile" },
      lazy = true,
    },
    {
      "echasnovski/mini.comment",
      event = "VeryLazy",
      opts = {
        hooks = {
          pre = function()
            require("ts_context_commentstring.internal").update_commentstring({})
          end,
        },
      },
      config = function(_, opts)
        require("mini.comment").setup(opts)
      end,
    },

    -- icons
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- ui components
    { "MunifTanjim/nui.nvim", lazy = true },

    -- surround
    {
      "kylechui/nvim-surround",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to  defaults
          keymaps = {
            normal = "sa",
            delete = "sd",
            change = "sr",
          },
        })
      end
    },

    -- debug
    {
      'mfussenegger/nvim-dap',
      lazy = true,
      event = "VeryLazy",
      dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Add your own debuggers here
        'leoluz/nvim-dap-go',
      },

      config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_setup = true,

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
            'delve',
          },
        }

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        require('mason-nvim-dap').setup_handlers()

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F5>', dap.continue)
        vim.keymap.set('n', '<F1>', dap.step_into)
        vim.keymap.set('n', '<F2>', dap.step_over)
        vim.keymap.set('n', '<F3>', dap.step_out)
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
        vim.keymap.set('n', '<leader>B', function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end)

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
          -- Set icons to characters that are more likely to work in every terminal.
          --    Feel free to remove or use ones that you like more! :)
          --    Don't feel like these are good choices.
          icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
          controls = {
            icons = {
              pause = '⏸',
              play = '▶',
              step_into = '⏎',
              step_over = '⏭',
              step_out = '⏮',
              step_back = 'b',
              run_last = '▶▶',
              terminate = '⏹',
            },
          },
        }

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Install golang specific config
        require('dap-go').setup()
      end,
    },

    -- multi cursor
    {
      'mg979/vim-visual-multi',
      lazy = true,
      event = "VeryLazy",
    },

    -- themes
    { 'sainnhe/sonokai' },
    { 
      'pgdouyon/vim-yin-yang',
      cond = isEditor
    },

    -- text editing
    { 
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      lazy = true,
      event = { "BufReadPre", "BufNewFile" },
      ft = {'markdown', 'text'},
      cond = isEditor
    },

    {
      'krajeswaran/taskpaper.vim',
      lazy = true,

      event = { "BufReadPre", "BufNewFile" },
      ft = {'markdown', 'taskpaper'},
      cond = isEditor
    }, 
    {
      'uga-rosa/cmp-dictionary',
      cond = isEditor,
      config = function() require("cmp_dictionary").setup({
        dic = {
          ["*"] = { "/usr/share/dict/words" },
          spelllang = {
            en = "/usr/share/hunspell/en_US.dic",
          },
        },
      })
      end
    },

    -- coding
    { 
      'andymass/vim-matchup',
      lazy = true,
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        -- may set any options here
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end
    },
    {
      'Wansmer/treesj',
      lazy = true,
      event = { "BufReadPre", "BufNewFile" },
      dependencies = { 'nvim-treesitter' },
      config = function()
        require('treesj').setup({--[[ your config ]]})
      end,
    },
    { 
      'ahmedkhalf/project.nvim',
      lazy=true,
      config = { 
        ignore_lsp = { "null-ls" },
      },
    },
    { 
      'sindrets/diffview.nvim',
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      cmd = { "DiffviewFileHistory", "DiffviewOpen" },
      lazy = true,
    },
    {
      'NvChad/nvim-colorizer.lua',
      lazy = true,
      event = { "BufReadPre", "BufNewFile" },
    },
    {
      "junegunn/goyo.vim",
      cmd = "Goyo",
      lazy = true,
      event = { "BufReadPre", "BufNewFile" },
    },

    { 
      'rest-nvim/rest.nvim', 
      lazy = true,
      event = { "BufReadPre", "BufNewFile" },
      config = function() 
        vim.keymap.set('n', '<Leader>ht', '<Plug>RestNvim<CR>', { desc = "Execute RestNvim" })
      end
    },

    {'samoshkin/vim-mergetool'},
  }
})

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Splits
vim.o.splitbelow = true
vim.o.splitright = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--clipboard
vim.o.clipboard = "unnamed,unnamedplus"

--line breaks
vim.o.linebreak = true

--show matching brackets
vim.o.showmatch = true

--Enable mouse mode
vim.o.mouse = 'a'

--title
vim.o.title = true

--virtualedit
vim.o.virtualedit = 'onemore'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/' .. '.nvimundo'

--backups
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--wild mode
vim.o.wildmode = "longest:list,full"
vim.o.wildignore = "'*/tmp/*', '*.so', '*.swp', '*.zip', '*.pyc', '.git', '.idea', 'build/*', '*/.DS_Store/*', '*/__pycache__/*'"

--Decrease update time
vim.o.updatetime = 100

--autoread
vim.o.autoread = true

-- timeout length for whichkey
vim.o.timeoutlen = 500

--Set colorscheme 
vim.o.termguicolors = true
local term = os.getenv("TERMPURPOSE")
if term == "console" then
  vim.o.background = 'dark'
  vim.cmd [[
    colorscheme murphy
    highlight Pmenu guibg=0 ctermbg=0
    highlight SignColumn guibg=0 ctermbg=0
  ]]
elseif term == "editor" then
  vim.cmd [[
    colorscheme yin
    highlight EndOfBuffer guifg=#1c1c1c
  ]]
else
  vim.o.background = 'dark'
  if term == "api" then
    vim.g.sonokai_style = 'andromeda'
  else
    vim.g.sonokai_style = 'maia'
  end
  vim.g.sonokai_enable_italic = 1
  vim.g.sonokai_show_eob = 0
  vim.g.sonokai_diagnostic_text_highlight = 1
  vim.g.sonokai_better_performance = 1
  vim.cmd [[colorscheme sonokai]]
end

--set whichwrap
vim.o.whichwrap = "b,s,h,l,<,>,[,]"

--don't insert comments while pasting
vim.bo.formatoptions = vim.bo.formatoptions:gsub("r", '')
vim.bo.formatoptions = vim.bo.formatoptions:gsub("o", '')

-- set paste
vim.o.pastetoggle='<F2>'

-- diff options
vim.o.diffopt = vim.o.diffopt .. ",vertical,indent-heuristic,iwhiteall,algorithm:patience"

-- tab / indent stuff
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

--path
vim.opt.path = vim.opt.path + '**'

--scroll stuff
vim.o.scrolljump=5
vim.o.scrolloff=2   

-- visual search
vim.o.inccommand = 'split'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- Treesitter folds
vim.o.foldmethod='expr'
vim.o.foldexpr='nvim_treesitter#foldexpr()'
vim.o.foldlevel=99

-- open last mark
vim.cmd [[
augroup last_edit
autocmd!
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
]]

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  ]],
  false
)

--terminal
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap = true })

--quick save
vim.api.nvim_set_keymap('n', '<Leader>x', ':wq<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- easier window moving
vim.api.nvim_set_keymap('', '<C-S-Down>', '<C-W>j<C-W>_', {})
vim.api.nvim_set_keymap('', '<C-S-Up>', '<C-W>h<C-W>_', {})
vim.api.nvim_set_keymap('', '<C-S-Right>', '<C-W>l<C-W>_', {})
vim.api.nvim_set_keymap('', '<C-S-Left>', '<C-W>h<C-W>_', {})

-- easier code folding
vim.api.nvim_set_keymap('n', '<Leader>f0', ':set foldlevel=0<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f1', ':set foldlevel=1<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f2', ':set foldlevel=2<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f3', ':set foldlevel=3<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f4', ':set foldlevel=4<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f5', ':set foldlevel=5<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f6', ':set foldlevel=6<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f7', ':set foldlevel=7<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f8', ':set foldlevel=8<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f9', ':set foldlevel=9<CR>', {})

-- cd shortcuts
vim.api.nvim_set_keymap('c', 'cwd', 'lcd %:p:h', {})
vim.api.nvim_set_keymap('c', 'cd.', 'lcd %:p:h', {})

-- visual shifting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true})

-- sudo
vim.api.nvim_set_keymap('c', 'w!!', '!sudo tee % >/dev/null', {})

-- adjust view ports
vim.api.nvim_set_keymap('n', '<Leader>=', '<C-w>=', { noremap = true })

-- spell check
vim.api.nvim_set_keymap('n', '<F7>', ':setlocal spell spelllang=en', {})

-- make search result centered
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

-- json format
vim.api.nvim_set_keymap('n', '<leader>jt', '<Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>', {})


-- text editing
vim.cmd [[
augroup texting
  autocmd!
  set spelllang=en

  autocmd FileType markdown,text,taskpaper set autowriteall
  autocmd TextChanged,TextChangedI scratch.md silent write  

  autocmd BufRead,BufNewFile todo.md :Goyo 80
  autocmd BufRead,BufNewFile todo.md set ft=taskpaper 
  autocmd BufRead,BufNewFile todo.md set statusline=
  autocmd BufWritePost todo.md call timer_start(1000, {-> execute("echo ''", "")})
  autocmd TextChanged,TextChangedI todo.md silent write  
  autocmd VimEnter todo.md  setlocal complete=k/~/notes/journal/**/*

  autocmd BufRead,BufNewFile todo.md set ft=taskpaper 
  autocmd BufRead,BufNewFile todo.md set statusline=
  autocmd BufWritePost */journal/** call timer_start(1000, {-> execute("echo ''", "")})
  autocmd TextChanged,TextChangedI */journal/** silent write  
  autocmd VimEnter */journal/**  setlocal complete=k/~/notes/journal/**/*
augroup END
]]

_G.JournalMode = function()
  -- open journal file with date
  local fname = util.join_paths(os.getenv('HOME'), 'notes', 'journal', os.date("%Y"), os.date("%d%b") .. ".md")
  local skeleton = util.join_paths(os.getenv('HOME'), 'notes', 'journal', 'journal.skeleton')
  vim.api.nvim_command('e ' .. fname)
  vim.api.nvim_command('0r ' .. skeleton)
  vim.api.nvim_command('Goyo')
  vim.api.nvim_command('set statusline=')
  vim.api.nvim_command('set signcolumn=no')
  vim.api.nvim_command('set spell!')
end

_G.ScratchPad = function()
  -- open journal file with date
  local fname = util.join_paths(os.getenv('HOME'), 'scratch.md')
  vim.api.nvim_command('e ' .. fname)
  vim.api.nvim_command('Goyo')
  vim.api.nvim_command('set statusline=')
  vim.api.nvim_command('set signcolumn=no')
  vim.api.nvim_command('set autowriteall')
end

vim.api.nvim_set_keymap('n', '<leader>j', ':lua JournalMode()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>je', ':!~/bin/send-journal %<CR>', { noremap = true })
vim.cmd [[ command! Journal execute 'lua JournalMode()' ]]
vim.cmd [[ command! Scratch execute 'lua ScratchPad()' ]]

-- statusline --

local lspstatus = require('lsp-status')

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
lspstatus.config({
  indicator_errors = signs['Error'],
  indicator_warnings = signs['Warn'],
  indicator_info = signs['Info'],
  indicator_hint = signs['Hint'],
  indicator_ok = '',
  status_symbol = '',
})
if not isEditor() then
  lspstatus.register_progress()
end

display_lsp_diagnostics = function()
  if isEditor() or vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
    return ''
  end
  local status = lspstatus.status()
  if status == ' ' then
    return ' '
  end
  return status
end

display_paste = function()
  local result = ""
  local paste = vim.go.paste
  if paste then
    result = "  "
  end
  return result
end

display_readonly = function()
  local ro = vim.bo.readonly
  local mod = vim.bo.modifiable
  if (ro and not mod) or not mod then
    return " "
  elseif ro then
    return " "
  else
    return ""
  end
end

display_modified = function()
  if vim.bo.modified then
    return "● "
  else
    return ""
  end
end

display_filetype = function()
  local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
  local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
  return icon
end

display_metadata = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lhs = ""
  local rhs = ""
  local format = vim.api.nvim_buf_get_option(bufnr, "fileformat")
  local encoding = vim.api.nvim_buf_get_option(bufnr, "fileencoding")
  if #format > 0 and format ~= "unix" then
    lhs = format
  end
  if #encoding > 0 and encoding ~= "utf-8" then
    rhs = encoding
  end
  if #lhs > 0 and #rhs > 0 then
    return vim.fn.join({ lhs, rhs }, " | ")
  else
    return string.format(" %s %s ", lhs, rhs)
  end
end

display_buffer = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local icon = " "
  for i, b in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr == b then
      return icon .. i
    end
  end
end

display_git_status= function()
  --  fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
  local is_head_empty = signs.head ~= ''

  return is_head_empty and string.format(
    ' +%s ~%s -%s |  %s ',
    signs.added, signs.changed, signs.removed, signs.head
  ) or ''
end

Statusline = function()
  local color = '%#LineNr#'
  local filename = ' %f '
  local filestat1 = display_modified()
  local filestat2 = display_readonly()
  local git_status = display_git_status()
  local diagnostics = display_lsp_diagnostics()
  local separator = '%='
  local ft = display_filetype()
  local metadata = display_metadata()
  local percent_indicator = ' %p%% '
  local line_indicator = ' %l:%c'

  return table.concat({ color, filename, filestat1, filestat2, diagnostics, separator, git_status, ft, metadata, percent_indicator, line_indicator})
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline()
  au FileType taskpaper,NvimTree,Terminal set statusline=
  augroup END
]], false)

-- LSP Settings

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- rust_analyzer = {},
  gopls = {},
  pyright = {},
  bashls = {},
  sqlls = {},
  jsonls = {
    -- lazy-load schemastore when needed
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    settings = {
      json = {
        format = {
          enable = true,
        },
        validate = { enable = true },
      },
    },
  },
  tsserver = {
    settings = {
      completions = {
        completeFunctionCalls = true,
      },
    },
  },
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

local telescope = require('telescope.builtin')
vim.lsp.handlers["textDocument/codeAction"] = telescope.lsp_code_actions
vim.lsp.handlers["textDocument/declaration"] = telescope.lsp_definitions
vim.lsp.handlers["textDocument/definition"] = telescope.lsp_definitions
vim.lsp.handlers["textDocument/documentSymbol"] = telescope.lsp_document_symbols
vim.lsp.handlers["textDocument/implementation"] = telescope.lsp_implementations
vim.lsp.handlers["textDocument/references"] = telescope.lsp_references
vim.lsp.handlers["textDocument/typeDefinition"] = telescope.lsp_definitions
vim.lsp.handlers["workspace/symbol"] = telescope.lsp_workspace_symbols

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for lsp, _ in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = servers[lsp],
  }
end
