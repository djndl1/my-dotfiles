;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "djndl1"
      user-mail-address "djndl1@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
 (setq doom-font (font-spec :family "Fira Code" :size 18 :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "sans" :size 17))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;
;;

;; enable EasyPG encryption
(require 'epa-file)
(epa-file-enable)

(load! "funcs.el")
(load! "org-mode-config.el")

;;
(remove-hook 'org-mode-hook #'evil-org-mode)
(add-hook 'org-mode-hook #'turn-off-evil-mode nil)


;; set up C# omnisharp installation
(require 'dap-netcore)
(setq dap-auto-configure-features '(sessions locals controls tooltip))
(setq lsp-csharp-server-path
      "/home/djn/opt/omnisharp/OmniSharp")

(setq dap-netcore-install-dir "/home/djn/opt/netcoredbg/")

;; set up java lsp
(setq lsp-java-server-install-dir "/home/djn/opt/jdtls")
(setq lsp-java-import-maven-enabled t)

;; set up XML lsp
(setq lsp-xml-jar-file "/home/djn/opt/xmllsp/xmllsp.jar")

;; set up python lsp

;; python
(require 'conda)
(conda-env-autoactivate-mode t)
(conda-env-initialize-interactive-shells)
(conda-env-initialize-eshell)
(add-hook 'find-file-hook (lambda () (when (bound-and-true-p conda-project-env-path)
                                          (conda-env-activate-for-buffer))))
(custom-set-variables
 '(conda-anaconda-home "~/opt/miniconda3/"))


(setq lsp-clients-clangd-args '("--background-index"
                                "--header-insertion=never"
                                "--fallback-style=none"
                                "-j=4"
                                "--clang-tidy"))

(use-package! vala-mode)

(use-package lsp-mode
  :commands lsp
  :config
  (add-to-list 'lsp-language-id-configuration '(vala-mode . "vala"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection
                                     '("vala-language-server"))
                    :major-modes '(vala-mode)
                    :server-id 'vala-ls)))

(defun my-vala-mode-hook-fn ()
  (setq c-basic-offset 4
        tab-width 8
        indent-tabs-mode nil)
  (company-mode 1)
  (local-set-key "\C-i" #'company-indent-or-complete-common)
  (lsp 1))

(use-package vala-mode
  :hook (vala-mode . my-vala-mode-hook-fn))

(add-hook 'org-mode-hook 'auto-fill-mode)

(scroll-bar-mode t)
(menu-bar-mode t)

(setq lsp-rust-analyzer-server-command "~/.local/bin/rust-analyzer")

;; (lsp-register-client
;;      (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
;;                       :major-modes '(c-mode c++-mode)
;;                       :remote? t
;;                       :server-id 'clangd-remote))
;;(server-start)

(defvar lsp-java-lombok--jar-path
  (if (boundp 'doom-cache-dir)
      (concat doom-cache-dir "lombok/lombok.jar")
    (concat user-emacs-directory ".local/cache/lombok/lombok.jar")))

(defun lsp-java-lombok-download ()
  "Download the latest lombok jar."
  (make-directory (f-dirname lsp-java-lombok--jar-path) t)
  (when (f-exists-p lsp-java-lombok--jar-path)
    (f-delete lsp-java-lombok--jar-path))
  (lsp--info "Downloading lombok...")
  (url-copy-file "https://projectlombok.org/downloads/lombok.jar"
                 lsp-java-lombok--jar-path))

(defun lsp-java-lombok-init ()
  "Download lombok and set vmargs."
  (unless (f-exists-p lsp-java-lombok--jar-path)
    (lsp-java-lombok-download))
  (add-to-list 'lsp-java-vmargs
               (concat "-javaagent:" lsp-java-lombok--jar-path)))

(setq lsp-java-vmargs (list
                       "-XX:+UseParallelGC"
                       "-XX:GCTimeRatio=4"
                       "-XX:AdaptiveSizePolicyWeight=90"
                       "-Dsun.zip.disableMemoryMapping=true"
                       "-Xmx2G"
                       "-Xms100m"
                       (concat "-javaagent:" lsp-java-lombok--jar-path)))

(setq magit-log-margin '(t "%Y-%m-%d %T" 30 t 8))
(setq doom-unreal-buffer-functions '(minibufferp))

(map! "C-x C-t v" #'visit-tags-table
      "C-x C-t a" #'tags-apropos) ; no need for this since there is xclip-mode

(setq url-proxy-services '(("no_proxy" . ".*")))
(setq read-quoted-char-radix 16)

(add-hook 'spell-fu-mode-hook
          (lambda()
            (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "en"))))

;; load visual-basic-mode

(autoload 'visual-basic-mode "~/.doom.d/modules/basic/visual-basic-mode.el" "Visual Basic mode." t)
(push '("\\.\\(?:frm\\|\\(?:ba\\|cl\\|vb\\)s\\)\\'" . visual-basic-mode)
        auto-mode-alist)


(autoload 'vba-mode "~/.doom.d/modules/basic/vba-mode.el" "VBA mode." t)

;; load fb-mode
(autoload 'fb-mode "~/.doom.d/modules/basic/fb-mode.el" "FB mode." t)
