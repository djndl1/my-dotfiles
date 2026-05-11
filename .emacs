;;; set up straight.el 
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'evil)
;;; themes
(straight-use-package 'doom-themes)
;;; project management
(straight-use-package 'magit)
(straight-use-package 'projectile)

(straight-use-package 'sly)
(straight-use-package 'diff-hl)

;;; snippet template engine
(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)

;;; outline and menu
(straight-use-package 'counsel)
(straight-use-package 'counsel-projectile)
;;; copy
(straight-use-package 'clipetty)
;;; completion
(straight-use-package 'company)
(straight-use-package 'company-math) ; for Latex
(straight-use-package 'company-shell) ; for shell scripting
;;; linting
(straight-use-package 'flymake)

;;; LSP support
(straight-use-package 'eglot)

;;; eval-print
(straight-use-package 'quickrun)

;;; vala
(straight-use-package 'vala-mode)

(evil-mode 1)
(global-clipetty-mode)
(setq x-select-enable-clipboard t)
(ivy-mode)
(setopt ivy-use-virtual-buffers t)
(setopt enable-recursive-minibuffers t)
;; Enable this if you want `swiper' to use it:
;; (setopt search-default-mode #'char-fold-to-regexp)
(keymap-global-set "C-c s i" #'swiper-isearch)
(keymap-global-set "C-c C-r" #'ivy-resume)

(keymap-global-set "M-x" #'counsel-M-x)
(keymap-global-set "C-x C-f" #'counsel-find-file)

(keymap-global-set "C-x 8" #'counsel-unicode-char)
(keymap-global-set "C-c g" #'counsel-git)
(keymap-global-set "C-c j" #'counsel-git-grep)


(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(add-hook 'after-init-hook 'global-company-mode)
(keymap-set minibuffer-local-map "C-r" #'counsel-minibuffer-history)

(global-set-key (kbd "C-x h") 'help)
(global-set-key (kbd "<f1> .") 'eldoc)
(define-key key-translation-map (kbd "C-h") (kbd "DEL"))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(column-number-mode 1)
(electric-pair-mode 1)
(global-hl-line-mode)
(global-company-mode 1)

(tab-bar-mode)
(display-fill-column-indicator-mode)

(add-hook 'org-mode-hook
          (lambda ()
            (setq fill-column 100)
            (turn-on-auto-fill)))

(defun enable-csharp-lsp ()
  (eglot))

(add-hook 'csharp-mode #'enable-csharp-lsp)
	  

(setq etags-regen-progra "ctags")
(setq etags-regen-program-option "--recursive=yes")
(etags-regen-mode 1)
(auto-revert-mode)

;; set up yasnippet directory
(setq yas-snippet-dirs '("~/.doom.d/snippets/"))
(yas-global-mode 1)

;; OSC52 
;(setq xterm-extra-capabilities '(getSelection setSelection))
(global-clipetty-mode 1)
;(setq osc52-select-text t)
;(setq select-enable-clipboard t)
;(setq select-enable-primary t)
(setq completion-styles '(basic partial-completion flex))
(require 'diff-hl)
(global-hl-line-mode 1)

(defun append-shell-company-backends ()
  ((setq-local company-backends '((company-capf
				   company-shell
				   company-shell-env
				   company-keywords
				   :with company-etags
				   company-dabbrev-code
				   company-yasnippet))))
     )
(add-hook 'shell-mode-hook #'append-shell-company-backends)


;;; Register vala-mode with vala-language-server
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(vala-mode . ("vala-language-server")))
  )
(add-hook 'eglot-managed-mode-hook
	  (lambda ()
	    (keymap-local-set "M-s i" #'eglot-find-implementation)
	    (keymap-local-set "M-s f" #'eglot-format-buffer)
	    (keymap-local-set "M-s r" #'eglot-rename)
	    (keymap-local-set "M-s c" #'eglot-code-action-suggestion)))

(setq ediff-split-window-function 'split-window-horizontally)

(use-package doom-themes
  :ensure nil
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-line-numbers-type 'relative)
 '(global-display-line-numbers-mode t)
 '(safe-local-variable-directories '("/home/djn/CISDIWorkSpace/"))
 '(safe-local-variable-values '((org-cite-csl-styles-dir . "~/Notes/CSNotes/resources/")))
 '(tab-bar-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Cascadia Mono" :foundry "SAJA" :slant normal :weight regular :height 98 :width normal)))))

(when (file-exists-p "~/.emacs.d/site.el")
  (load "~/.emacs.d/site.el"))
