;; packages first
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; for emacsclient
(server-start)


;;; customizations/minor modes
(require 'better-defaults)
;; default font (InputMono 4-family custom)
(add-to-list 'default-frame-alist '(font . "Input"))
;; (setq linum-format "%5d ") ;; fix linum fringe overlay
(put 'dired-find-alternate-file 'disabled nil) ;; reuse dired buffer
(setq scroll-error-top-bottom t)

;; CEDET
(semantic-mode 1)
(global-ede-mode 1)

;; ispell
;; (setq ispell-program-name "C:\\Program Files (x86)\\Aspell\\bin\\aspell")
(setq ispell-program-name "hunspell")
(setq ispell-dictionary "english")

;; symon
(require 'symon)
(symon-mode)

;; yasnippet
(yas-global-mode 1)


;;; configurations/major modes
;; auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-pdf-mode t)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; set pdflatex as default (DO I need this?)
(setq latex-run-command "pdflatex")

;; ESS
;; open help in buffer
(setq inferior-ess-r-help-command "utils::help(\"%s\", help_type=\"text\")\n")
;; map history navigation to directional keys in inferior ESS buffers
(eval-after-load "comint"
  '(progn
     (define-key comint-mode-map [up]
       'comint-previous-matching-input-from-input)
     (define-key comint-mode-map [down]
       'comint-next-matching-input-from-input)

     ;; also recommended for ESS use --
     (setq comint-scroll-to-bottom-on-output 'others)
     (setq comint-scroll-show-maximum-output t)
     ;; somewhat extreme, almost disabling writing in *R*, *shell* buffers above prompt:
     (setq comint-scroll-to-bottom-on-input 'this)
     ))


;;; user keybindings                                       old
;; navigation
(global-set-key (kbd "M-h") 'backward-char)              ; mark-paragraph
(global-set-key (kbd "M-j") 'next-line)                  ; indent-new-
(global-set-key (kbd "M-k") 'previous-line)              ; kill-sentence
(global-set-key (kbd "M-l") 'forward-char)               ; downcase-word
(global-set-key (kbd "M-H") 'move-beginning-of-line)
(global-set-key (kbd "M-J") 'scroll-up-command)
(global-set-key (kbd "M-K") 'scroll-down-command)
(global-set-key (kbd "M-L") 'move-end-of-line)
(global-set-key (kbd "M-SPC") 'set-mark-command)
(global-set-key (kbd "M-n") 'recenter-top-bottom)
(global-set-key (kbd "M-o") 'other-window)               ; facemenu-set-*
;; files
(global-set-key (kbd "M-x") 'kill-region)                ; execute-extended-command
(global-set-key (kbd "M-c") 'kill-ring-save)             ; capitalize-word
(global-set-key (kbd "M-v") 'yank)                       ; scroll-down-command
;; commands
(global-set-key (kbd "M-a") 'smex)                       ; backward-sentence
(global-set-key (kbd "M-A") 'smex-major-mode-commands)
;; buffers
(global-set-key (kbd "M-b") 'ibuffer)                    ; backward-word
;; facemenu
(progn
  (define-prefix-command 'facemenu-map)
  (define-key facemenu-map (kbd "d") 'facement-set-default)
  (define-key facemenu-map (kbd "b") 'facemenu-set-bold)
  (define-key facemenu-map (kbd "i") 'facemenu-set-italic)
  (define-key facemenu-map (kbd "l") 'facemenu-set-bold-italic)
  (define-key facemenu-map (kbd "u") 'facemenu-set-underline)
  (define-key facemenu-map (kbd "f") 'facemenu-set-face))
(global-set-key (kbd "M-f") facemenu-map)                ; forward-char


;;; user hooks
;; ibuffer-mode
(defun my-ibuffer-mode-config ()
  "for use in `ibuffer-mode-hook'."
  (local-set-key (kbd "M-j") 'next-line) ; ibuffer-jump-to-filter-group
  (local-set-key (kbd "M-o") 'other-window) ; ibuffer-visit-buffer-1-window
  )
;; add hook
(add-hook 'ibuffer-mode-hook 'my-ibuffer-mode-config)

;; ;; python-mode
;; (defun my-python ()
;;   (setq tab-width 4
;;         py-indent-offset 4
;;         indent-tabs-mode nil
;;         py-smart-indentation nil))
;; (add-hook 'python-mode-hook 'my-python)


;;; user functions
;; goto-column function
(defun goto-column-number (number)
  "Untabify, and go to a column NUMBER within the current line (1 is beginning of the line)."
  (interactive "nColumn number ( - 1 == C) ? ")
  (beginning-of-line)
  (untabify (point-min) (point-max))
  ((while) (> number 1)
   (if (eolp)
       (insert ? )
     (forward-char))
   (setq number (1- number))))

;; word count function
(defun word-count nil "Count words in buffer." (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))


;;; custom (last line of user)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist '((".*" . "C:/Users/rdcercma/Documents/emacs")))
 '(column-number-mode t)
 '(custom-enabled-themes '(zenburn))
 '(custom-safe-themes
   '("e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "2022c5a92bbc261e045ec053aa466705999863f14b84c012a43f55a95bf9feb8" "71c379d39642d7281407e56123ad7043b9874a1c18b20b6685730a86251a002e" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" default))
 '(line-number-mode t)
 '(package-selected-packages
   '(ebib magit symon yasnippet ess-R-data-view ess-R-object-popup zenburn-theme auctex better-defaults ergoemacs-mode ess font-utils list-utils pcache persistent-soft smex tangotango-theme ucs-utils undo-tree unicode-fonts))
 '(show-paren-mode t)
 '(version-control t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
