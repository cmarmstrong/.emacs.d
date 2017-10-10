;; packages first
(require 'package)
(package-initialize)

;; for emacsclient
(server-start)


;;; customizations/minor modes
(require 'better-defaults)
;; default font (InputMono 4-family custom)
(add-to-list 'default-frame-alist '(font . "Input"))
;; (setq linum-format "%5d ") ;; fix linum fringe overlay
(put 'dired-find-alternate-file 'disabled nil) ;; reuse dired buffer

;; CEDET
(semantic-mode 1)
(global-ede-mode 1)

;; ispell (windows only)
(setq ispell-program-name "C:\\Program Files (x86)\\Aspell\\bin\\aspell")
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


;;; user keybindings                                     old
(global-set-key (kbd "M-h") 'backward-char)            ; mark-paragraph
(global-set-key (kbd "M-j") 'next-line)                ; indent-new-
(global-set-key (kbd "M-k") 'previous-line)            ; kill-sentence
(global-set-key (kbd "M-l") 'forward-char)             ; downcase-word
(global-set-key (kbd "M-H") 'move-beginning-of-line)
(global-set-key (kbd "M-J") 'scroll-up-command)
(global-set-key (kbd "M-K") 'scroll-down-command)
(global-set-key (kbd "M-L") 'move-end-of-line)


;;; user hooks
;; ibuffer-mode
(defun my-ibuffer-mode-config ()
  "for use in `ibuffer-mode-hook'."
  (local-set-key (kbd "M-j") 'next-line) ; ibuffer-jump-to-filer-group
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
 '(backup-directory-alist (quote ((".*" . "C:/Users/rdcercma/Documents/emacs"))))
 '(column-number-mode t)
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("71c379d39642d7281407e56123ad7043b9874a1c18b20b6685730a86251a002e" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" default)))
 '(line-number-mode t)
 '(package-selected-packages
   (quote
    (symon yasnippet ess-R-data-view ess-R-object-popup zenburn-theme auctex better-defaults ergoemacs-mode ess font-utils list-utils pcache persistent-soft smex tangotango-theme ucs-utils undo-tree unicode-fonts)))
 '(show-paren-mode t)
 '(version-control t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
