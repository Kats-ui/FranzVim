local job_id = nil
vim.g.browser_sync_autoreload = true

local function notify(msg, level) vim.notify("[BrowserSync] " .. msg, level or vim.log.levels.INFO) end

local function start_browser_sync()
  if job_id then
    notify "Already running"
    return
  end

  -- get current buffer's directory
  local buf_dir = vim.fn.expand "%:p:h"
  if buf_dir == "" then
    buf_dir = vim.fn.getcwd() -- fallback
  end

  job_id = vim.fn.jobstart({
    "browser-sync",
    "start",
    "--server",
    "--files",
    buf_dir,
    "--cwd",
    buf_dir,
  }, {
    cwd = buf_dir,
    on_stdout = function(_, data)
      if data then notify(table.concat(data, "\n")) end
    end,
    on_exit = function()
      notify("BrowserSync stopped", vim.log.levels.WARN)
      job_id = nil
    end,
  })

  if job_id > 0 then
    notify("Started BrowserSync in " .. buf_dir)
  else
    notify("Failed to start BrowserSync", vim.log.levels.ERROR)
    job_id = nil
  end
end

local function stop_browser_sync()
  if job_id then
    vim.fn.jobstop(job_id)
    notify "Stopped BrowserSync"
    job_id = nil
  else
    notify("No BrowserSync job running", vim.log.levels.WARN)
  end
end

-- Auto stop on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if job_id then vim.fn.jobstop(job_id) end
  end,
})

-- Auto reload on save for web dev files
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  pattern = { "*.html", "*.css", "*.js", "*.ts", "*.jsx", "*.tsx", "*.json" },
  callback = function()
    if vim.g.browser_sync_autoreload then vim.cmd "silent! write" end
  end,
})

return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        ["<leader>lz"] = {
          start_browser_sync,
          desc = "Start BrowserSync",
        },
        ["<leader>lx"] = {
          stop_browser_sync,
          desc = "Stop BrowserSync",
        },
        ["<leader>lt"] = {
          function()
            vim.g.browser_sync_autoreload = not vim.g.browser_sync_autoreload
            notify("Auto reload: " .. tostring(vim.g.browser_sync_autoreload))
          end,
          desc = "Toggle BrowserSync auto reload",
        },
      },
    },
  },
}
