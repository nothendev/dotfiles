(map!
 :leader
 :map evil-normal-state-map
 "fm" #'+format/buffer
 "ca" #'lsp-ui-sideline-apply-code-actions)

(map!
 :map evil-normal-state-map
 "gd" #'lsp-find-definition
 "gr" #'lsp-find-references
 "gD" #'lsp-find-declaration
 "gi" #'lsp-find-implementation)
