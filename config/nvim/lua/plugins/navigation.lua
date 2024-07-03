return {
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
  },
  {
    "ggandor/leap.nvim",
    keys = { "\\" },
    enabled = false,
    config = function()
      require("leap").setup({
        case_sensitive = false,
      })
      vim.keymap.set("n", "\\", function()
        require("leap").leap({
          target_windows = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).focusable
          end, vim.api.nvim_tabpage_list_wins(0)),
        })
      end)
      require("flit").setup({}) -- f/t motions
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      fzf_opts = {
        ["--no-scrollbar"] = false,
        ["--tiebreak"] = "begin,score,end,length,index",
      },
      fzf_bin = "sk",
      winopts = {
        preview = {
          layout = "flex",
          flip_columns = 185,
          vertical = "down:55%",
          horizontal = "right:45%",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "natecraddock/telescope-zf-native.nvim" },
      { "aaronhallaert/advanced-git-search.nvim", dependencies = { "tpope/vim-fugitive" } },
      { "princejoogie/dir-telescope.nvim" },
    },
    opts = {
      defaults = {
        layout_strategy = "flex",
        width = { padding = 0.1 },
        height = { padding = 0.1 },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_cutoff = 185,
            preview_width = 0.4,
          },
          vertical = {
            preview_height = 0.4,
            mirror = true,
            prompt_position = "top",
          },
          flex = { flip_columns = 185 },
        },
      },
      pickers = {
        find_files = {
          find_command = function() -- modified from telescope.nvim/lua/telescope/builtin/__files.lua
            if 1 == vim.fn.executable("fd") then
              return { "fd", "--type", "f", "--color", "never" }
            elseif 1 == vim.fn.executable("fdfind") then
              return { "fdfind", "--type", "f", "--color", "never" }
            elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
              return { "find", ".", "-type", "f" }
            elseif 1 == vim.fn.executable("where") then
              return { "where", "/r", ".", "*" }
            end
          end,
        },
      },
    },
    -- apply the config and additionally load fzf-native
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      -- telescope.load_extension("fzf")
      telescope.load_extension("zf-native")
      telescope.load_extension("advanced_git_search")
      telescope.load_extension("dir")
    end,
    keys = {
      { "<leader>gv", "<cmd>Telescope advanced_git_search show_custom_functions<cr>", desc = "Git advanced search" },
      { "<leader>?", LazyVim.pick("live_grep"), desc = "Search in Files (Root)" },
      { "<leader><leader>", LazyVim.pick("files"), desc = "Go To Files (cwd)" },
      {
        "<leader>fu",
        function()
          require("telescope.builtin").find_files({ no_ignore = true, hidden = true })
        end,
        desc = "Go To Files (-u)",
      },
      { "<leader>sp", "<cmd>Telescope dir live_grep<CR>", desc = "Grep in Path" },
      { "<leader>fp", "<cmd>Telescope dir find_files<CR>", desc = "Files in Path" },
      { "<F6>", "<cmd>Telescope fd<CR>", desc = "Telescope fd" },
    },
  },
  {
    "SmiteshP/nvim-navbuddy", -- navbuddy needs to load before lsp
    config = function()
      local navbuddy = require("nvim-navbuddy")
      navbuddy.setup({
        lsp = { auto_attach = true },
        window = {
          size = "85%",
          mid = { size = "50%" },
        },
        source_buffer = {
          follow_node = false,
        },
      })
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      -- "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>nb", "<cmd>lua require('nvim-navbuddy').open()<cr>", desc = "Open navbuddy" },
    },
    cmd = { "Navbuddy" },
  },
  {
    "nacro90/numb.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("numb").setup()
    end,
  },
  { -- config based on LazyVim's Extra version but I need some tweaks
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      global_settings = {
        mark_branch = true,
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "\\a",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "\\\\",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
        {
          "\\,",
          function()
            local harpoon = require("harpoon")
            harpoon:list():prev()
          end,
          desc = "Harpoon Quick Menu",
        },
        {
          "\\.",
          function()
            local harpoon = require("harpoon")
            harpoon:list():next()
          end,
          desc = "Harpoon Quick Menu",
        },
      }
      for i = 1, 10 do
        table.insert(keys, {
          "\\" .. i % 10,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
}
