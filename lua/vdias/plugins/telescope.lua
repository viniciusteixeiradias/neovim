return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope").load_extension("fzf")
        local builtin = require("telescope.builtin")

        function find_files()
            builtin.find_files({
                find_command = {'rg', '--files', '--hidden', '-g', '!.git'}
            })
        end

        vim.keymap.set('n', '<leader>ff', find_files, { noremap = true, desc = "Find files including hidden ones" })
        vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = "Find string in cwd" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Find git files (based on changes) "})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find help tags" })
    end,
}
