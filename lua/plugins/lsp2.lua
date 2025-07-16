return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    config = function ()
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_enable = true,
            ensure_installed = { "lua_ls", "clangd" },
        })

        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map('ga', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

                -- Find references for the word under your cursor.
                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                ---@param client vim.lsp.Client
                ---@param method vim.lsp.protocol.Method
                ---@param bufnr? integer some lsp support methods only in specific files
                ---@return boolean
                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has 'nvim-0.11' == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        vim.diagnostic.config {
            severity_sort = true,
            float = { border = 'rounded', source = 'if_many' },
            underline = { severity = vim.diagnostic.severity.ERROR },
            virtual_text = {
                source = 'if_many',
                spacing = 2,
                format = function(diagnostic)
                    local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                    }
                    return diagnostic_message[diagnostic.severity]
                end,
            },
        }

        -- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
        -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
        -- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
        -- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
        -- vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
        -- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
        -- vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
        -- vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
        -- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
        -- vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")

    end
}
