      local lspconfig = require("lspconfig")
      require('mini.completion').setup({})
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup(opts)
        end,
        ["vtsls"] = function()
          lspconfig["vtsls"].setup({})
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(_)
          vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
          vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
          vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
          vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
          vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
          vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
          vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
          vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        end
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
      )
