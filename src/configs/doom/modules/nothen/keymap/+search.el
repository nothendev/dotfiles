;;; nothen/keymap/+search.el -*- lexical-binding: t; -*-

(map!
 :leader
 :map evil-normal-state-map
 "ff" #'projectile-find-file
 "ps" #'projectile-switch-project
 "fd" #'projectile-find-dir
 "fw" #'+default/search-project
 "pL" #'projectile-edit-dir-locals
 "pn" #'projectile-add-known-project
 "pt" #'treemacs-projectile
 "pb" #'projectile-switch-to-buffer

 "ww" #'+workspace/cycle
 "wD" #'+workspace/delete
 "wn" #'+workspace/new
 "wR" #'+workspace/rename)
