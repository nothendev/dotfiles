local M = {}

function M.SwitchLang()
  --local log = io.open("/home/ilya/nvlangswitch.log", "r+")
  --if log == nil then
  --  io.write "nvim crash"
  --  return
  --end
  -- --- @type string
  --local curr_log = log:read "*a"
  --if curr_log == nil then
  --  curr_log = ""
  --end
  local file = io.popen("/usr/bin/env i3-keyboard-layout get")
  if file == nil then
  --  curr_log = curr_log .. "\nNO i3-keyboard-layout !!!!"
  --  log:write(curr_log)
  --  log:close()
    return
  end
  vim.defer_fn(function()
    local out = file:read "*a"
    if out == "" or out == nil then
      out = "<NONE>"
    end
    --file:close()
    --curr_log = curr_log .. "\nswitch to " .. out
    --log:flush()
    --log:close()
    print("switch to " .. out)
    if out == "ru" then
      vim.cmd "set keymap=russian-jcukenwin"
    else
      vim.cmd "set keymap="
    end
  end, 300)
end

return M
