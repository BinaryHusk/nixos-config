{ lib, ... }:

{
  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        completion.completeopt = "menu,menuone,noinsert";
        snippet.expand = lib.nixvim.mkRaw ''
          function(args)
            require("luasnip").lsp_expand(args.body)
          end
        '';
        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = lib.nixvim.mkRaw ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<S-Tab>" = lib.nixvim.mkRaw ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "path"; }
          { name = "luasnip"; }
          { name = "buffer"; }
        ];
      };
    };

    luasnip = {
      enable = true;
      fromVscode = [
        { }
        { paths = ../../config/nvim-snippets; }
      ];
    };

    lspkind = {
      enable = true;
      cmp.enable = true;
      settings = {
        mode = "symbol_text";
        preset = "codicons";
      };
    };

  };

  extraConfigLua = lib.mkAfter ''
    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  '';
}
