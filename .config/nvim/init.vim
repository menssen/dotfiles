source ~/.vimrc
lua require("plugins")
lua require("init")

let g:copilot_workspace_folders = ["~/ui-common", "~/diagnostics-app", "~/nereus-app"]
let g:edge_better_performance = 1
colorscheme edge
