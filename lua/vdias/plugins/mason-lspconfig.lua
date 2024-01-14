return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",

        -- https://www.reddit.com/r/neovim/comments/12e6a7j/volar_with_vuejs_3/
        "folke/neoconf.nvim",
        "folke/neodev.nvim",

        -- extra
        'hrsh7th/nvim-cmp', -- Autocompletion plugin
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
        'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
        'L3MON4D3/LuaSnip', -- Snippets plugin
        'rafamadriz/friendly-snippets', -- Snippets collection
        "onsails/lspkind.nvim", -- vs-code like pictograms

    },
    config = function()
        require("neodev").setup({})
        require("neoconf").setup({})
        require("mason").setup({})


        -- Mason
        local mason = require("mason-lspconfig")
        mason.setup({
            ensure_installed = {
                "volar",
                "lua_ls",
                "pyright",
                "tsserver",
                "rust_analyzer"
            },
        })

        mason.setup_handlers({
            function(server_name)
                local lspconfig = require("lspconfig")
                local server_config = {}

                if require("neoconf").get(server_name .. ".disable") then
                    return
                end

                if server_name == "volar" then
                    server_config.filetypes = { 'vue', 'typescript', 'javascript' }
                end

                lspconfig[server_name].setup(server_config)
            end
        })


        -- CMP
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspconfig = require("lspconfig")

        local cmp_custom_mapping = {
            tab = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
            shift_tab = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
        }

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
                ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
                ['<C-Space>'] = cmp.mapping.complete(), -- Ask autocompletion
                ['<CR>'] = cmp.mapping.confirm { select = true }, -- Select
                ['<Tab>'] = cmp.mapping(cmp_custom_mapping.tab, { 'i', 's' }), -- Next
                ['<S-Tab>'] = cmp.mapping(cmp_custom_mapping.shift_tab, { 'i', 's' }), -- Preview
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' }
            },
        }

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
        local servers = { 'volar', 'pyright', 'tsserver' }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({ capabilities = capabilities })
        end


        -- LSP Attach
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.api.nvim_create_autocmd('LspAttach', {
            -- group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
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
            end,
        })


        -- Global Mappings
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
    end
}
