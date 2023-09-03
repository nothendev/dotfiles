;;; nothen/keymap/+search.el -*- lexical-binding: t; -*-

(map!
 :leader
 :map evil-normal-state-map
 "ff" #'projectile-find-file
 "ps" #'projectile-switch-project
 "fd" #'projectile-find-dir
 "pw" #'projectile-ripgrep
 "pL" #'projectile-edit-dir-locals
 "pn" #'projectile-add-known-project
 "pt" #'treemacs-projectile
 "pb" #'projectile-switch-to-buffer)
