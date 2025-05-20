;;; ../../dotfiles/configs/doom/bindings.el -*- lexical-binding: t; -*-

(map! :leader
      "f w" #'consult-ripgrep
      "f m" #'+format/buffer)
