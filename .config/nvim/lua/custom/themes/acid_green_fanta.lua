-- credits to original theme for existing https://github.com/primer/github-vscode-theme
-- This is a modified version of it

local tailwind = require('custom.tailwind')

local M = {}

M.base_1984 = {
  white = "#d3dbe3",
  nvbg = "#101214",
  nvaltbg = "#343332",
  nvselbg = "#2a2a2a",
  ident_fg = "#a5ffef",
  comment_fg = "#959da5",
  goog_blue = "#009eff",
  keyword = "#50ffb0",
  lighter_blue = "#58a6ff",
  goog_green = "#85d89a",
  oop = "#ffdf5d",
}

M.base_30 = {
  white = "#d3dbe3",
  darker_black = M.base_1984.nvbg,
  black = M.base_1984.nvbg, --  nvim bg
  black2 = M.base_1984.nvselbg,
  one_bg = M.base_1984.nvbg,
  one_bg2 = M.base_1984.nvbg, -- StatusBar (filename)
  one_bg3 = M.base_1984.nvselbg,
  grey = "#4c5156", -- Line numbers (shouldn't be base01?)
  grey_fg = "#565b60", -- Why this affects comments?
  grey_fg2 = "#60656a",
  light_grey = "#6a6f74",
  red = "#ff7f8d", -- StatusBar (username)
  baby_pink = "#ffa198",
  pink = "#ec6cb9",
  line = "#33383d", -- for lines like vertsplit
  green = "#56d364", -- StatusBar (file percentage)
  vibrant_green = M.base_1984.goog_green,
  nord_blue = M.base_1984.lighter_blue, -- Mode indicator
  blue = "#79c0ff",
  yellow = "#ffdf5d",
  sun = "#ffea7f",
  purple = "#d2a8ff",
  dark_purple = "#bc8cff",
  teal = "#39c5cf",
  orange = "#ffab70",
  cyan = "#56d4dd",
  statusline_bg = M.base_1984.nvbg,
  lightbg = M.base_1984.nvbg,
  pmenu_bg = "#58a6ff", -- Command bar suggestions
  folder_bg = "#58a6ff",
}

M.base_16 = {
  base00 = M.base_1984.nvbg, -- Default bg
  base01 = M.base_1984.nvaltbg, -- Lighter bg (status bar, line number, folding mks)
  base02 = M.base_1984.nvselbg, -- Selection bg
  base03 = M.base_1984.comment_fg, -- Comments, invisibles, line hl
  base04 = M.base_1984.nvbg, -- Dark fg (status bars)
  base05 = "#c9d1d9", -- Default fg (caret, delimiters, Operators)
  base06 = "#d3dbe3", -- Light fg (not often used)
  base07 = "#dde5ed", -- Light bg (not often used)
  base08 = "#B392E9", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
  base09 = "#ffab70", -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
  base0A = "#ffdf5d", -- Classes, Markup Bold, Search Text Background
  base0B = "#a5d6ff", -- Strings, Inherited Class, Markup Code, Diff Inserted
  base0C = "#83caff", -- Support, regex, escape chars
  base0D = "#6AB1F0", -- Function, methods, headings
  base0E = M.base_1984.keyword, -- Keywords
  base0F = "#ff7f8d", -- Deprecated, open/close embedded tags
}

M.type = "dark"

M.polish_hl = {
  ["@punctuation.bracket"] = {
    fg = M.base_30.orange,
  },

  ["@string"] = {
    fg = M.base_30.white,
  },

  ["@field.key"] = {
    fg = M.base_30.white,
  },

  ["@constructor"] = {
    fg = M.base_30.vibrant_green,
    bold = true,
  },

  ["@tag.attribute"] = {
    link = "@method",
  },

  ["@keyword"] = {
    fg = M.base_1984.keyword,
  },

  Structure = {
    fg = M.base_1984.oop
  },

  Comment = {
    italic = true,
    fg = M.base_1984.comment_fg,
  },

  rustLifetime = {
    fg = M.base_1984.goog_blue,
  },

  NvimTreeCursorColumn = {
    fg = tailwind.green["800"],
    link = nil
  }
}

return M
