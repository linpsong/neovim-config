-- Check if 'pwsh' (PowerShell Core) is available, otherwise fallback to 'powershell'
local shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"

-- Set shell to 'pwsh' or 'powershell'
vim.o.shell = shell

-- Set shell command flags
vim.o.shellcmdflag =
	'-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues["Out-File:Encoding"]="utf8";Remove-Alias -Force -ErrorAction SilentlyContinue tee;'

-- Set shell redirection
vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'

-- Set shell piping
vim.o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'

-- Set shell quote and shellxquote to empty
vim.o.shellquote = ""
vim.o.shellxquote = ""

-- file_dir should be defined as global
-- Get the directory of the currently edited file
local file_dir = vim.fn.expand("%:p:h")
-- Create an autocommand to change the directory to the current file's directory when opening a terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		-- 设置静默模式
		vim.cmd("silent!")

		-- Change the local working directory to the file's directory
		local change_dir_cmd = 'Set-Location -Path "' .. file_dir .. '"'
		vim.api.nvim_chan_send(vim.b.terminal_job_id, change_dir_cmd .. "\r")
	end,
})
