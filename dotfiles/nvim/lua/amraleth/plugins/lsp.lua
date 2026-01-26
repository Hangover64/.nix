return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "nil_ls",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
              noremap = true,
              silent = true,
              buffer = bufnr,
              desc = desc
            })
          end
          map("n", "<leader>lgd", vim.lsp.buf.definition, "Go to definition")
          map("n", "<leader>lgD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "<leader>lgi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "<leader>lgr", vim.lsp.buf.references, "Go to references")
          map("n", "<leader>lH", vim.lsp.buf.hover, "Hover documentation")
          map("n", "<leader>lR", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>lA", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
          map("n", "<leader>ldp", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("n", "<leader>ldn", vim.diagnostic.goto_next, "Next diagnostic")
          map("n", "<leader>ldl", vim.diagnostic.open_float, "Show diagnostic")
        end,
      })

      vim.lsp.config("*", {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      vim.lsp.config.lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }

      local servers = { "lua_ls", "clangd", "nil_ls" }
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end
    end,
  },
}
