;; (evil-define-key 'insert 'Company (kbd "TAB") 'company-select-next)
;; (evil-define-key 'insert 'Company (kbd "backtab") 'company-select-previous)
;; (evil-define-key 'insert 'Company (kbd "C-TAB") 'company-select-first)
;; (evil-define-key 'insert 'Company (kbd "C-S-TAB") 'company-select-last)

(map!
 :map company-mode-map
 "C-SPC" 'company-manual-begin)

(map!
 :map company-active-map

 "TAB" #'company-select-next
 "backtab" #'company-select-previous
 "C-TAB" #'company-select-first
 "C-S-TAB" #'company-select-last
 "RET" #'company-complete-selection

 ; unmap up and down for navigation, make them navigate the file instead.
 "<down>" nil
 "<up>" nil)
