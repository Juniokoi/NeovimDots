U = {}

---@param var any
---@param print? boolean
---@param msg? string if "", Var name is param
function IsTable(var, print, msg)
	local ans = type(var) == 'table'
	local _msg = msg or string.format('%s:%s is %s', msg or 'Var', var, ans)

	if print then print(_msg) end
	return ans
end

---@param pkg any
---@param silent boolean
local function req(pkg, silent)
	local ok, package = pcall(require, pkg)
	if not ok and not silent then
		print('Error while loading package:' .. pkg)
		return
	else
		return package
	end
end

function Is_Number(var) return type(var) == 'number' end
function Is_String(var) return type(var) == 'string' end
function Is_Function(var) return type(var) == 'function' end
function Is_Table(var) return type(var) == 'table' end
---Check if value does exists
function Check(var)
	if not var then return end
	return var
end

--- @param var any Conditioner
--- @param thing any backup value that is returned if first conditional does not exist
function U.if_not(var, thing)
	if not var then return thing end
	return var
end

--- Safelely require an package without breaking neovim if error
---@param pkg string package name
---@param silent? boolean Doesnt trigger error when loading fail
---@return any
function Load(pkg, silent)
	silent = U.if_not(silent, false)
	local var = req(pkg, silent)
	return Check(var)
end

local if_nil = vim.F.if_nil
local fnamemodify = vim.fn.fnamemodify
local filereadable = vim.fn.filereadable

function U.getFiletype()
	return vim.fn.expand('%:e')
end

function U.getFilename()
	return vim.fn.expand('%:t'):gsub('(.*)(%.%w+)$', '%1')
end

function LoadModules(mod, list)
	local files = {}
	local function load_package(pkg)
		return function() req('modules.' .. mod .. '.config.' .. pkg, true) end
	end

	for _, config in ipairs(list) do
		files[config] = load_package(config)
	end
	return files
end

function Switch(param, case_table)
	local case = case_table[param]
	if case then
		if type(case) == "function"
			then case()
			return
		else
			return case
		end
	elseif  case_table['default'] then
		local def = case_table['default']
		if Is_Function(def) then
			def() return
		else
			return def
		end
	else
		return nil
	end
end

---@return number @number of items on the list
function U.get_table_len(T)
	local lengthNum = 0
	for _, _ in ipairs(T) do -- for every key in the table with a corresponding non-nil value
		lengthNum = lengthNum + 1
	end
	return lengthNum
end

function U.add_fn(name, tb)
	vim.api.nvim_create_user_command(name,
		function(args)
			local args = args.args

			if U.isTable(tb) then
				local mock_tb = {}
				for i, _ in pairs(tb) do
					mock_tb[i] = tb[i]
				end

				Switch(args, mock_tb)
			elseif U.isFunction(tb) then
				tb(args)
			end
		end
		, { nargs = '?' })
end

---@return table, number @Table of buffers and @Number of buffers corrently open

function U.print_all_buffers()
	for _,windows_id in pairs(vim.api.nvim_list_wins()) do
		local win = windows_id
		local buffer_id =  {}
		table.insert(buffer_id, vim.api.nvim_win_get_buf(windows_id))

		for _,buffer_name in pairs(buffer_id) do
			print(vim.api.nvim_buf_get_name(buffer_name))
		end
	end
end

function U.get_wins_len()
	local count = 0
	for _,windows_id in pairs(vim.api.nvim_list_wins()) do
		count = count + 1
	end
	return count
end

function U.get_all_buffers_table()
    local buffers = {}

	for _,windows_id in pairs(vim.api.nvim_list_wins()) do
		local win = windows_id
		local buffer_id =  {}
		table.insert(buffer_id, vim.api.nvim_win_get_buf(windows_id))
	end

    return buffers
end

function U.get_local_buffers_table()
	local buffers_id = {}
	local curr_win = vim.api.nvim_get_current_win()
	table.insert(buffers_id, vim.api.nvim_win_get_buf(curr_win))

    return buffers_id
end

function U.get_local_buffers_len()
	return U.get_table_len(U.get_local_buffers_table())
end

function U.get_all_buffers_len()
	return U.get_table_len(U.get_all_buffers_table())
end

U.add_fn('Utils', U )
U.isString = Is_String
U.isFunction= Is_Function
U.isNumber = Is_Number
U.isTable = Is_Table
U.load = Load
U.loadModules = LoadModules
U.switch = Switch
