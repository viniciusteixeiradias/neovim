return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
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
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require('lspconfig')

        -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
        local servers = { 'pyright', 'tsserver' }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                capabilities = capabilities
            }
        end

        -- luasnip setup
        local luasnip = require("luasnip")

        -- nvim-cmp setup
        local cmp = require("cmp")

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
                ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
                ['<C-Space>'] = cmp.mapping.complete(), -- ask autocompletion
                -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                -- ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                -- ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' }
            },
        }
    end,
}
