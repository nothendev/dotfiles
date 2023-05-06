-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

local keyword = {
  fg = "#50ffb0",
}
local constant = {
  fg = "#79b8ff",
}
local ident = {
  fg = "#a5ffef",
}
local macro = {
  fg = "#f97583",
}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
    fg = "#959da5",
  },
  ["@keyword"] = keyword,
  Keyword = keyword,
  ["@keyword.function"] = keyword,
  ["@keyword.return"] = keyword,
  ["@keyword.operator"] = {
    fg = "#f97583",
  },
  ["@constant"] = constant,
  ["@constant.builtin"] = constant,
  ["@attribute"] = macro,
  rustLifetime = {
    fg = "#009eff",
  },
  ["@string"] = {
    fg = "#9ecbff",
  },
  ["@method"] = {
    fg = "#b392f0",
  },
  Identifier = ident,
  ["@field"] = ident,
  ["@field.key"] = ident,
  Label = {
    link = "rustLifetime",
  },
  ["@function.call"] = {
    fg = "#ffc66d",
  },
  ["@function"] = {
    fg = "#b392f0",
  },
  rustStructure = {
    fg = "#ff883e",
  },
  PreProc = macro,
  Macro = macro,
  htmlTagName = keyword,
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
  ClassName = { fg = "#ff883e" },
  Identifier = ident,
}

return M
