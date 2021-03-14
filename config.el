;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)
(setq doom-nord-brighter-modeline :false)

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

;; Node versions must be set so tsserver works.
(setq exec-path (append exec-path '("/Users/sean.hellebusch/.nvm/versions/node/v14.15.1/bin/")))
(setq tide-tsserver-executable "/Users/sean.hellebusch/.nvm/versions/node/v14.15.1/bin/tsserver")

(use-package!
  projectile
  :diminish projectile-mode
  :delight '(:eval (concat " [" (projectile-project-name) "]"))
  :bind (("C-w" . helm-projectile-find-file)
         ("C-c p i" . projectile-invalidate-cache))
  :config (progn
            (setq projectile-completion-system 'default)
            (setq projectile-enable-caching t)
            (setq projectile-indexing-method 'alien)
            (add-to-list 'projectile-globally-ignored-files "node_modules")
            (add-to-list 'projectile-globally-ignored-directories "node_modules")
            (add-to-list 'projectile-globally-ignored-directories "vendor"))
  :config (projectile-global-mode))

(use-package! helm
  :delight
  :bind (("M-x" . helm-M-x)
         ("C-x b" . helm-mini)
         ("M-y" . helm-show-kill-ring)
         ("C-x C-f" . helm-find-files)
         ("C-c o" . helm-projectile-switch-project)
         ("M-s M-p" . helm-projectile-ag)
         ("C-," . helm-mini))
  :config (helm-mode 1));;

(use-package! windmove
  :bind
  (("<f2> <right>" . windmove-right)
   ("<f2> <left>" . windmove-left)
   ("<f2> <up>" . windmove-up)
   ("<f2> <down>" . windmove-down)
   ))

(map! "s-k" #'kill-buffer
      "s-u" #'revert-buffer)

(use-package! simpleclip
  :diminish simpleclip-mode
  :config
  (simpleclip-mode 1))

(use-package ace-jump-mode)
(global-set-key (kbd "M-;") 'ace-jump-char-mode)
(global-set-key (kbd "M-'") 'ace-jump-mode-pop-mark)

;; Set autosave location
;; http://pages.sachachua.com/.emacs.d/Sacha.html#org7b1ada1
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; set "Yes" or "No" interactive answers to "y" or "n"
(fset 'yes-or-no-p 'y-or-n-p)
