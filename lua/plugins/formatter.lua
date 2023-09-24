return {
  "mhartington/formatter.nvim",
  ft = { "yaml", "sql", "graphql" },
  opts = function()
    return {
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        sql = {
          function()
            return {
              exe = "sql-formatter",
              args = {
                "-l",
                "postgresql"
              },
              stdin = true,
            }
          end
        },
        yaml = {
          function()
            return {
              exe = "yamlfmt",
              args = {
                "-in",
              },
              stdin = true,
            }
          end
        },
        graphql = {
          require("formatter.filetypes.graphql").prettierd,
        }
      }
    }
  end
}
