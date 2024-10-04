
(require 'cl-lib)
(require 'xref)
(require 'toml)


(defun cargo-jump-dependency(symbol)
  (interactive)
  ;; execute the command: cargo metadata --manifest-path sync/Cargo.toml | jq -r '.packages.[] | select(.name=="futures").manifest_path'
  ;; and the output should be a file, then jump to the file, readonly
  (let* ((cmd (format "cargo metadata --manifest-path %s 2>/dev/null | jq -r '.packages.[] | select(.name==\"%s\").manifest_path'"
					  (buffer-file-name)
					  symbol))
		 (file (string-trim (shell-command-to-string cmd)))
		 (base-dir (file-name-directory file))
		 (lib-file (expand-file-name "src/lib.rs" base-dir)))
	(unless (string-empty-p file)
	  (list
	   (xref-make "summary"
				  (xref-make-file-location lib-file 1 1))))))

;;;###autoload
(defgroup cargo-jump-xref nil
  "Xref backend using for Cargo.toml"
  :group 'xref)

;;;###autoload
(defun cargo-jump-xref-backend ()
  "cargo jump backend for Xref."
  ;; when current buffer's file is `Cargo.toml', then use this backend
  (when (and
		 (buffer-file-name)
		 (string= "Cargo.toml" (file-name-nondirectory (buffer-file-name))))
    'cargo-jump-xref))



(cl-defmethod xref-backend-identifier-at-point ((_backend (eql cargo-jump-xref)))
  (let ((current-symbol (symbol-at-point)))
    (when current-symbol
      (symbol-name current-symbol))))

(cl-defmethod xref-backend-definitions ((_backend (eql cargo-jump-xref)) symbol)
  (cargo-jump-dependency symbol))

(cl-defmethod xref-backend-references ((_backend (eql cargo-jump-xref)) symbol)
  nil)

(cl-defmethod xref-backend-apropos ((_backend (eql cargo-jump-xref)) symbol)
  nil)

(cl-defmethod
  xref-backend-identifier-completion-table ((_backend (eql cargo-jump-xref)))
  "Return a list of terms for completions taken from the symbols in the current buffer.
The current implementation returns all the words in the buffer,
which is really sub optimal."
  nil)



(provide 'cargo-jump-xref)
