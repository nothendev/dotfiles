local jdtls = require("jdtls")
local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])
local config = {
  cmd = { "jdtls", "-data", root_dir .. "/.jdt" },
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        runtimes = {
          { name = "JavaSE-17", path = "/etc/jvm/17/" },
          { name = "JavaSE-1_8", path = "/etc/jvm/8/" },
          { name = "JavaSE-21", path = "/etc/jvm/21/" },
          { name = "JavaSE-22", path = "/etc/jvm/22/" },
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    jdtls.setup.add_commands()
  end,
  init_options = {
    bundles = {
      vim.fn.glob("/dwl/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
    },
  }
}

vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>JdtUpdateHotcode<CR>", { noremap = true, silent = true })

jdtls.start_or_attach(config)
