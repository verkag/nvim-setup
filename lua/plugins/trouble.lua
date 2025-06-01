return {
    {
        "folke/trouble.nvim",
        enabled = false,
        config = function()
            require("trouble").setup({
                icons = false,
            })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle("diagnostics")
            end)
        end
    },
}
