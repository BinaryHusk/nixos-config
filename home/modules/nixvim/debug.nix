{ lib, ... }:

{
  plugins = {
    dap = {
      enable = true;
      configurations = {
        java = [
          {
            type = "java";
            request = "attach";
            name = "Debug remote Java";
            hostName = "127.0.0.1";
            port = 8000;
          }
        ];
      };
    };

    dap-ui.enable = true;
    dap-virtual-text.enable = true;
  };

  extraConfigLua = lib.mkAfter ''
    local dap = require("dap")
    local dapui = require("dapui")

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>do";
      action = lib.nixvim.mkRaw "function() require('dap').repl.open() end";
      options.desc = "Open debug REPL";
    }
    {
      mode = "n";
      key = "<leader>db";
      action = lib.nixvim.mkRaw "function() require('dap').toggle_breakpoint() end";
      options.desc = "Toggle breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dm";
      action = lib.nixvim.mkRaw "function() require('dap').run_to_cursor() end";
      options.desc = "Run to cursor";
    }
    {
      mode = "n";
      key = "<leader>du";
      action = lib.nixvim.mkRaw "function() require('dapui').toggle() end";
      options.desc = "Toggle debug UI";
    }
    {
      mode = "n";
      key = "<F9>";
      action = lib.nixvim.mkRaw "function() require('dap').continue() end";
      options.desc = "Continue debugging";
    }
    {
      mode = "n";
      key = "<F10>";
      action = lib.nixvim.mkRaw "function() require('dap').step_into() end";
      options.desc = "Step into";
    }
    {
      mode = "n";
      key = "<F11>";
      action = lib.nixvim.mkRaw "function() require('dap').step_over() end";
      options.desc = "Step over";
    }
    {
      mode = "n";
      key = "<F8>";
      action = lib.nixvim.mkRaw "function() require('dap').step_out() end";
      options.desc = "Step out";
    }
  ];
}
