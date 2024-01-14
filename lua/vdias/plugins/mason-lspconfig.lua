return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",

        -- https://www.reddit.com/r/neovim/comments/12e6a7j/volar_with_vuejs_3/
        "folke/neoconf.nvim",
        "folke/neodev.nvim"
    },
    config = function()
        require("neodev").setup({})
        require("neoconf").setup({})
        local mason = require("mason")
        local mason_lsp_config = require("mason-lspconfig")
        local lspconfig = require('lspconfig')

    -- ○ friendly-snippets 
        -- Mason
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        -- Mason LSP Config
        mason_lsp_config.setup({
            ensure_installed = { "lua_ls", "pyright", "rust_analyzer", "tsserver", "volar" },
        })

        mason_lsp_config.setup_handlers({
            function(server_name)
                local server_config = {}
                if require("neoconf").get(server_name .. ".disable") then
                    return
                end
                if server_name == "volar" then
                    server_config.filetypes = { 'vue', 'typescript', 'javascript' }
                end
                lspconfig[server_name].setup(server_config)
            end,
        })

        --[[
        mason_lsp_config.setup_handlers {
            function (server_name) -- default handler (optional)
                lspconfig[server_name].setup {}
            end
        }
        --]]

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

                -- TODO: Do i need it?
                vim.keymap.set('n', '<space>f', function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end,
        })

    end
}
