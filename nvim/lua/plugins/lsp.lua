return {
  {
    "neovim/nvim-lspconfig",
    ft = {"rust", "python", "javascript", "typescript", "cpp", "html", "go", "typst", "tsx", "sql", "CSS" },
    dependencies = { 
      "nvim-lua/lsp_extensions.nvim",
      "ray-x/lsp_signature.nvim",
      "j-hui/fidget.nvim",
      "simrat39/rust-tools.nvim",
      "lukas-reineke/lsp-format.nvim"
    },
    event = "VeryLazy",
    config = function()
      require("fidget").setup{}
      require("lsp_signature").setup()
      require('lsp-format').setup {}

      local nvim_lsp = require('lspconfig')

      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end 

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local on_attach = function(client)
        require("lsp-format").on_attach(client)
        -- Disable code highlight by the LSP server
        client.server_capabilities.semanticTokensProvider = nil 
      end
      -- Enable diagnostics
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = false,
        update_in_insert = false,
      })


      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      });
      
      vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

      -- TypeScript
      nvim_lsp.ts_ls.setup {capabilities = capabilities, on_attach=on_attach,}

      -- CPP
      nvim_lsp.clangd.setup {capabilities = capabilities, on_attach=on_attach,}

      -- HTML
      nvim_lsp.html.setup {capabilities = capabilities } --, on_attach=on_attach,}

      -- Python
      nvim_lsp.pyright.setup{capabilities = capabilities, on_attach=on_attach,}

      -- CSS
      nvim_lsp.cssls.setup {capabilities = capabilities, on_attach=on_attach,}

      -- Typst
      nvim_lsp.typst_lsp.setup {capabilities = capabilities, on_attach=on_attach,}
 
      -- golang
      nvim_lsp.gopls.setup {
        cmd = {"gopls", "serve"},
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              nilness = true,
              simplifyrange = true,
              unusedwrite = true,
            },
            staticcheck = true,
          },
        },
        capabilities = capabilities,
        on_attach = on_attach,
      }

      if vim.bo.filetype == "rust" then
        -- Enable rust_analyzer
        -- https://sharksforarms.dev/posts/neovim-rust/
        nvim_lsp.rust_analyzer.setup({
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                extraArgs={"--target-dir", "/tmp/rust-analyzer-check"}
              },
              cargo = { loadOutDirsFromCheck = true , allFeatures = true },
              procMacro = { enable = true },
              diagnostics = {
                enable = true,
                disabled = {"unresolved-proc-macro"},
                enableExperimental = true,
              },
            }
          },
          capabilities = capabilities,
          on_attach = on_attach,
        })

        local rt = require("rust-tools")
        rt.setup()
        rt.inlay_hints.enable()
      end
    end
  },
}
