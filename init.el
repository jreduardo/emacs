;;----------------------------------------------------------------------
;;                             Eduardo E. R. Junior <edujrrib@gmail.com>
;;                         leg.ufpr.br/~eduardojr · github.com/jreduardo
;;                                               2019-Feb-05 · SP/Brazil
;;----------------------------------------------------------------------
;; Configuration file to Emacs adapted/copied from Walmes Zeviani.

;;----------------------------------------------------------------------
;; Basic definitions.
;;----------------------------------------------------------------------

;; Add directory with supplementary configuration files.
(add-to-list 'load-path "~/.emacs.d/lisp/")
(tool-bar-mode -1)                  ;; Don't display tool bar
(menu-bar-mode -1)                  ;; Don't display menu bar
(global-linum-mode 1)               ;; Line numbers
(global-hl-line-mode 1)             ;; Highlight the cursor line.
(visual-line-mode 1)                ;; Screen lines, not logical lines.
(show-paren-mode 1)                 ;; Highlight matching pairs.
(delete-selection-mode 1)           ;; Allows delete region.
(setq column-number-mode t)         ;; Show cursor position.
(setq auto-save-default nil)        ;; Turn off #autosave#.
(setq make-backup-files nil)        ;; Turn off backup~.
(setq comment-empty-lines t)        ;; Comment even in empty lines.
(setq x-select-enable-clipboard t)  ;; Allow shared transfer area.
(setq-default indent-tabs-mode nil) ;; Spaces to indent.
(setq-default fill-column 72)       ;; Column width.
;; (setq-default auto-fill-function
;;               'do-auto-fill)        ;; Auto break long lines.

;; Maximize initial frame on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Highlight whitespace.
(setq whitespace-line-column fill-column)
(setq whitespace-style
      '(face lines-tail trailing tabs empty))
(global-whitespace-mode +1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Open Emacs without start-up screen.
(setq inhibit-startup-screen t)
(add-hook 'emacs-startup-hook 'delete-other-windows)[/code]

;; Font and size.
(cond
 ((find-font (font-spec :name "Inconsolata"))
  (set-default-font "Inconsolata-12"))
 (t
  (set-default-font "Ubuntu Mono-12")))

;; (set-default-font "Noto Sans Mono-14")
;; (set-default-font "Inconsolata-14")
;; (cond ((string-equal system-name "camus")
;;        (set-default-font "Noto Sans Mono-14"))
;;       ((string-equal system-name "ulisses")
;;        (set-default-font "Ubuntu Mono-16"))
;;       ((string-equal system-name "youngest")
;;        (set-default-font "Ubuntu Mono-16"))
;;       ((string-equal system-name "class")
;;        (set-default-font "Ubuntu Mono-14")))

;; Turn ido-mode on.
(ido-mode t)

;;----------------------------------------------------------------------
;; Key bindings.
;;----------------------------------------------------------------------

;; C-TAB to move the cursor between visible buffers.
(global-set-key [(control tab)] 'other-window)

;; C-page down e C-page up to move along buffers.
(global-set-key (kbd "C-<next>") 'next-buffer)
(global-set-key (kbd "C-<prior>") 'previous-buffer)

;; C-z to 'undo, the default is C-/.
(global-unset-key "\C-z")
(global-set-key "\C-z" 'undo)

;; M-. to (un)comment paragraph.
(global-set-key [?\M-.] (kbd "M-h M-; M-}"))

;; M-+ to indent paragraph.
(global-set-key [?\M-+] (kbd "M-h C-M-\\"))

;; "C-~" to keep one white space between objects around point.
(global-set-key (kbd "<C-dead-tilde>") 'fixup-whitespace)

;; "M-~" to joint lines.
(global-set-key (kbd "<M-dead-tilde>") 'delete-indentation)

;; S-F11 and S-F12 to show/hide menu bar and tool bar.
(global-set-key (kbd "<S-f11>") 'toggle-menu-bar-mode-from-frame)
(global-set-key (kbd "<S-f12>") 'toggle-tool-bar-mode-from-frame)

;;----------------------------------------------------------------------
;; My functions.
;;----------------------------------------------------------------------

;; Byte compile file.
;; (byte-compile-file "~/.emacs.d/lisp/funcs.el")

(require 'funcs)

;; (add-hook 'find-file-hook
;;           (lambda ()
;;              (replace-buffer-divisions-by-Walmes-style
;;               (point-min) (point-max) "#")
;;             ))

;;----------------------------------------------------------------------
;; Extensions.
;;----------------------------------------------------------------------

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize))

;;----------------------------------------------------------------------
;; Color themes. Options > Customize Emacs > Custom Themes
;; https://emacsthemes.com/

;; M-x disable-theme
;; M-x load-theme RET <theme> RET

;;-------------------------------------------
;; Dark.

;; (load-theme 'monokai t)
;; (set-face-attribute hl-line-face nil :background "#171816")

;; (load-theme 'molokai t)
;; (load-theme 'gotham t)
(load-theme 'solarized-dark t)

;;-------------------------------------------
;; Light.

;; (load-theme 'flatui t)
;; (load-theme 'leuven t)
;; (load-theme 'solarized t)

;; (require 'use-package)
;; (use-package spacemacs-theme
;;   :ensure t
;;   :init
;;   (load-theme 'spacemacs-light t))

;;----------------------------------------------------------------------
;; helm.
;; http://tuhdo.github.io/helm-intro.html

;; (when (not (package-installed-p 'helm))
;;   (package-install 'helm))

(require 'helm)
(require 'helm-config)
;; (require 'helm-R)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(when (executable-find "ack-grep")
  (setq helm-grep-default-command
        "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command
        "ack-grep -H --no-group --no-color %e %p %f"))

(setq helm-split-window-in-side-p           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t
      helm-M-x-fuzzy-match                  t
      helm-buffers-fuzzy-matching           t
      helm-recentf-fuzzy-match              t
      helm-locate-fuzzy-match               t
      helm-apropos-fuzzy-match              t
      helm-lisp-fuzzy-completion            t
      helm-semantic-fuzzy-match             t
      helm-imenu-fuzzy-match                t)

(helm-mode 1)
(helm-autoresize-mode t)

(global-set-key (kbd "C-c h")   'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "M-y")     'helm-show-kill-ring)
(global-set-key (kbd "C-x b")   'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)

(add-to-list 'helm-sources-using-default-as-input
             'helm-source-man-pages)

;;----------------------------------------------------------------------
;; Company.

;; (when (not (package-installed-p 'company))
;;   (package-install 'company))

(require 'company)
;; (add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay             0.2
      company-minimum-prefix-length  2
      company-require-match          nil
      company-dabbrev-ignore-case    nil
      company-dabbrev-downcase       nil
      company-frontends              '(company-pseudo-tooltip-frontend))

;;----------------------------------------------------------------------

(require 'iso-transl) ;; To work the accents on Sony Vaio.

;;----------------------------------------------------------------------
;; Magit.

;; (when (not (package-installed-p 'magit))
;;   (package-install 'magit))

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;;----------------------------------------------------------------------
;; essh.el - ESS like shell mode. To eval line/regions in Emacs shell.

;; Byte compile file.
;; (byte-compile-file "~/.emacs.d/lisp/essh.el")

(require 'essh)
(add-hook
 'sh-mode-hook
 '(lambda ()
    (define-key sh-mode-map "\C-c\C-r" 'pipe-region-to-shell)
    (define-key sh-mode-map "\C-c\C-b" 'pipe-buffer-to-shell)
    (define-key sh-mode-map "\C-c\C-j" 'pipe-line-to-shell)
    (define-key sh-mode-map "\C-c\C-n" 'pipe-line-to-shell-and-step)
    (define-key sh-mode-map "\C-c\C-f" 'pipe-function-to-shell)
    (define-key sh-mode-map "\C-c\C-d" 'shell-cd-current-directory)))

;;----------------------------------------------------------------------
;; Bookmark-plus.

(setq bookmark-default-file "~/Dropbox/bookmarks"
      bookmark-save-flag 1)

;; (when (not (package-installed-p 'bookmark+))
;;   (package-install 'bookmark+))

;; Byte compile file.  Faster load and execution.
;; http://ergoemacs.org/emacs/emacs_byte_compile.html
;; (byte-recompile-directory "~/.emacs.d/elpa/bookmark+" 0 t)

(add-to-list 'load-path "~/.emacs.d/elpa/bookmark+")

(require 'bookmark+)

;; Create an autonamed bookmark.
(global-set-key (kbd "<C-f3>")
                'bmkp-toggle-autonamed-bookmark-set/delete)
;; Go to the next bookmark in file.
(global-set-key (kbd "<f3>")
                'bmkp-next-bookmark-this-file/buffer-repeat)
;; Go to the previous bookmark in file.
(global-set-key (kbd "<f4>")
                'bmkp-previous-bookmark-this-file/buffer-repeat)
;; Toggle temporary/permanent bookmark.
(global-set-key (kbd "<S-f3>")
                'bmkp-toggle-temporary-bookmark)

;;----------------------------------------------------------------------
;; Visible bookmarks. Easy movement.
;; https://marmalade-repo.org/packages/bm

;; (when (not (package-installed-p 'bm))
;;   (package-install 'bm))

(require 'bm)

;; Customize the colors by using M-x customize-group RET bm RET
(setq bm-marker 'bm-marker-left)
(setq bm-highlight-style 'bm-highlight-only-fringe)

(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

;;----------------------------------------------------------------------
;; Folding code blocks based on indentation.
;; git clone https://github.com/zenozeng/yafolding.el.git

;; (when (not (package-installed-p 'yafolding))
;;   (package-install 'yafolding))

(require 'yafolding)
(global-set-key [?\C-{] #'yafolding-hide-parent-element)
(global-set-key [?\C-}] #'yafolding-toggle-element)

;;----------------------------------------------------------------------
;; Smart Parenthesis.
;; https://github.com/Fuco1/smartparens.

;; (when (not (package-installed-p 'smartparens))
;;   (package-install 'smartparens))

(require 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode 1)

(sp-pair "\"" nil :unless '(sp-point-after-word-p))
(sp-pair "'" nil :unless '(sp-point-after-word-p))

;;----------------------------------------------------------------------
;; MarkDown extensions.
;; (IT MUST BE BEFORE LATEX EXTENSIONS.)

;; (when (not (package-installed-p 'markdown-mode))
;;   (package-install 'markdown-mode))

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'"       . markdown-mode))

;; Org-struct minor mode active in markdown mode.
(add-hook 'markdown-mode-hook 'turn-on-orgstruct)
(add-hook 'markdown-mode-hook 'turn-on-orgstruct++)

;; Enable Index at the menu bar with the TOC of markdown document.
(add-hook 'markdown-mode-hook 'imenu-add-menubar-index)
(setq imenu-auto-rescan t)

;; https://leanpub.com/markdown-mode/read -> section 4.6.
(require 'imenu-list)
(setq imenu-list-focus-after-activation t
      imenu-list-auto-resize nil)

;; Uses F10 to toggle the TOC sidebar for easy navigation.
(add-hook 'markdown-mode-hook
          '(lambda()
             (global-set-key (kbd "<f10>") 'imenu-list-smart-toggle)))

;;----------------------------------------------------------------------
;; R+MarkDown extensions (emacs >= 24.3.1).
;; (IT MUST BE BEFORE LATEX EXTENSIONS.)

;; (when (not (package-installed-p 'polymode))
;;   (package-install 'polymode))

(use-package poly-markdown
             :ensure t)
(use-package poly-R
             :ensure t)

;; (autoload 'poly-markdown-mode "poly-markdown-mode"
;;   "Major mode for editing R-Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.[Rr]md" . poly-markdown+r-mode))
(add-to-list 'auto-mode-alist '("\\.[Rr]md" . poly-markdown-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))

;;----------------------------------------------------------------------
;; ESS - Emacs Speaks Statistics.
;; http://ess.r-project.org/

;; (when (not (package-installed-p 'ess))
;;   (package-install 'ess))

(require 'ess-site)

(setq-default ess-dialect "R")
(setq-default inferior-R-args "--no-restore-history --no-save ")

(require 'ess-view)
(setq ess-view--spreadsheet-program "gnumeric")

(defadvice ess-eval-buffer (before really-eval-buffer compile activate)
  "Prevent call ess-eval-buffer by accident, frequently by
   hitting C-c C-b instead of C-c C-n."
  (if (yes-or-no-p
       (format "Are you sure you want to evaluate the %s buffer?"
               buffer-file-name))
      (message "ess-eval-buffer started.")
    (error "ess-eval-buffer canceled!")))

(add-hook
 'ess-mode-hook
 '(lambda()
    (ess-toggle-underscore nil)
    (define-key ess-mode-map [?\M--]
      'ess-cycle-assign) ;; `Alt + -'  to cycle `<- | <<- | = ...'.
    (auto-complete-mode 1)
    (company-mode 1)                               ;; (company-mode -1)
    (define-key ess-mode-map [f5] 'company-R-args) ;; F5 do show ARGS.
    (setq ess-indent-with-fancy-comments nil) ;; No indent levels.
    (setq-local comment-add 0)                ;; Single # as default.
    (setq ess-smart-operators t)              ;; Smart comma.
    (setq comint-scroll-to-bottom-on-input t)
    (setq comint-scroll-to-bottom-on-output t)
    (setq comint-move-point-for-output t)))

;; Script and console font lock highlight.
(setq ess-R-font-lock-keywords
      '((ess-R-fl-keyword:modifiers . t)
        (ess-R-fl-keyword:fun-defs . t)
        (ess-R-fl-keyword:keywords . t)
        (ess-R-fl-keyword:assign-ops . t)
        (ess-R-fl-keyword:constants . t)
        (ess-fl-keyword:fun-calls . t)
        (ess-fl-keyword:numbers . t)
        (ess-fl-keyword:operators . t)
        (ess-fl-keyword:delimiters . t)
        (ess-fl-keyword:= . t)
        (ess-R-fl-keyword:F&T . t)))
(setq inferior-R-font-lock-keywords
      '((ess-S-fl-keyword:prompt . t)
        (ess-R-fl-keyword:messages . t)
        (ess-R-fl-keyword:modifiers . t)
        (ess-R-fl-keyword:fun-defs . t)
        (ess-R-fl-keyword:keywords . t)
        (ess-R-fl-keyword:assign-ops . t)
        (ess-R-fl-keyword:constants . t)
        (ess-fl-keyword:matrix-labels . t)
        (ess-fl-keyword:fun-calls . t)
        (ess-fl-keyword:numbers . t)
        (ess-fl-keyword:operators . t)
        (ess-fl-keyword:delimiters . t)
        (ess-fl-keyword:= . t)
        (ess-R-fl-keyword:F&T . t)))

;; Movement across chunks in Rnw files.
(global-set-key (kbd "C-S-<f5>") 'ess-eval-chunk)
(global-set-key (kbd "C-S-<f6>") 'ess-eval-chunk-and-step)
(global-set-key (kbd "C-S-<f7>") 'ess-noweb-next-code-chunk)
(global-set-key (kbd "C-S-<f8>") 'ess-noweb-previous-code-chunk)
(global-set-key (kbd "C-S-<f9>") 'ess-noweb-goto-chunk)

(dolist (mode '(ess-mode-hook lisp-mode-hook))
  (add-hook mode
            '(lambda ()
               (global-set-key (kbd "<M-right>")  'forward-sexp)
               (global-set-key (kbd "<M-left>")   'bakward-sexp)
               (global-set-key (kbd "<M-down>")   'forward-list)
               (global-set-key (kbd "<M-up>")     'backward-list)
               (global-set-key (kbd "<M-S-up>")   'backward-up-list)
               (global-set-key (kbd "<M-S-down>") 'down-list))))

;;----------------------------------------------------------------------
;; Auto complete mode for Emacs.

;; (when (not (package-installed-p 'auto-complete))
;;   (package-install 'auto-complete))

(require 'auto-complete-config)
(ac-config-default)

(setq ac-auto-start 0
      ac-delay 0.2
      ac-quick-help-delay 1.
      ac-use-fuzzy t
      ac-fuzzy-enable t
      ;; use 'complete when auto-complete is disabled
      tab-always-indent 'complete
      ac-dwim t)

(setq-default ac-sources '(ac-source-abbrev
                           ac-source-dictionary
                           ac-source-words-in-same-mode-buffers))

;; To activate ESS auto-complete for R.
(setq ess-use-auto-complete 'script-only)

;; Change 'ac-complete from ENTER to TAB.
(define-key ac-completing-map "\r" nil)
(define-key ac-completing-map "\t" 'ac-complete)

;;----------------------------------------------------------------------
;; Smart operators with electric spacing.
;; https://github.com/walmes/electric-spacing (fork).

;; Byte compile file.
;; (byte-compile-file "~/.emacs.d/lisp/electric-spacing-r.el")

(require 'electric-spacing-r)
(add-hook 'ess-mode-hook #'electric-spacing-mode)
(add-hook 'python-mode-hook #'electric-spacing-mode)

;;----------------------------------------------------------------------
;; Key combos.
;; https://github.com/emacs-ess/ESS/issues/96

;; (require 'key-combo)
;;
;; (defvar key-combo-ess-default
;;   '((">"  . (" > " " %>% " " %>%\n"))
;;     ("<"  . (" < " " <<- "))
;;     ("$"  . ("$" " %$% "))
;;     ("<>" . " %<>% ")
;;     ("%" . " %")
;;     ("#" . "# ")
;;     ;; ("*"  . ("*" " * "))
;;     ;; ("%" . ("%" "%*%" "%%"))
;;     ;; ("^"  . ("^" " ^ "))
;;     ("/"  . ("/" " %/% " " %% "))
;;     ;; ("~" . " ~ ")
;;     ;; (":" . (":" "::" ":::"))
;;     ;; (":="  . " := ") ; data.table
;;     ("->"  . " -> ")
;;     ("."  . ("." "_" "..."))))
;;
;; (add-hook 'ess-mode-hook
;;           '(lambda() (key-combo-mode t)))
;; (add-hook 'inferior-ess-mode-hook
;;           '(lambda() (key-combo-mode t)))
;;
;; (key-combo-define-hook '(ess-mode-hook inferior-ess-mode-hook)
;;                        'ess-key-combo-load-default
;;                        key-combo-ess-default)

;;----------------------------------------------------------------------
;; Latex extensions.

(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;; Open Tikz files (pgf and pgs extensions) in Tex mode.
(add-to-list 'auto-mode-alist '("\\.pgf" . latex-mode))
(add-to-list 'auto-mode-alist '("\\.pgs" . latex-mode))

;;----------------------------------------------------------------------
;; Org Mode.

;; http://emacswiki.org/emacs/OrgMode#toc7
(setq org-replace-disputed-keys t)
(setq org-return-follows-link t)
(setq org-descriptive-links nil)

;; Fontify code in code blocks.
;; http://orgmode.org/worg/org-contrib/babel/examples/fontify-src-code-blocks.html
(setq org-src-fontify-natively t)

;; http://orgmode.org/worg/org-dependencies.html

(require 'ox-latex)
(setq org-latex-listings t)
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))

;; Babel.
(org-babel-do-load-languages 'org-babel-load-languages
                             '((emacs-lisp . t)
                               (R . t)
                               (sh . t)))
(setq org-confirm-babel-evaluate nil)

;;----------------------------------------------------------------------
;; Python configuration.

;; Install first: M-x package-list-packages C-s elpy.
(elpy-enable)
(setq python-shell-interpreter "/usr/bin/python3")
;; (setq python-shell-interpreter "/home/walmes/anaconda3/bin/python3")

;; Seguir: http://tkf.github.io/emacs-jedi/latest/
;;   Terminal : sudo apt-get install virtualenv
;;   Emacs    : M-x package-install RET jedi RET
;;   Emacs    : M-x jedi:install-server RET

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Requires `anaconda-mode' package.
;; https://github.com/proofit404/anaconda-mode
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

;;----------------------------------------------------------------------
;; Alternatives for highlight indentation:
;; https://github.com/DarthFennec/highlight-indent-guides.
;; https://github.com/antonj/Highlight-Indentation-for-Emacs

;; To disable highlight-indentation for Python do
;;   M-x highlight-indentation-mode.
;; To disable permanently:
;;   M-x customize-variable RET elpy-modules RET
;; and disable checkbox. Apply and save.

;; This uses `highlight-indentation` package.
;; Desable it in Python.
(add-hook 'python-mode-hook
          '(lambda () (highlight-indentation-mode 0)) t)
;; (highlight-indentation-current-column-mode)
;; (set-face-background 'highlight-indentation-face "#990000")

;;----------------------------------------------------------------------
;; A Emacs tree plugin like NerdTree for Vim.
;; https://github.com/jaypei/emacs-neotree
;; M-x package-install RET neotree

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;;----------------------------------------------------------------------
;; To edit HTML and related files.

(require 'web-mode)

;; Enable mode for file types.
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Customization.
(add-hook 'web-mode-hook
          '(lambda ()
             (setq web-mode-markup-indent-offset 2))
          t)

;;----------------------------------------------------------------------
;; File navigation like in Sublime.
;; https://github.com/zk-phi/sublimity
;; https://www.emacswiki.org/emacs/Sublimity
;; M-x package-install RET sublimity

;; (require 'sublimity)
;; (require 'sublimity-scroll)
;; (require 'sublimity-map)
;; (sublimity-mode 1)
;;
;; (setq sublimity-scroll-weight 10
;;       sublimity-scroll-drift-length 5)

;;----------------------------------------------------------------------
;; Add highlighting for certain keywords.

;; http://lists.gnu.org/archive/html/emacs-orgmode/2010-09/txtb5ChQJCDny.txt
;; http://emacs.1067599.n5.nabble.com/Adding-keywords-for-font-lock-experts-td95645.html
(make-face 'bad-words)
(set-face-attribute 'bad-words nil
                    :foreground "White"
                    :background "Firebrick")
(make-face 'good-words)
(set-face-attribute 'good-words nil
                    :foreground "LightSeaGreen"
                    :background "White")

(dolist
    (mode '(fundamental-mode emacs-lisp-mode lisp-mode org-mode
            shell-mode sh-mode ess-mode polymode-mode python-mode
            markdown-mode latex-mode TeX-mode))
  (setq font-lock-keywords-case-fold-search t)
  (font-lock-add-keywords
   mode
   '(("\\<\\(IMPORTANT\\|ATTENTION\\|NOTE\\|OBS\\|TODO\\|BAD\\|STOP\\)\\>"
      0 'font-lock-warning-face t)
     ("\\<\\(COMMENT\\|IMPROVE\\|REVIEW\\|TIP\\|REMEMBER\\|QUESTION\\|EXPLANATION\\|INTERESTING\\|HYPHOTESIS\\|CONCEPT\\)\\>"
      0 'font-lock-constant-face t)
     ("\\<\\(BUG\\|WARNING\\|DANGER\\|FIXME\\|ERROR\\)\\>"
      0 'bad-words t)
     ("@[[:alnum:]_.]+\\>" ;; @walmes, @param, @return
      0 'font-lock-function-name-face t)
     ("\\<\\(DONE\\|GOOD\\|WALMES\\|SOLVED\\|AMAZING\\|COOL\\|NICE\\|BRILLIANT\\)\\>"
      0 'good-words t))
   ))

;;----------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-auto-light-when-jump (quote all-in-buffer))
 '(bmkp-auto-light-when-set (quote all-in-buffer))
 '(bmkp-last-as-first-bookmark-file nil)
 '(bmkp-light-style-autonamed (quote lfringe))
 '(bmkp-light-style-non-autonamed (quote lfringe))
 '(doc-view-continuous t)
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
