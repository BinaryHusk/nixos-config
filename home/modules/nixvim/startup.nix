{ lib, ... }:

{
  extraConfigLua = lib.mkAfter ''
    local nixos_logo = {
      "          ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖",
      "          ▜███▙       ▜███▙  ▟███▛",
      "           ▜███▙       ▜███▙▟███▛",
      "            ▜███▙       ▜██████▛",
      "     ▟█████████████████▙ ▜████▛     ▟▙",
      "    ▟███████████████████▙ ▜███▙    ▟██▙",
      "           ▄▄▄▄▖           ▜███▙  ▟███▛",
      "          ▟███▛             ▜██▛ ▟███▛",
      "         ▟███▛               ▜▛ ▟███▛",
      "▟███████████▛                  ▟██████████▙",
      "▜██████████▛                  ▟███████████▛",
      "      ▟███▛ ▟▙               ▟███▛",
      "     ▟███▛ ▟██▙             ▟███▛",
      "    ▟███▛  ▜███▙           ▝▀▀▀▀",
      "    ▜██▛    ▜███▙ ▜██████████████████▛",
      "     ▜▛     ▟████▙ ▜████████████████▛",
      "           ▟██████▙         ▜███▙",
      "          ▟███▛▜███▙         ▜███▙",
      "         ▟███▛  ▜███▙         ▜███▙",
      "         ▝▀▀▀    ▀▀▀▀▘         ▀▀▀▘",
    }

    local function show_nixos_splash()
      if vim.fn.argc() ~= 0 or #vim.api.nvim_list_uis() == 0 then
        return
      end

      local buf = vim.api.nvim_get_current_buf()
      local win = vim.api.nvim_get_current_win()
      local current_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

      if vim.api.nvim_buf_get_name(buf) ~= ""
        or vim.bo[buf].buftype ~= ""
        or vim.bo[buf].modified
        or #current_lines ~= 1
        or current_lines[1] ~= ""
      then
        return
      end

      local old_window_options = {}
      local splash_window_options = {
        colorcolumn = "",
        cursorcolumn = false,
        cursorline = false,
        foldcolumn = "0",
        list = false,
        number = false,
        relativenumber = false,
        signcolumn = "no",
        spell = false,
        statuscolumn = "",
        wrap = false,
      }

      for option, value in pairs(splash_window_options) do
        old_window_options[option] = vim.wo[win][option]
        vim.wo[win][option] = value
      end

      local old_global_options = {
        laststatus = vim.o.laststatus,
        showtabline = vim.o.showtabline,
      }
      vim.o.laststatus = 0
      vim.o.showtabline = 0

      local prompt = "Press any key to start"
      local width = vim.api.nvim_win_get_width(win)
      local height = vim.api.nvim_win_get_height(win)
      local content_height = #nixos_logo + 2
      local top_padding = math.max(math.floor((height - content_height) / 2), 0)
      local lines = {}

      for _ = 1, top_padding do
        table.insert(lines, "")
      end

      local logo_width = 0
      for _, line in ipairs(nixos_logo) do
        logo_width = math.max(logo_width, vim.fn.strdisplaywidth(line))
      end
      local logo_padding = math.max(math.floor((width - logo_width) / 2), 0)

      local function centered_text(line)
        local padding = math.max(math.floor((width - vim.fn.strdisplaywidth(line)) / 2), 0)
        return string.rep(" ", padding) .. line
      end

      for _, line in ipairs(nixos_logo) do
        table.insert(lines, string.rep(" ", logo_padding) .. line)
      end
      table.insert(lines, "")
      table.insert(lines, centered_text(prompt))

      local old_undolevels = vim.bo[buf].undolevels
      vim.bo[buf].undolevels = -1
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.bo[buf].modified = false
      vim.bo[buf].modifiable = false

      local namespace = vim.api.nvim_create_namespace("nixos-splash")
      vim.api.nvim_set_hl(0, "NixOSSplashLogo", { fg = "#7EBAE4", bold = true })
      vim.api.nvim_set_hl(0, "NixOSSplashPrompt", { link = "Comment" })

      for index = 0, #nixos_logo - 1 do
        vim.api.nvim_buf_add_highlight(buf, namespace, "NixOSSplashLogo", top_padding + index, 0, -1)
      end
      vim.api.nvim_buf_add_highlight(
        buf,
        namespace,
        "NixOSSplashPrompt",
        top_padding + #nixos_logo + 1,
        0,
        -1
      )

      vim.api.nvim_win_set_cursor(win, { 1, 0 })
      vim.cmd("redraw")
      pcall(vim.fn.getchar)

      if vim.api.nvim_buf_is_valid(buf) then
        vim.bo[buf].modifiable = true
        vim.api.nvim_buf_clear_namespace(buf, namespace, 0, -1)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "" })
        vim.bo[buf].modified = false
        vim.bo[buf].undolevels = old_undolevels
      end

      if vim.api.nvim_win_is_valid(win) then
        for option, value in pairs(old_window_options) do
          vim.wo[win][option] = value
        end
        vim.api.nvim_win_set_cursor(win, { 1, 0 })
      end

      for option, value in pairs(old_global_options) do
        vim.o[option] = value
      end

      vim.cmd("redraw")
    end

    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      desc = "Show the NixOS startup splash",
      callback = function()
        vim.schedule(show_nixos_splash)
      end,
    })
  '';
}
