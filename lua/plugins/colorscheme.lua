-- return {
--   {
--     "rose-pine/neovim",
--     name = "rose-pine",
--     priority = 1000,
--     config = function()
--       require("rose-pine").setup {
--         disable_background = false, -- set to true if you want transparency
--         disable_italics = false, -- set to true if you dislike italics
--       }
--       vim.cmd "colorscheme rose-pine" -- or rose-pine-moon / rose-pine-dawn
--     end,
--   },
-- }

-- return {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000, -- ensures it loads before UI plugins
--     opts = {
--       flavour = "mocha", -- 👈 your preferred flavor
--       transparent_background = false,
--       integrations = {
--         cmp = true,
--         gitsigns = true,
--         nvimtree = true,
--         telescope = true,
--         notify = true,
--         mini = true,
--         -- add more integrations as needed
--       },
--     },
--     config = function(_, opts)
--       require("catppuccin").setup(opts)
--       vim.cmd("colorscheme catppuccin")
--     end,
--   },
-- }

-- return {
--   {
--     "folke/tokyonight.nvim",
--     name = "tokyonight",
--     priority = 1000,
--     opts = {
--       style = "night", -- options: "storm", "night", "moon", "day"
--       transparent = false,
--       styles = {
--         comments = { italic = true },
--         keywords = { italic = true },
--         functions = { bold = true },
--         variables = {},
--       },
--       sidebars = { "qf", "help", "terminal", "packer" },
--       dim_inactive = true,
--     },
--     config = function(_, opts)
--       require("tokyonight").setup(opts)
--       vim.cmd "colorscheme tokyonight"
--     end,
--   },
-- }

return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- ensures it loads before other UI plugins
    config = function()
      require("gruvbox").setup {
        contrast = "hard", -- options: soft, medium, hard
        transparent_mode = false,
      }
      vim.cmd "colorscheme gruvbox"
    end,
  },
}
