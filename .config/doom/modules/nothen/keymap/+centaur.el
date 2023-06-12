(defun nothen-close-tab ()
  "close current tab."
  (interactive)
  (centaur-tabs-buffer-close-tab (centaur-tabs-selected-tab (centaur-tabs-current-tabset)))
)

;; tabs
(evil-define-key 'normal 'global (kbd "<tab>") 'centaur-tabs-forward)
(evil-define-key 'normal 'global (kbd "<backtab>") 'centaur-tabs-backward)
(map!
 :leader
 :map evil-normal-state-map
 "x" #'nothen-close-tab)
