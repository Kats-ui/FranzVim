return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        -- 🟡 FranzVim: Compile & Run Java with package detection
        ["<leader>lj"] = {
          function()
            local buf_path = vim.api.nvim_buf_get_name(0)
            local file = vim.fn.fnamemodify(buf_path, ":t:r")
            local package = ""
            local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)

            -- Parse package declaration
            for _, line in ipairs(lines) do
              local match = line:match "^%s*package%s+([%w%.]+)%s*;"
              if match then
                package = match
                break
              end
            end

            -- Build full class name
            local class = package ~= "" and (package .. "." .. file) or file

            -- Build relative path to source file
            local rel_path = package ~= "" and (package:gsub("%.", "/") .. "/" .. file .. ".java") or (file .. ".java")

            -- Get parent directory of package folder
            local parent_dir = package ~= "" and vim.fn.fnamemodify(buf_path, ":p:h:h")
              or vim.fn.fnamemodify(buf_path, ":p:h")

            -- Final command
            local cmd = 'cd "' .. parent_dir .. '" && javac "' .. rel_path .. '" && java ' .. class

            vim.cmd("split | term bash -c '" .. cmd .. "'")
          end,
          desc = "🟡 FranzVim: Compile & Run Java (with package detection)",
        },
      },
    },
  },
}
