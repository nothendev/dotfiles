(use-package! codeium
  :after cape
  :config
  (setq codeium/metadata/api_key (with-temp-buffer (insert-file-contents "~/.codeium")
                                                   (buffer-string)))
  (defalias 'my/codeium-complete
    (cape-interacive-capf #'codeium-completion-at-point))
  (map! :localleader
        :map evil-normal-state-map
        "c e" #'my/codeium-complete)
  (setq codeium-api-enabled
        (lambda (api)
          (memq api '(GetCompletions Heartbeat CancelRequest
                      GetAuthToken RegisterUser auth-redirect
                      AcceptCompletion)))))
