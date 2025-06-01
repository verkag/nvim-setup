return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function ()
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_enable = true,
            ensure_installed = { "lua_ls", "clangd" },
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function (args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            },
                {
                    { name = 'buffer' },
                })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                -- focusable = false,
                -- style = "minimal",
                border = "rounded",
                source = "always",
                -- header = "",
                -- prefix = "",
            },
        })

        -- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
        vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
        vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
        vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")

    end
}
