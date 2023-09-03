(load! "./+company.el")
(load! "./+centaur.el")
(load! "./+treemacs.el")
(load! "./+lsp.el")
(load! "./+search.el")

(evil-define-key nil 'global (kbd "C-S") 'save-buffer)

(defun nothen-toggle-transparency ()
  (interactive)
  (if (eq (frame-parameter nil 'alpha-background) nothen-transparency)
      (set-frame-parameter nil 'alpha-background 100)
    (set-frame-parameter nil 'alpha-background nothen-transparency)))

(map! :leader "d t" #'nothen-toggle-transparency)
