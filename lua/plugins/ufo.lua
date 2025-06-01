return {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    dependencies = {
        "kevinhwang91/promise-async",
        {
            "luukvbaal/statuscol.nvim",
            config = function()
                local builtin = require("statuscol.builtin")
                require("statuscol").setup({
                    relculright = true,
                    segments = {
                        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                        { text = { "%s" }, click = "v:lua.ScSa" },
                        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                    },
                })
            end,
        }
    },
    event = "BufReadPost",
    init = function ()
        vim.o.foldenable = true
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.fillchars = "eob: ,fold: ,foldopen: ,foldsep: ,foldclose:"

        vim.keymap.set("n", "zR", function()
            require("ufo").openAllFolds()
        end)
        vim.keymap.set("n", "zM", function()
            require("ufo").closeAllFolds()
        end)
    end,
    opts = {
        open_fold_hl_timeout = 0,
        provider_selector = function ()
            return { "treesitter", "indent" }
        end,
    }
}
