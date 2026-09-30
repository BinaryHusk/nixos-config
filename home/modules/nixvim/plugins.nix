{
  config,
  lib,
  pkgs,
  ...
}:

{
  extraPackages = with pkgs; [
    black
    fd
    fzf
    glow
    ripgrep
  ];

  extraPlugins = with pkgs.vimPlugins; [
    nvim-lightbulb
    treesj
  ];

  plugins = {
    # Visuals and interaction.
    nvim-autopairs = {
      enable = true;
      settings.check_ts = true;
    };

    indent-blankline = {
      enable = true;
      settings = {
        indent = {
          char = "▏";
          tab_char = ".";
        };
        whitespace.remove_blankline_trail = false;
        scope = {
          show_start = false;
          show_end = false;
        };
      };
    };

    lualine = {
      enable = true;
      settings = {
        options = {
          icons_enabled = true;
          theme = "nightfox";
          component_separators = {
            left = "⏽";
            right = "⏽";
          };
          section_separators = {
            left = "";
            right = "";
          };
          globalstatus = true;
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            "diff"
          ];
          lualine_c = [ "filename" ];
          lualine_x = [
            "diagnostics"
            "filetype"
            "fileformat"
            "encoding"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
    };

    noice = {
      enable = true;
      settings = {
        lsp = {
          progress.enabled = false;
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
          signature.enabled = false;
          message.enabled = false;
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          inc_rename = false;
          long_message_to_split = true;
          lsp_doc_border = false;
        };
      };
    };

    notify = {
      enable = true;
      settings = {
        background_colour = "#00000000";
        fps = 20;
        minimum_width = 50;
        render = "compact";
        stages = "fade_in_slide_out";
        timeout = 3000;
      };
    };

    web-devicons.enable = true;
    todo-comments.enable = true;

    # Git and history.
    gitsigns = {
      enable = true;
      settings = {
        attach_to_untracked = true;
        current_line_blame = false;
        current_line_blame_opts = {
          delay = 1000;
          virt_text = true;
          virt_text_pos = "eol";
        };
        max_file_length = 3000;
        sign_priority = 6;
        update_debounce = 100;
      };
    };
    undotree.enable = true;

    # Picker.
    fzf-lua = {
      enable = true;
      profile = "telescope";
      settings = {
        fzf_opts."--layout" = "reverse";
        files = {
          multiprocess = true;
          file_icons = true;
          color_icons = true;
        };
      };
    };

    # Syntax and filetype support.
    treesitter = {
      enable = true;
      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        bash
        c
        commonlisp
        cpp
        css
        go
        gomod
        haskell
        html
        java
        javascript
        json
        kotlin
        lua
        markdown
        markdown_inline
        nix
        python
        rust
        scala
        sql
        toml
        tsx
        typescript
        vim
        vimdoc
        vue
        xml
        yaml
      ];
    };
    treesitter-context.enable = true;
    ts-autotag.enable = true;
    rainbow-delimiters.enable = true;
    vim-matchup = {
      enable = true;
      treesitter.enable = true;
    };

    # File tools.
    neo-tree = {
      enable = true;
      settings = {
        close_if_last_window = true;
        enable_diagnostics = true;
        enable_git_status = true;
        filesystem = {
          bind_to_cwd = false;
          filtered_items = {
            hide_dotfiles = false;
            hide_gitignored = true;
          };
          follow_current_file = {
            enabled = true;
            leave_dirs_open = false;
          };
          hijack_netrw_behavior = "open_default";
          use_libuv_file_watcher = true;
        };
        source_selector = {
          content_layout = "center";
          sources = [
            {
              display_name = "Files";
              source = "filesystem";
            }
            {
              display_name = "Buffers";
              source = "buffers";
            }
            {
              display_name = "Git";
              source = "git_status";
            }
          ];
          winbar = true;
        };
        window = {
          mappings = {
            "<C-s>" = "open_split";
            "<C-t>" = "open_tabnew";
            "<C-v>" = "open_vsplit";
            h = "close_node";
            l = "open";
          };
          position = "left";
          width = 34;
        };
      };
    };

    glow = {
      enable = true;
      settings = {
        border = "rounded";
        glow_path = lib.getExe pkgs.glow;
        style = "dark";
      };
    };

    which-key = {
      enable = true;
      settings = {
        delay = 300;
        preset = "classic";
        win = {
          border = "none";
          padding = [
            1
            2
          ];
        };
      };
    };
  };

  extraConfigLua = lib.mkAfter ''
    require("nvim-lightbulb").setup({
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true, text = "💡" },
    })

    require("treesj").setup({
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = 120,
      cursor_behavior = "hold",
      notify = true,
      dot_repeat = true,
    })
  '';
}
