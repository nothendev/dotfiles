(map!
 :leader
 :map evil-normal-state-map
 "fm" #'+format/buffer
 "ca" #'lsp-execute-code-action
 "ra" #'lsp-rename)

(map!
 :map evil-normal-state-map
 "gd" #'+lookup/definition
 "gr" #'+lookup/references
 "gD" #'+lookup/type-definition
 "gi" #'+lookup/implementations)
