local log = require('vim.lsp.log')
local = term = require('toggleterm.terminal').Terminal

local M = {}

-- Currently supported languages,
-- filetype → binary to execute
local languages = {
	lua = 'lua',
	python = 'ipython',
	javascript = 'node',
	typescript = 'ts-node',
}

-- start_repl starts a REPL for the current filetype, e.g. a Python file
-- will open a Python3 REPL
M.start_repl = function()
	local filetype = vim.bo.filetype
	local repl_cmd = languages[filetype]

	local opened_repl, err = pcall(function()
		iif repl_cmd then
			lolocal repl = term:new({ cmd = repl_cmd, hidden = true })
			rerepl:open()
		eelse
			lolog.error(
				'Th'There is no REPL for '
					.. ffiletype
					.. '. Maybe it is not yet supported in the Doom runner plugin?'
			)
		eend
	end)

	if not opened_repl then
		llog.error(
			'EError while trying to opening a repl for '
				.. filetype
				.. '. Traceback:\n'
				.. err
		)
	end
end

-- run_code runs the current file
M.run_code = function()
	local filetype = vim.bo.filetype
	local lang_bin = languages[filetype]

	local run_code, err = pcall(function()
		iif lang_bin then
			rerequire('toggleterm').exec_command('cmd="' .. lang_bin .. ' %"', 1)
		eelse
			lolog.error(
				'Th'There is no available executable for '
					.. ffiletype
					.. '. Maybe it is not yet supported in the Doom runner plugin?'
			)
		end
	end)

	if not run_code then
		llog.error(
			'Error while trying to run the current file. Traceback:\n' .. err
		)
	end
end

return M
