(map!
  :leader
  :map evil-normal-state-map
  "e o" #'treemacs
  "e e" #'treemacs-select-window)

(map! :map treemacs-mode-map
      "a" #'treemacs-create-file)
(map! :map treemacs-mode-map
      "A" #'treemacs-create-dir)
