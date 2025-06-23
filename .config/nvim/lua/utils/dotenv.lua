local M = {}

function M.load_env_file(path)
	local env = {}

	local file = io.open(path, "r")
	if not file then
		return env -- 🔒 safely return empty env if .env not found
	end

	for line in file:lines() do
		local key, value = string.match(line, "^([%w_]+)%s*=%s*(.*)$")
		if key and value then
			-- Remove surrounding quotes if present
			value = value:gsub("^[\"']", ""):gsub("[\"']$", "")
			env[key] = value
		end
	end

	file:close()
	return env
end

return M
