# cargo-jump-xref

This Emacs extension help me to execute `xref-find-definitions` on a cargo dependency, jump to the dependency's source code.

```elisp
(use-package cargo-jump-xref
  :ensure 
  (:type git :host github :repo "eval-exec/cargo-jump-xref.el")
  :config
  (add-to-list 'xref-backend-functions #'cargo-jump-xref-backend))
```
