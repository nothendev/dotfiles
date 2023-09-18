(defun nothen-close-tab ()
  "close current tab."
  (interactive)
  (kill-buffer)
)

;; tabs
(evil-define-key 'normal 'global (kbd "<tab>") 'centaur-tabs-forward)
(evil-define-key 'normal 'global (kbd "M-<tab>") 'centaur-tabs-forward)
(evil-define-key 'normal 'global (kbd "<backtab>") 'centaur-tabs-backward)
(evil-define-key 'normal 'global (kbd "M-<iso-lefttab>") 'centaur-tabs-backward)
(map!
 :leader
 :map evil-normal-state-map
 "x" #'nothen-close-tab)
