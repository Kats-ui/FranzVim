return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        ["<leader>lc"] = {
          function()
            local buf_path = vim.api.nvim_buf_get_name(0)
            local file = vim.fn.fnamemodify(buf_path, ":t:r")
            local ext = vim.fn.fnamemodify(buf_path, ":e")
            local parent_dir = vim.fn.fnamemodify(buf_path, ":p:h")

            local compiler = ext == "cpp" and "g++" or ext == "c" and "gcc" or nil
            if not compiler then
              vim.notify("Unsupported file type: " .. ext, vim.log.levels.ERROR)
              return
            end

            local output = file .. "_out"
            local cmd = 'cd "'
              .. parent_dir
              .. '" && '
              .. compiler
              .. ' "'
              .. file
              .. "."
              .. ext
              .. '" -o "'
              .. output
              .. '" && ./"'
              .. output
              .. '"'

            vim.cmd("split | term bash -c '" .. cmd .. "'")
          end,
          desc = "Compile & Run C/C++",
        },
      },
    },
  },
}
