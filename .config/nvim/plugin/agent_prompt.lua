-- Select text → prompt for a prompt → prefill a template → launch an agent on it
-- in a new window, keeping focus where you started.
--   :'<,'>AgentPrompt   (visual)        <leader>ai        (visual)
--   :AgentPrompt        (current line)  <leader>ai{motion} (operator, e.g. ip)
-- At the prompt, <Tab>/<S-Tab> cycle the agent (vim-grepper style).

if vim.g.loaded_agent_prompt then
  return
end
vim.g.loaded_agent_prompt = 1

local agents = {
  { name = "claude", cmd = "claude" },
  { name = "pi",     cmd = "pi" },
  { name = "codex",  cmd = "codex" },
}

local function build_template(lines, prompt)
  return table.concat({
    "file: " .. vim.fn.expand("%:p"),
    "code:",
    "```" .. vim.bo.filetype,
    table.concat(lines, "\n"),
    "```",
    "",
    prompt,
  }, "\n")
end

local function launch(agent_cmd, lines, prompt)
  local tmpfile = vim.fn.tempname()
  vim.fn.writefile(vim.split(build_template(lines, prompt), "\n"), tmpfile)
  vim.cmd(string.format([[Spawn %s "$(cat %s)"]], agent_cmd, tmpfile))
end

-- Markers appended to the typed line by the <Tab> maps below; CANCEL distinguishes
-- <Esc> from an empty submit. NUL-range control bytes a user won't type.
local CYCLE = string.char(31)
local CANCEL = string.char(24) .. "cancel"

local function read_prompt(label, default)
  vim.keymap.set("c", "<Tab>", function() return CYCLE .. ">" .. "<CR>" end, { expr = true })
  vim.keymap.set("c", "<S-Tab>", function() return CYCLE .. "<" .. "<CR>" end, { expr = true })
  local ok, val = pcall(vim.fn.input, { prompt = label .. "> ", default = default, cancelreturn = CANCEL })
  pcall(vim.keymap.del, "c", "<Tab>")
  pcall(vim.keymap.del, "c", "<S-Tab>")
  return ok and val or CANCEL
end

local function ask(lines)
  local list = agents
  local idx = vim.g.agent_prompt_agent_idx or 1
  if idx > #list then idx = 1 end
  local text = ""
  while true do
    local val = read_prompt(list[idx].name, text)
    if val == CANCEL then
      return
    elseif val:sub(-2, -2) == CYCLE then
      text = val:sub(1, -3) -- drop the 2-byte marker, keep what was typed
      local step = (val:sub(-1) == ">") and 1 or -1
      idx = (idx - 1 + step) % #list + 1
    elseif val ~= "" then
      vim.g.agent_prompt_agent_idx = idx -- remember the choice for next time
      launch(list[idx].cmd, lines, val)
      return
    else
      return
    end
  end
end

vim.api.nvim_create_user_command("AgentPrompt", function(opts)
  ask(vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false))
end, { range = true })

vim.keymap.set("x", "<Plug>(AgentPrompt)", ":AgentPrompt<CR>", { silent = true })

_G.__AgentPromptOpfunc = function()
  ask(vim.api.nvim_buf_get_lines(0, vim.fn.line("'[") - 1, vim.fn.line("']"), false))
end
vim.keymap.set("n", "<Plug>(AgentPrompt)", function()
  vim.o.operatorfunc = "v:lua.__AgentPromptOpfunc"
  return "g@"
end, { expr = true })

if not vim.g.agent_prompt_no_default_mappings then
  vim.keymap.set({ "n", "x" }, "<leader>ai", "<Plug>(AgentPrompt)", { remap = true })
end
