return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local fb_actions = require("telescope").extensions.file_browser.actions
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local function open_dir_or_file(prompt_bufnr)
      local entry = action_state.get_selected_entry()
      if entry and entry.Path and entry.Path:is_dir() then
        actions.close(prompt_bufnr)
        vim.cmd("NvimTreeOpen " .. entry.path)
      else
        actions.select_default(prompt_bufnr)
      end
    end

    telescope.setup({
      extensions = {
        file_browser = {
          initial_mode = "normal",
          hidden = true,
          mappings = require("config.keymaps").telescope_file_browser(
            fb_actions, open_dir_or_file
          ),
        },
      },
    })

    pcall(telescope.load_extension, "file_browser")

    function _G.select_dir_and_open_tree()
      telescope.extensions.file_browser.file_browser({ select_buffer = true })
    end
  end,
}
