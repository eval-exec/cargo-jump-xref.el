# cargo-jump-xref

When I working on `Cargo.toml` file, this `cargo-jump-xref.el` help me to execute `xref-find-definitions` on a cargo dependency, jump to the dependency's source code.


You need to add `cargo-jump-xref-backend` to `xref-backend-functions`, then you can execute `xref-find-definitions` on `Cargo.toml` buffer.

```elisp
(use-package cargo-jump-xref
  :ensure 
  (:type git :host github :repo "eval-exec/cargo-jump-xref.el")
  :config
  (add-to-list 'xref-backend-functions #'cargo-jump-xref-backend))
```
