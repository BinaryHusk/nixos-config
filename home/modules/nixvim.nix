{ lib, ... }:

{
  programs.nixvim = {
    imports = [
      ./nixvim/completion.nix
      ./nixvim/debug.nix
      ./nixvim/keymaps.nix
      ./nixvim/lsp.nix
      ./nixvim/plugins.nix
      ./nixvim/startup.nix
      ./nixvim/theme.nix
    ];

    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      # Align a closing parenthesis with the line containing its opener.
      # Neovim's Python indent script defaults to aligning it with the
      # previous content line instead.
      python_indent = {
        closed_paren_align_last_line = false;
      };
    };

    opts = {
      autoindent = true;
      backup = false;
      clipboard = "unnamedplus";
      cmdheight = 1;
      expandtab = true;
      hidden = true;
      hlsearch = true;
      ignorecase = true;
      incsearch = true;
      list = true;
      listchars = "tab:▏·,trail:⋅,extends:❯,precedes:❮,nbsp:␣";
      mouse = "a";
      number = true;
      relativenumber = true;
      scrolloff = 8;
      shiftwidth = 4;
      signcolumn = "yes";
      smartcase = true;
      softtabstop = 4;
      splitbelow = true;
      splitright = true;
      swapfile = false;
      tabstop = 4;
      termguicolors = true;
      timeoutlen = 500;
      undofile = true;
      updatetime = 300;
      visualbell = false;
      wrap = true;
      writebackup = false;
    };

    extraConfigLua = lib.mkAfter ''
      vim.api.nvim_create_user_command("BufOnly", function()
        vim.cmd("silent! %bd|e#|bd#")
      end, { desc = "Close all buffers except the current one" })

      _G.ReplaceWord = function()
        local word = vim.fn.expand("<cword>")
        local replacement = vim.fn.input("Replace with: ")
        if replacement ~= "" then
          vim.cmd(string.format("%%s/\\<%s\\>/%s/gc", vim.pesc(word), replacement))
        end
      end
    '';
  };
}
