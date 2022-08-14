local provider  = require("conventional_commits")

return require("telescope").register_extension {
  exports = provider,
}
