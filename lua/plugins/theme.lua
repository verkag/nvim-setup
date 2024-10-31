return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({

                on_highlights = function(hl, c)
                    local prompt = "#2d3149"
                    hl.TelescopeNormal = {
                        bg = c.bg_dark,
                        fg = c.fg_dark,
                    }
                    hl.TelescopeBorder = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopePromptNormal = {
                        bg = prompt,
                    }
                    hl.TelescopePromptBorder = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePromptTitle = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePreviewTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopeResultsTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                end,

                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "storm", -- style for sidebars, see below
                    floats = "storm", -- style for floating windows
                },
                on_colors = function(colors)
                    colors.fg_gutter = "#b2b8cf"
                    colors.comment = "#b2b8cf"
                end,
            })
            vim.cmd.colorscheme("tokyonight")
            --vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC', bold=true })
            --vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
            --vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F', bold=true })
            vim.cmd("hi Folded guibg=NONE")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local custom_tokyonight = require("lualine.themes.tokyonight") --maybe not very accurate
            custom_tokyonight.normal.c.fg_gutter = "#ffffff"
            custom_tokyonight.normal.c.comment = "#ffffff"
            local ct = require("lualine.themes.auto")
            ct.normal.b.bg = "#3b4261"
            ct.insert.b.bg = "#3b4261"
            ct.visual.b.bg = "#3b4261"
            ct.replace.b.bg = "#3b4261"
            ct.command.b.bg = "#3b4261"
            require("lualine").setup({
                options = { theme = ct, section_separators = "", component_separators = "" },
            })
        end,
    },
}
