{ ... }:

{
  # Common Lisp's cl-lsp is not packaged in nixpkgs.  Keep the server
  # on PATH (for example from a Roswell installation) and let Nixvim
  # provide the Neovim-side configuration.
  lsp.servers.cl_lsp = {
    enable = true;
    package = null;
    config = {
      cmd = [ "cl-lsp" ];
      filetypes = [
        "lisp"
        "commonlisp"
      ];
      root_markers = [
        "*.asd"
        "*.lisp"
        ".git"
      ];
    };
  };

  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      keymaps = {
        silent = true;
        diagnostic = {
          "[d" = "goto_prev";
          "]d" = "goto_next";
          "<leader>dd" = "open_float";
        };
        lspBuf = {
          "K" = "hover";
          "gd" = "definition";
          "gD" = "declaration";
          "gi" = "implementation";
          "gr" = "references";
          "<leader>la" = "code_action";
          "<leader>lr" = "rename";
        };
      };
      servers = {
        bashls.enable = true;
        clangd.enable = true;
        cssls.enable = true;
        gopls.enable = true;
        html.enable = true;
        lua_ls.enable = true;
        marksman.enable = true;
        nixd.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        sqls.enable = true;
        tailwindcss.enable = true;
        ts_ls.enable = true;
        vue_ls.enable = true;
      };
    };

    fidget.enable = true;

    lsp-signature = {
      enable = true;
      settings = {
        bind = true;
        floating_window = true;
        hint_enable = false;
        handler_opts.border = "rounded";
      };
    };

    trouble.enable = true;

    conform-nvim = {
      enable = true;
      autoInstall.enable = true;
      settings = {
        default_format_opts = {
          lsp_format = "fallback";
          timeout_ms = 3000;
        };
        formatters_by_ft = {
          bash = [ "shfmt" ];
          c = [ "clang-format" ];
          cpp = [ "clang-format" ];
          css = [ "prettier" ];
          html = [ "prettier" ];
          javascript = [ "prettier" ];
          json = [ "prettier" ];
          lua = [ "stylua" ];
          markdown = [ "prettier" ];
          nix = [ "nixfmt" ];
          python = [ "black" ];
          rust = [ "rustfmt" ];
          sh = [ "shfmt" ];
          sql = [ "sqlfluff" ];
          typescript = [ "prettier" ];
          vue = [ "prettier" ];
        };
      };
    };

    lint = {
      enable = true;
      autoInstall.enable = true;
      lintersByFt = {
        bash = [ "shellcheck" ];
        sh = [ "shellcheck" ];
        javascript = [ "eslint_d" ];
        typescript = [ "eslint_d" ];
        python = [ "ruff" ];
        sql = [ "sqlfluff" ];
      };
    };
  };
}
