
(defun copy-to-clipboard()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "xsel -bi"))

(defun copy-file-directory-to-clipboard()
  (interactive)
  (kill-new default-directory))
