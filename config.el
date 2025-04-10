;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(eval-when-compile
  (require 'cl-lib)
  (setq byte-compile-warnings '(not obsolete)))

(require 'loadhist)
(file-dependents (feature-file 'cl-lib))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
 (setq user-full-name "Wen Mu"
        user-mail-address "liuyinpei@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)
(global-display-line-numbers-mode 1)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(setq org-directory "D:/WenMu/emacs/00_note")  ;; 设置 Org 文件默认目录
(setq org-agenda-files '("D:\\WenMu\\emacs\\01_GTD"))  ;; 设置议程文件路径

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; 英文12pt，中文16pt
;; (set-face-attribute 'default nil :font "Consolas-12")
(set-fontset-font t 'han (font-spec :name "Microsoft YaHei" :size 27))

;; 字体和主题-来自soulhacker-me
(setq +main-font "Iosevka Fixed")
(setq +unicode-font "Sarasa Fixed SC")

(setq doom-font (font-spec :family +main-font :size 16 :weight 'light)
      doom-big-font (font-spec :family +main-font :size 20 :weight 'light)
      doom-variable-pitch-font (font-spec :family +main-font) ;; inherits :size from doom-font
      doom-serif-font (font-spec :family +main-font :weight 'light)
      doom-unicode-font (font-spec :family +unicode-font)
      )

(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

;; 其他关联主题和字体设置， treemacs 适配 nerd-icons 似乎已经合并进 Doom ，不再需要手动设置。
(doom-themes-org-config)

;;(after! treemacs
;;  :config
;;  (doom-themes-treemacs-config)
;;  (treemacs-load-theme "nerd-icons")
;;  )

;; Doom 大部分的缺省配置都是优化且实用的，但还是有少量的需要修改。
;; 其中 word-wrap-by-category 这个选项是 Emacs 28 新加的，修复了 CJK 语言文本自动换行的老 bug。
(setq-default
 window-combination-resize t
 x-stretch-cursor t
 yas-triggers-in-field t
 )

(setq
 undo-limit 80000000
 auto-save-default t
 scroll-preserve-screen-position 'always
 scroll-margin 2
 word-wrap-by-category t
 all-the-icons-scale-factor 1.0
 )

(global-subword-mode t)

(setq +treemacs-git-mode 'extended)

(after! treemacs
  :config
  (setq treemacs-collapse-dirs 200))

(custom-set-faces!
  '(aw-leading-char-face
    :foreground "white" :background "red"
    :weight bold :height 1.5 :box (:line-width 10 :color "red")))

(defun +appened-to-negation-list (head tail)
  (if (sequencep head)
      (delete-dups
       (if (eq (car tail) 'not)
           (append head tail)
         (append tail head)))
    tail))

(when (modulep! :ui ligatures)
  (setq +ligatures-extras-in-modes
        (+appened-to-negation-list
         +ligatures-extras-in-modes
         '(not c-mode c++-mode emacs-lisp-mode python-mode scheme-mode racket-mode rust-mode)))
  (setq +ligatures-in-modes
        (+appened-to-negation-list
         +ligatures-in-modes
         '(not emacs-lisp-mode scheme-mode racket-mode))))

;;设置 org-agenda 使用的 Org 文档的位置，可以指定目录和文件名 pattern 把所有 .org 文件放进去：
(setq org-agenda-files (directory-files-recursively org-directory "\\.org$"))

;; 但通常还是指定几个分类任务文件就好了。
(after! org
  (setq org-agenda-files
        (list (expand-file-name "Inbox.org" org-directory)
              (expand-file-name "Private.org" org-directory)
              (expand-file-name "Work.org" org-directory)
              (expand-file-name "Projects.org" org-directory)
              (expand-file-name "Notes.org" org-directory)
              )))

;; 直接通过 org-roam 的数据库查询动态将这些文件添进 org-agenda 文件列表
(after! org-agenda
  (load! "lisp/vulpea-agenda"))

;; Org 文档导出 LaTeX 文档时需要做一些配置，一是引入 ctex 包，否则中文处理会有问题；
;; 二是配置一下带链接文本的格式，不然会是带红色框的文本，非常恐怖；另外是一些LaTeX 的常规设置。
(after! org
  (setq org-latex-default-packages-alist
        (remove '("AUTO" "inputenc" t) org-latex-default-packages-alist))
  (setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
                                "xelatex -interaction nonstopmode %f"))
  (setq org-latex-packages-alist
        '(("" "ctex" t)))
  (setq org-latex-hyperref-template
        "\\hypersetup{linktoc=all,colorlinks=true,urlcolor=blue,linkcolor=blue}")
  )

;; 缺省的 LaTeX模板的目录之后直接会接上正文，但一般的排版习惯会希望正文另起一页，这个简单定制一下就可以了：
 (setq org-latex-toc-command "\\tableofcontents \\clearpage\n\n") 

;; 利用 Emacs 的 Time Stamp 功能实现笔记最后编辑时间
 (after! org
  (add-hook 'org-mode-hook
            (lambda ()
              (setq-local time-stamp-active t
                          time-stamp-line-limit 18
                          time-stamp-start "^#\\+last_modified: [ \t]*"
                          time-stamp-end "$"
                          time-stamp-format "\[%Y-%m-%d %a %H:%M:%S\]")
              (add-hook 'before-save-hook 'time-stamp nil 'local))))

;; dslide基本配置
(use-package! dslide
  :after org
  :hook
  ((dslide-start
    .
    (lambda ()
      (org-fold-hide-block-all)
      (setq-default x-stretch-cursor -1)
      (redraw-display)
      (blink-cursor-mode -1)
      (setq cursor-type 'bar)
      ;;(org-display-inline-images)
      ;;(hl-line-mode -1)
      (text-scale-increase 2)
      (read-only-mode 1)))
   (dslide-stop
    .
    (lambda ()
      (blink-cursor-mode +1)
      (setq-default x-stretch-cursor t)
      (setq cursor-type t)
      (text-scale-increase 0)
      ;;(hl-line-mode 1)
      (read-only-mode -1))))
  :config
  (setq dslide-margin-content 0.5)
  (setq dslide-animation-duration 0.5)
  (setq dslide-margin-title-above 0.3)
  (setq dslide-margin-title-below 0.3)
  (setq dslide-header-email "")
  (setq dslide-header-date "")
  (define-key org-mode-map (kbd "<f8>") #'dslide-deck-start)
  (define-key dslide-mode-map (kbd "<f9>") #'dslide-deck-stop)
  )