# cargo-jump-xref

When I working on `Cargo.toml` file, this `cargo-jump-xref.el` help me to execute `xref-find-definitions` on a cargo dependency, jump to the dependency's source code.


You need to add `cargo-jump-xref-backend` to `xref-backend-functions`, then you can open a `Cargo.toml` file, move cursor on a cargo dependency, execute `xref-find-definitions` will jump to the cargo dependency's source file.

```elisp
(use-package cargo-jump-xref
  :ensure 
  (:type git :host github :repo "eval-exec/cargo-jump-xref.el")
  :config
  (add-to-list 'xref-backend-functions #'cargo-jump-xref-backend))
```
