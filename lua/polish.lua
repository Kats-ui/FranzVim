-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Tab navigation

return {
  polish = function()
    -- Custom command to wrap .classname in <div class="classname"></div>
    vim.api.nvim_create_user_command(
      "WrapClassDiv",
      function() vim.cmd [[%s/\.\(\w\+\)/<div class="\1"><\/div>/g]] end,
      { desc = "Wrap .classname in <div class='classname'>" }
    )

    -- disable mouse
    vim.keymap.set("", "<up>", "<nop>", { noremap = true })
    vim.keymap.set("", "<down>", "<nop>", { noremap = true })
    vim.keymap.set("i", "<up>", "<nop>", { noremap = true })
    vim.keymap.set("i", "<down>", "<nop>", { noremap = true })

    vim.opt.mouse = ""

    -- Optional keymap: <Leader>wc to run the command
    vim.keymap.set("n", "<Leader>wc", ":WrapClassDiv<CR>", { desc = "Wrap .classname in div" })

    -- Auro detect buffer working dir
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        local path = vim.fn.expand "%:p:h" -- get directory of current buffer
        if vim.fn.isdirectory(path) == 1 then
          vim.cmd("lcd " .. path) -- set local directory
        end
      end,
    })
  end,
}
