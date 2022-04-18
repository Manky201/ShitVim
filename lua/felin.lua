if not pcall(require, "feline") then
	return
  end
  local theme = {
	bg = '#eceff4',
	fg = '#eceff4',
  }
  local colors = {
	bg = "#4C566A",
	nord0_gui = "#ECEFF4", -- nord6 in palette
	nord1_gui = "#E5E9F0", -- nord5 in palette
	nord2_gui = "#D8DEE9", -- nord4 in palette
	nord3_gui = "#4C566A", -- nord3 in palette
	nord3_gui_bright = "#AEC7DF", -- out of palette
	nord4_gui = "#434C5E", -- nord2 in palette
	nord5_gui = "#3B4252", -- nord1 in palette
	nord6_gui = "#2E3440", -- nord0 in palette
	nord7_gui = "#8FBCBB", -- nord7 in palette
	nord8_gui = "#88C0D0", -- nord8 in palette
	nord9_gui = "#81A1C1", -- nord9 in palette
	nord10_gui = "#5E81AC", -- nord10 in palette
	nord11_gui = "#BF616A", -- nord11 in palette
	nord12_gui = "#D08770", -- nord12 in palette
	nord13_gui = "#EBCB8B", -- nord13 in palette
	nord14_gui = "#A3BE8C", -- nord14 in palette
	nord15_gui = "#B48EAD", -- nord15 in palette
	none = "NONE",
  }
  
  local vi_mode_colors = {
	  NORMAL = colors.nord9_gui,
	  INSERT = colors.nord8_gui,
	  VISUAL = colors.nord2_gui,
	  OP = colors.nord9_gui,
	  BLOCK = colors.nord12_gui,
	  REPLACE = colors.nord8_gui,
	  ['V-REPLACE'] = colors.nord8_gui,
	  ENTER = colors.nord7_gui,
	  MORE = colors.nord9_gui,
	  SELECT = colors.nord8_gui,
	  COMMAND = colors.nord9_gui,
	  SHELL = colors.nord13_gui,
	  TERM = colors.nord13_gui,
	  NONE = colors.nord15_gui
  }
  
  local function file_osinfo()
	  local os = vim.bo.fileformat:upper()
	  local icon
	  if os == 'UNIX' then
		  icon = ' '
	  elseif os == 'MAC' then
		  icon = ' '
	  else
		  icon = ' '
	  end
	  return icon .. os
  end
  
  local lsp = require 'feline.providers.lsp'
  local vi_mode_utils = require 'feline.providers.vi_mode'
  
  local lsp_get_diag = function(str)
	local count = vim.lsp.diagnostic.get_count(0, str)
	return (count > 0) and ' '..count..' ' or ''
  end
  
  -- LuaFormatter off
  
  local comps = {
	  vi_mode = {
		  left = {
			  provider = function()
				return '  ' .. vi_mode_utils.get_vim_mode()
			  end,
			  hl = function()
				  local val = {
					  name = vi_mode_utils.get_mode_highlight_name(),
					  bg = vi_mode_utils.get_mode_color(),
					  fg = colors.nord6_gui
					  -- fg = colors.bg
				  }
				  return val
			  end,
			  right_sep = '',
		  },
		  right = {
			  provider = '▊',
			  --provider = '' ,
			  hl = function()
				  local val = {
					  name = vi_mode_utils.get_mode_highlight_name(),
					  fg = vi_mode_utils.get_mode_color()
				  }
				  return val
			  end,

		  }
	  },
	  file = {
		  info = {
			  provider = {
				name = 'file_info',
				opts = {
				  type = 'relative-short',
				  file_readonly_icon = '   ',
				  -- file_readonly_icon = '  ',
				  -- file_readonly_icon = '  ',
				  -- file_readonly_icon = '  ',
				  -- file_modified_icon = '',
				  file_modified_icon = '  ',
				  -- file_modified_icon = 'ﱐ',
				  -- file_modified_icon = '',
				  -- file_modified_icon = '',
				  -- file_modified_icon = '',
				}
			  },
			  left_sep  = ' ',
			  right_sep = '',
			  
			  hl = {
				  fg = colors.nord8_gui,
				  bg = colors.nord6_gui,
				  style = 'bold'
			  }
		  },
		  encoding = {
			  provider = 'file_encoding',
			  left_sep = '',
			  right_sep = '',
			  hl = {
				  fg = colors.nord3_gui,
				  bg = colors.nord3_gui_bright,
				  style = 'bold'
			  }
		  },
		  type = {
			  provider = 'file_type'
		  },
		  os = {
			  provider = file_osinfo,
			  left_sep = '',
			  right_sep = '',
			  hl = {
				  fg = colors.nord3_gui,
				  bg = colors.nord3_gui_bright,
				  style = 'bold'
			  }
		  },
		  position = {
			  provider = 'position',
			  left_sep = '',
			  right_sep = '',
			  hl = {
				  fg = colors.nord3_gui,
				  bg = colors.nord3_gui_bright,
				  -- style = 'bold'
			  }
		  },
	  },
	  left_end = {
		  provider = function() return '' end,
		  hl = {
			  fg = colors.bg,
			  bg = colors.blue,
		  }
	  },
	  line_percentage = {
		  provider = 'line_percentage',
		  left_sep = '',
		  hl = {
			  style = 'bold',
			  bg = colors.nord9_gui,
			  fg = colors.nord6_gui
		  }
	  },

	  diagnos = {
		  err = {
			  -- provider = 'diagnostic_errors',
			  provider = function()
				  return '' .. lsp_get_diag("Error")
			  end,
			  -- left_sep = ' ',
			  enabled = function() return lsp.diagnostics_exist('Error') end,
			  hl = {
				  fg = colors.red
			  }
		  },
		  warn = {
			  -- provider = 'diagnostic_warnings',
			  provider = function()
				  return '' ..  lsp_get_diag("Warning")
			  end,
			  -- left_sep = ' ',
			  enabled = function() return lsp.diagnostics_exist('warn') end,
			  hl = {
				  fg = colors.yellow
			  }
		  },
		  info = {
			  -- provider = 'diagnostic_info',
			  provider = function()
				  return '' .. lsp_get_diag("Information")
			  end,
			  -- left_sep = ' ',
			  enabled = function() return lsp.diagnostics_exist('info') end,
			  hl = {
				  fg = colors.blue
			  }
		  },
		  hint = {
			  -- provider = 'diagnostic_hints',
			  provider = function()
				  return '' .. lsp_get_diag("Hint")
			  end,
			  -- left_sep = ' ',
			  enabled = function() return lsp.diagnostics_exist('Hint') end,
			  hl = {
				  fg = colors.cyan
			  }
		  },
	  },
	  lsp = {
		  name = {
			  provider = 'lsp_client_names',
			  -- left_sep = ' ',
			  right_sep = ' ',
			  -- icon = '  ',
			  icon = '慎',
			  hl = {
				  fg = colors.yellow
			  }
		  }
	  },
	  git = {
		  branch = {
			  provider = 'git_branch',
			  icon = ' ',
			  -- icon = ' ',
			  left_sep = ' ',
			  hl = {
				  fg = colors.violet,
				  style = 'bold'
			  },
		  },
		  add = {
			  provider = 'git_diff_added',
			  hl = {
				  fg = colors.green
			  }
		  },
		  change = {
			  provider = 'git_diff_changed',
			  hl = {
				  fg = colors.orange
			  }
		  },
		  remove = {
			  provider = 'git_diff_removed',
			  hl = {
				  fg = colors.red
			  }
		  }
	  }
  }
  
  local components = {
	active = {},
	inactive = {},
  }
  
  table.insert(components.active, {})
  table.insert(components.active, {})
  table.insert(components.active, {})
  table.insert(components.inactive, {})
  table.insert(components.inactive, {})
  table.insert(components.inactive, {})
  
  table.insert(components.active[1], comps.vi_mode.left)
  table.insert(components.active[1], comps.file.info)
  table.insert(components.active[1], comps.git.branch)
  table.insert(components.active[1], comps.git.add)
  table.insert(components.active[1], comps.git.change)
  table.insert(components.active[1], comps.git.remove)
  table.insert(components.inactive[1], comps.vi_mode.left)
  table.insert(components.inactive[1], comps.file.info)
  table.insert(components.active[3], comps.diagnos.err)
  table.insert(components.active[3], comps.diagnos.warn)
  table.insert(components.active[3], comps.diagnos.hint)
  table.insert(components.active[3], comps.diagnos.info)
  table.insert(components.active[3], comps.lsp.name)
  table.insert(components.active[3], comps.file.os)
  table.insert(components.active[3], comps.file.position)
  table.insert(components.active[3], comps.line_percentage)
  --table.insert(components.active[3], comps.scroll_bar)
  table.insert(components.active[3], comps.vi_mode.right)
  
  
  -- TreeSitter
  -- local ts_utils = require("nvim-treesitter.ts_utils")
  -- local ts_parsers = require("nvim-treesitter.parsers")
  -- local ts_queries = require("nvim-treesitter.query")
  --[[ table.insert(components.active[2], {
	provider = function()
	  local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
	  return ("%d:%s [%d, %d] - [%d, %d]")
		:format(node:symbol(), node:type(), node:range())
	end,
	enabled = function()
	  local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
	  return ok and ts_parsers.has_parser()
	end
  }) ]]
  
  -- require'feline'.setup {}
  require'feline'.setup {
	  -- colors = { bg = theme.bg, fg = theme.fg },
	  theme = colors,
	  default_bg = colors.nord5_gui,
	  default_fg = colors.nord5_gui,
	  components = components,
	  vi_mode_colors = vi_mode_colors,
	  force_inactive = {
		  filetypes = {
			  'packer',
			  'NvimTree',
			  'fugitive',
			  'fugitiveblame'
		  },
		  buftypes = {'terminal'},
		  bufnames = {}
	  }
  }