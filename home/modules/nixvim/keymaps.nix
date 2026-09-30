{ lib, ... }:

let
  map = mode: key: action: desc: {
    inherit mode key action;
    options = {
      inherit desc;
      noremap = true;
      silent = true;
    };
  };
in
{
  keymaps = [
    # Window navigation and resizing.
    (map "n" "<C-h>" "<C-w>h" "Window left")
    (map "n" "<C-j>" "<C-w>j" "Window down")
    (map "n" "<C-k>" "<C-w>k" "Window up")
    (map "n" "<C-l>" "<C-w>l" "Window right")
    (map "n" "<A-Up>" "<cmd>resize -3<cr>" "Decrease window height")
    (map "n" "<A-Down>" "<cmd>resize +3<cr>" "Increase window height")
    (map "n" "<A-Left>" "<cmd>vertical resize -3<cr>" "Decrease window width")
    (map "n" "<A-Right>" "<cmd>vertical resize +3<cr>" "Increase window width")

    # Tabs, buffers, scrolling and quickfix.
    (map "n" "<A-t>" "<cmd>tabnew<cr>" "New tab")
    (map "n" "<A-n>" "<cmd>tabnext<cr>" "Next tab")
    (map "n" "<A-p>" "<cmd>tabprevious<cr>" "Previous tab")
    (map "n" "<S-Tab>" "<cmd>edit #<cr>" "Switch to last buffer")
    (map "n" "<C-d>" "<C-d>zz" "Scroll down centered")
    (map "n" "<C-u>" "<C-u>zz" "Scroll up centered")
    (map "n" "<A-j>" "<cmd>cnext<cr>" "Next quickfix item")
    (map "n" "<A-k>" "<cmd>cprev<cr>" "Previous quickfix item")
    (map "n" "<F4>" "<cmd>setlocal spell!<cr>" "Toggle spell check")
    (map "n" "<leader>w" "<cmd>write<cr>" "Write file")
    (map "n" "<leader>q" "<cmd>quit<cr>" "Quit window")
    (map "n" "<leader>wq" "<cmd>wq<cr>" "Write and quit")
    (map "n" "<leader>q!" "<cmd>quit!<cr>" "Force quit")
    (map "n" "<leader>xq" "<cmd>cclose<cr>" "Close quickfix")
    (map "n" "<leader>bq" "<cmd>BufOnly<cr>" "Close other buffers")
    (map "n" "<leader>dv" "<cmd>nohlsearch<cr>" "Clear search highlight")
    (map "n" "<leader>sr" "<cmd>lua ReplaceWord()<cr>" "Replace word with prompt")
    (map "n" "<leader>ld" "<cmd>lua vim.lsp.buf.definition()<cr>" "Go to definition")
    (map "n" "<leader>lh" "<cmd>lua vim.lsp.buf.hover()<cr>" "Show symbol documentation")
    (map "n" "<leader>ls" "<cmd>lua vim.lsp.buf.signature_help()<cr>" "Show function signature")
    (map "i" "<C-k>" "<cmd>lua vim.lsp.buf.signature_help()<cr>" "Show function signature")
    (map "i" "jk" "<Esc>" "Exit insert mode")
    (map [ "n" "v" ] "<leader>cf" (lib.nixvim.mkRaw ''
      function()
        require("conform").format({
          async = true,
          lsp_format = "fallback",
        })
      end
    '') "Format buffer or selection")
    (map "v" "J" "<cmd>move '>+1<cr>gv=gv" "Move selection down")
    (map "v" "K" "<cmd>move '<-2<cr>gv=gv" "Move selection up")

    # TreeSJ: toggle, split and join syntax nodes such as function arguments.
    (map "n" "<leader>m" "<cmd>TSJToggle<cr>" "Toggle split or join")
    (map "n" "<leader>s" "<cmd>TSJSplit<cr>" "Split syntax node")
    (map "n" "<leader>j" "<cmd>TSJJoin<cr>" "Join syntax node")

    # FzfLua pickers.
    (map "n" "<leader>ff" "<cmd>FzfLua files<cr>" "Find files")
    (map "n" "<leader>fg" "<cmd>FzfLua live_grep<cr>" "Live grep")
    (map "n" "<leader>fs" "<cmd>FzfLua grep<cr>" "Grep")
    (map "n" "<leader>fr" "<cmd>FzfLua oldfiles<cr>" "Recent files")
    (map "n" "<leader>fm" "<cmd>FzfLua marks<cr>" "Marks")
    (map "n" "<leader><Space>" "<cmd>FzfLua grep_cword<cr>" "Grep current word")
    (map "n" "<Tab>" "<cmd>FzfLua buffers<cr>" "Buffers")
    (map "n" "<leader>fvc" "<cmd>FzfLua git_commits<cr>" "Git commits")
    (map "n" "<leader>fvb" "<cmd>FzfLua git_branches<cr>" "Git branches")
    (map "n" "<leader>fvs" "<cmd>FzfLua git_status<cr>" "Git status")
    (map "n" "<leader>fvx" "<cmd>FzfLua git_stash<cr>" "Git stash")
    (map "n" "<leader>flr" "<cmd>FzfLua lsp_references<cr>" "LSP references")
    (map "n" "<leader>fli" "<cmd>FzfLua lsp_implementations<cr>" "LSP implementations")
    (map "n" "<leader>flD" "<cmd>FzfLua lsp_definitions<cr>" "LSP definitions")
    (map "n" "<leader>flt" "<cmd>FzfLua lsp_typedefs<cr>" "LSP type definitions")
    (map "n" "<leader>fld" "<cmd>FzfLua lsp_workspace_diagnostics<cr>" "Workspace diagnostics")
    (map "n" "<leader>fla" "<cmd>FzfLua lsp_code_actions<cr>" "LSP code actions")

    # Git, files and Markdown.
    (map "n" "<leader>gb" "<cmd>Gitsigns blame_line full=true<cr>" "Git blame line")
    (map [ "o" "x" ] "ih" "<cmd>Gitsigns select_hunk<cr>" "Select Git hunk")
    (map "n" "<leader>e" "<cmd>Neotree toggle filesystem left<cr>" "Toggle file explorer")
    (map "n" "<leader>ef" "<cmd>Neotree reveal filesystem left<cr>" "Reveal current file")
    (map "n" "<leader>u" "<cmd>UndotreeToggle<cr>" "Undo tree")
    (map "n" "<leader>mp" "<cmd>Glow<cr>" "Preview Markdown")

  ];
}
