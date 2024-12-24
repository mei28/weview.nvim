local M = {}

local config = {
  open_cmd = "",
  search_urls = {
    Google = "https://www.google.com/search?q=%s",
    GitHub = "https://github.com/search?q=%s",
    DeepL = "https://www.deepl.com/ja/translator#en/ja/%s",
  },
  aliases = {
    g = "Google",
    gh = "GitHub",
    d = "DeepL",
  },
  command_name = "Weview", -- the default command name
}

--- Encode the string to URL
--- @param str string
--- @return string
local function url_encode(str)
  str = string.gsub(str, "([^0-9a-zA-Z !'()*._~-])", function(c)
    return string.format("%%%02X", string.byte(c))
  end)
  str = string.gsub(str, " ", "%%20")
  return str
end

--- generate the command to execute
--- @param url_template string
--- @param query string
--- @return string|nil
local function build_search_command(url_template, query)
  local encoded_query = url_encode(query)
  local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
  return string.format("%s '%s'", open_cmd, string.format(url_template, encoded_query))
end

--- excute the main command
---@param opts table
local function search_cmd(opts)
  local fargs = opts.fargs
  if #fargs < 2 then
    vim.notify("Usage: " .. config.command_name .. " <engine|alias> <query>", vim.log.levels.ERROR)
    return
  end

  local engine_or_alias = fargs[1]
  local query = table.concat(vim.list_slice(fargs, 2), " ")

  -- expand the alias
  local engine = config.aliases[engine_or_alias] or engine_or_alias
  local url_template = config.search_urls[engine]

  if not url_template then
    vim.notify("Search engine not found: " .. engine_or_alias, vim.log.levels.ERROR)
    return
  end

  local command = build_search_command(url_template, query)
  if command then
    os.execute(command)
  end
end

--- command completion
---@param arg_lead string
---@param cmdline string
---@return string[]
local function search_complete(arg_lead, cmdline, _)
  if cmdline:match("^" .. config.command_name .. "[!]*%s+%w*$") then
    local engines_and_aliases = vim.tbl_keys(config.search_urls)
    for alias, engine in pairs(config.aliases) do
      table.insert(engines_and_aliases, alias)
    end
    return vim.tbl_filter(function(key)
      return key:find(arg_lead, 1, true) == 1
    end, engines_and_aliases)
  end
end

--- @param opts table
function M.setup(opts)
  opts = opts or {}

  if opts.search_urls then
    config.search_urls = vim.tbl_deep_extend("force", config.search_urls, opts.search_urls)
  end

  if opts.aliases then
    config.aliases = vim.tbl_deep_extend("force", config.aliases, opts.aliases)
  end

  if opts.command_name then
    config.command_name = opts.command_name
  end

  vim.api.nvim_create_user_command(config.command_name, search_cmd, {
    nargs = "+",
    desc = "Search using the specified engine or alias",
    complete = search_complete,
  })
end

return M
