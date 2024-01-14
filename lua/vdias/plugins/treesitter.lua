return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup({
            ensure_installed = { "lua_ls", "pyright", "rust_analyzer", "tsserver", "volar" },
            highlight = { enable = true }
        })
    end
}
