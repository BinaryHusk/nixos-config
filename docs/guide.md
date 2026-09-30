## 指南

本仓库用于管理个人 nixOS 的配置文件。
版本控制工具：git
自动构建工具：make

## 使用

通过 make 完成，下面罗列一些关键命令。其余可通过 `make help` 获取。
- 完成构建并进行切换
```bash
make switch
```
- 仅完成构建
```bash
make build
```
- 更新 flake.lock 文件，对软件进行升级
```bash
make update
```

## 文件组织情况

下面展示了树形结构和文件大致的管理范围。
```
.
├── configuration.nix            # 核心配置，包含系统 boot 和 版本，此外还涉及到系统的 GC 机制，其他系统配置入口 
├── docs                         # 手册位置
├── flake.lock
├── flake.nix                    # nixpkgs 和 home manager 源配置
├── hardware-configuration.nix   # 硬件配置，推荐自动生成，不在 git 管理范围内
├── home                         # ====== 用户配置 Home Manager ======
│   ├── amos.nix                 # HM 版本，其他用户配置入口 
│   ├── config                   # 配置相关，非 nix 文件
│   │   ├── nvim-snippets
│   │   │   ├── global.json
│   │   │   ├── package.json
│   │   │   └── scala.json
│   │   ├── p10k.zsh             # powerlevel10k 主题
│   │   └── zsh
│   │       └── functions.zsh    # zsh 的 常用函数配置
│   ├── modules
│   │   ├── nixvim               # --- nixvim 相关配置 ---
│   │   │   ├── completion.nix
│   │   │   ├── debug.nix
│   │   │   ├── keymaps.nix
│   │   │   ├── lsp.nix
│   │   │   ├── plugins.nix
│   │   │   ├── startup.nix
│   │   │   └── theme.nix
│   │   ├── nixvim.nix
│   │   ├── tmux.nix
│   │   ├── v2rayn.nix           # 代理软件及配置
│   │   └── zsh.nix              # zsh 相关的配置，包含 插件、alias、环境变量等
│   └── scripts
│       └── tmux-sessionizer.sh
├── Makefile
├── modules                      # ====== 系统配置 =======
│   ├── apps                     # ------ 自打包软件 ------
│   │   └── termius.nix
│   ├── apps.nix
│   ├── desktop.nix              # ------ 桌面相关配置 ------
│   ├── libraries.nix            # ------ 链接库配置 ------
│   ├── locale.nix               # ------ 本地化相关（时区，输入法） ------
│   ├── packages.nix             # ------ 软件包管理 ------
│   ├── proxy.nix                # ------ 代理配置 ------
│   ├── python.nix               # ------ python pip包管理 ------
│   ├── security.nix             # ------ 安全相关的设置 ------
│   ├── services.nix             # ------ 系统服务管理 ------
│   └── users.nix                # ------ 用户相关配置（权限、用户组） ------
└── result -> /nix/store/dw1jq5i2wvrpgjsmxs15z8jmhzmam88v-nixos-system-N9-26.05.20260819.b18a4b9

```
