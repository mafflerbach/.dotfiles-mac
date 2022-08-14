local provider  = require("telescope_jbehave")

return require("telescope").register_extension {
  exports = provider,
}
