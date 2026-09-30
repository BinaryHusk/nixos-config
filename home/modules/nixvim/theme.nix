{ ... }:

{
  colorscheme = "nightfox";

  colorschemes.nightfox = {
    enable = true;
    flavor = "nightfox";

    settings = {
      options = {
        transparent = true;
        terminal_colors = true;
        dim_inactive = false;
        styles = {
          comments = "italic";
          strings = "italic";
        };
        modules = {
          diagnostic.background = false;
          native_lsp.background = false;
          treesitter = true;
        };
      };
      palettes.nightfox.sel1 = "#3c5372";
      groups.nightfox = {
        NormalFloat.bg = "NONE";
        StatusLine.bg = "NONE";
        StatusLineNC.bg = "NONE";
        TabLineFill.bg = "NONE";
        WinBarNC.bg = "NONE";
        WinSeparator.fg = "NONE";
        Visual.bg = "#3c5372";
      };
    };
  };
}
