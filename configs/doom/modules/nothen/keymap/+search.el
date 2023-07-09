;;; nothen/keymap/+search.el -*- lexical-binding: t; -*-

(map!
 :leader
 :map evil-normal-state-map
 "ff" #'find-file)
