require("plugins")
require("typescript").setup({})
--[[ require("vgit").setup({
  live_gutter = {
    enabled = false,
  },
}) ]]
require("null-ls").setup()
require("eslint").setup({
  bin = "eslint",
  diagnostics= {
    enable = true,
    report_unused_disable_directives = true,
    run_on = "type",
  },
})
