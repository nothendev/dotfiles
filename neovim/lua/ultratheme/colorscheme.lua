local config = require'ultratheme.config'
local C = {}

C.editorBackground = config.transparent and 'none' or '#0f111a'
C.sidebarBackground = '#0f111a'
C.popupBackground = '#0f111a'
C.floatingWindowBackground = '#0f111a'
C.menuOptionBackground = '#0f111a'

C.mainText = '#babed8'
C.emphasisText = '#babed8'
C.commandText = '#babed8'
C.inactiveText = ''
C.disabledText = ''
C.lineNumberText = ''

return C
