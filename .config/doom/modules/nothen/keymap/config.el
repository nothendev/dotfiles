(load! "./+company.el")
(load! "./+centaur.el")
(load! "./+treemacs.el")
(load! "./+lsp.el")
(load! "./+search.el")

(defun inverse-linenumber(linenumber)
  (if (eq linenumber 'relative)
      t
    'relative))

(defun nothen-switch-relative-linenumber()
  (interactive)
  (setq display-line-numbers-type (inverse-linenumber display-line-numbers-type)))

(evil-define-key nil 'global (kbd "C-S") 'save-buffer)
(map!
 :leader
 "r n" #'nothen-switch-relative-linenumber)
