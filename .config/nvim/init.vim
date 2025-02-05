source ~/.vimrc
" lua require("plugins")
lua require("config_lazy")
lua require("init")

let g:copilot_workspace_folders = ["~/ui-common", "~/diagnostics-app", "~/ts-common", "~/tr-data", "~/tr-cdk-core", "~/tr-cdk-technician-bot"]
let g:edge_better_performance = 1
colorscheme edge
