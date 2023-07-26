;;; nezburn-theme.el --- A low contrast color theme for Emacs (inspired by zenburn).

;; Author: João Lanjoni <joaoaugustolanjoni@gmail.com>
;; URL: http://github.com/lanjoni/nezburn
;; Version: 0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A port of the popular inspired by Vim theme zenburn for Emacs 24+, built on top
;; of the new built-in theme support in Emacs 24.

;;; Credits:

;; Jani Nurminen created the original theme for vim on which this port
;; is based. Bozhidar Batsov created the original zenburn theme for Emacs.

;;; Code:

(deftheme nezburn "The nezburn color theme.")

(defgroup nezburn-theme nil
  "Nezburn theme."
  :group 'faces
  :prefix "nezburn-"
  :link '(url-link :tag "GitHub" "http://github.com/lanjoni/nezburn")
  :tag "nezburn theme")

;;;###autoload
(defcustom nezburn-override-colors-alist '()
  "Place to override default theme colors.

You can override a subset of the theme's default colors by
defining them in this alist."
  :group 'nezburn-theme
  :type '(alist
          :key-type (string :tag "Name")
          :value-type (string :tag " Hex")))

(defvar nezburn-use-variable-pitch nil
  "When non-nil, use variable pitch face for some headings and titles.")

(defvar nezburn-scale-org-headlines nil
  "Whether `org-mode' headlines should be scaled.")

(defvar nezburn-scale-outline-headlines nil
  "Whether `outline-mode' headlines should be scaled.")

(defcustom nezburn-height-minus-1 0.8
  "Font size -1."
  :type 'number
  :group 'nezburn-theme
  :package-version '(nezburn . "2.6"))

(defcustom nezburn-height-plus-1 1.1
  "Font size +1."
  :type 'number
  :group 'nezburn-theme
  :package-version '(nezburn . "2.6"))

(defcustom nezburn-height-plus-2 1.15
  "Font size +2."
  :type 'number
  :group 'nezburn-theme
  :package-version '(nezburn . "2.6"))

(defcustom nezburn-height-plus-3 1.2
  "Font size +3."
  :type 'number
  :group 'nezburn-theme
  :package-version '(nezburn . "2.6"))

(defcustom nezburn-height-plus-4 1.3
  "Font size +4."
  :type 'number
  :group 'nezburn-theme
  :package-version '(nezburn . "2.6"))

;;; Color Palette

(defvar nezburn-default-colors-alist
  '(("nezburn-fg-1"     . "#282822")
    ("nezburn-fg-05"    . "#3d3d39")
    ("nezburn-fg"       . "#DCDCCC")
    ("nezburn-fg+1"     . "#FFFFEF")
    ("nezburn-fg+2"     . "#FFFFFD")
    ("nezburn-bg-2"     . "#000000")
    ("nezburn-bg-1"     . "#111111")
    ("nezburn-bg-08"    . "#131313")
    ("nezburn-bg-05"    . "#161616")
    ("nezburn-bg"       . "#191919")
    ("nezburn-bg+05"    . "#1d1d1d")
    ("nezburn-bg+1"     . "#202020")
    ("nezburn-bg+2"     . "#262626")
    ("nezburn-bg+3"     . "#2c2c2c")
    ("nezburn-red-6"    . "#2b1414")
    ("nezburn-red-5"    . "#5f2d2d")
    ("nezburn-red-4"    . "#6f2a2a")
    ("nezburn-red-3"    . "#852121")
    ("nezburn-red-2"    . "#905555")
    ("nezburn-red-1"    . "#a65a5a")
    ("nezburn-red"      . "#b56363")
    ("nezburn-red+1"    . "#c76b6b")
    ("nezburn-red+2"    . "#db7171")
    ("nezburn-orange"   . "#cf8656")
    ("nezburn-yellow-2" . "#D0BF72")
    ("nezburn-yellow-1" . "#bba35e")
    ("nezburn-yellow"   . "#e3c369")
    ("nezburn-green-5"  . "#2F4F2F")
    ("nezburn-green-4"  . "#3F5F3F")
    ("nezburn-green-3"  . "#4F6F4F")
    ("nezburn-green-2"  . "#5F7F5F")
    ("nezburn-green-1"  . "#6F8F6F")
    ("nezburn-green"    . "#7F9F7F")
    ("nezburn-green+1"  . "#699869")
    ("nezburn-green+2"  . "#73aa73")
    ("nezburn-green+3"  . "#7abe7a")
    ("nezburn-green+4"  . "#7ed77e")
    ("nezburn-cyan"     . "#1f7377")
    ("nezburn-blue+3"   . "#1b6892")
    ("nezburn-blue+2"   . "#287377")
    ("nezburn-blue+1"   . "#10488d")
    ("nezburn-blue"     . "#276366")
    ("nezburn-blue-1"   . "#6CA0A3")
    ("nezburn-blue-2"   . "#53C1C7")
    ("nezburn-blue-3"   . "#3FB0B6")
    ("nezburn-blue-4"   . "#4C7073")
    ("nezburn-blue-5"   . "#366060")
    ("nezburn-magenta"  . "#6e2256"))
  "List of nezburn colors.
Each element has the form (NAME . HEX).

`+N' suffixes indicate a color is lighter.
`-N' suffixes indicate a color is darker.")

(defmacro nezburn-with-color-variables (&rest body)
  "`let' bind all colors defined in `nezburn-colors-alist' around BODY.
Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let ((class '((class color) (min-colors 89)))
         ,@(mapcar (lambda (cons)
                     (list (intern (car cons)) (cdr cons)))
                   (append nezburn-default-colors-alist
                           nezburn-override-colors-alist))
         (z-variable-pitch (if nezburn-use-variable-pitch
                               'variable-pitch 'default)))
     ,@body))

;;; Theme Faces
(nezburn-with-color-variables
  (custom-theme-set-faces
   'nezburn

;;;; Built-in packages

;;;;; basic coloring
   '(button ((t (:underline t))))
   `(link ((t (:foreground ,nezburn-yellow :underline t :weight bold))))
   `(link-visited ((t (:foreground ,nezburn-yellow-2 :underline t :weight normal))))
   `(default ((t (:foreground ,nezburn-fg :background ,nezburn-bg))))
   `(cursor ((t (:foreground ,nezburn-fg :background ,nezburn-fg+1))))
   `(widget-field ((t (:foreground ,nezburn-fg :background ,nezburn-bg+3))))
   `(escape-glyph ((t (:foreground ,nezburn-yellow :weight bold))))
   `(fringe ((t (:foreground ,nezburn-fg :background ,nezburn-bg+1))))
   `(header-line ((t (:foreground ,nezburn-yellow
                                  :background ,nezburn-bg-1
                                  :box (:line-width -1 :style released-button)
                                  :extend t))))
   `(highlight ((t (:background ,nezburn-bg-05))))
   `(success ((t (:foreground ,nezburn-green :weight bold))))
   `(warning ((t (:foreground ,nezburn-orange :weight bold))))
   `(tooltip ((t (:foreground ,nezburn-fg :background ,nezburn-bg+1))))
;;;;; ansi-colors
   `(ansi-color-black ((t (:foreground ,nezburn-bg
                                       :background ,nezburn-bg-1))))
   `(ansi-color-red ((t (:foreground ,nezburn-red-2
                                     :background ,nezburn-red-4))))
   `(ansi-color-green ((t (:foreground ,nezburn-green
                                       :background ,nezburn-green+2))))
   `(ansi-color-yellow ((t (:foreground ,nezburn-orange
                                        :background ,nezburn-yellow))))
   `(ansi-color-blue ((t (:foreground ,nezburn-blue-1
                                      :background ,nezburn-blue-4))))
   `(ansi-color-magenta ((t (:foreground ,nezburn-magenta
                                         :background ,nezburn-red))))
   `(ansi-color-cyan ((t (:foreground ,nezburn-cyan
                                      :background ,nezburn-blue))))
   `(ansi-color-white ((t (:foreground ,nezburn-fg
                                       :background ,nezburn-fg-1))))
;;;;; compilation
   `(compilation-column-face ((t (:foreground ,nezburn-yellow))))
   `(compilation-enter-directory-face ((t (:foreground ,nezburn-green))))
   `(compilation-error-face ((t (:foreground ,nezburn-red-1 :weight bold :underline t))))
   `(compilation-face ((t (:foreground ,nezburn-fg))))
   `(compilation-info-face ((t (:foreground ,nezburn-blue))))
   `(compilation-info ((t (:foreground ,nezburn-green+4 :underline t))))
   `(compilation-leave-directory-face ((t (:foreground ,nezburn-green))))
   `(compilation-line-face ((t (:foreground ,nezburn-yellow))))
   `(compilation-line-number ((t (:foreground ,nezburn-yellow))))
   `(compilation-message-face ((t (:foreground ,nezburn-blue))))
   `(compilation-warning-face ((t (:foreground ,nezburn-orange :weight bold :underline t))))
   `(compilation-mode-line-exit ((t (:foreground ,nezburn-green+2 :weight bold))))
   `(compilation-mode-line-fail ((t (:foreground ,nezburn-red :weight bold))))
   `(compilation-mode-line-run ((t (:foreground ,nezburn-yellow :weight bold))))
;;;;; completions
   `(completions-annotations ((t (:foreground ,nezburn-fg-1))))
   `(completions-common-part ((t (:foreground ,nezburn-blue))))
   `(completions-first-difference ((t (:foreground ,nezburn-fg+1))))
;;;;; customize
   `(custom-variable-tag ((t (:foreground ,nezburn-blue :weight bold))))
   `(custom-group-tag ((t (:foreground ,nezburn-blue :weight bold :height 1.2))))
   `(custom-state ((t (:foreground ,nezburn-green+4))))
;;;;; display-fill-column-indicator
   `(fill-column-indicator ((,class :foreground ,nezburn-bg-05 :weight semilight)))
;;;;; eww
   '(eww-invalid-certificate ((t (:inherit error))))
   '(eww-valid-certificate   ((t (:inherit success))))
;;;;; grep
   `(grep-context-face ((t (:foreground ,nezburn-fg))))
   `(grep-error-face ((t (:foreground ,nezburn-red-1 :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,nezburn-blue))))
   `(grep-match-face ((t (:foreground ,nezburn-orange :weight bold))))
   `(match ((t (:background ,nezburn-bg-1 :foreground ,nezburn-orange :weight bold))))
;;;;; hi-lock
   `(hi-blue    ((t (:background ,nezburn-cyan    :foreground ,nezburn-bg-1))))
   `(hi-green   ((t (:background ,nezburn-green+4 :foreground ,nezburn-bg-1))))
   `(hi-pink    ((t (:background ,nezburn-magenta :foreground ,nezburn-bg-1))))
   `(hi-yellow  ((t (:background ,nezburn-yellow  :foreground ,nezburn-bg-1))))
   `(hi-blue-b  ((t (:foreground ,nezburn-blue    :weight     bold))))
   `(hi-green-b ((t (:foreground ,nezburn-green+2 :weight     bold))))
   `(hi-red-b   ((t (:foreground ,nezburn-red     :weight     bold))))
;;;;; info
   `(Info-quoted ((t (:inherit font-lock-constant-face))))
;;;;; isearch
   `(isearch ((t (:foreground ,nezburn-yellow-2 :weight bold :background ,nezburn-bg+2))))
   `(isearch-fail ((t (:foreground ,nezburn-fg :background ,nezburn-red-4))))
   `(lazy-highlight ((t (:foreground ,nezburn-yellow-2 :weight bold :background ,nezburn-bg-05))))

   `(menu ((t (:foreground ,nezburn-fg :background ,nezburn-bg))))
   `(minibuffer-prompt ((t (:foreground ,nezburn-yellow))))
   `(mode-line
     ((,class (:foreground ,nezburn-green+1
                           :background ,nezburn-bg-1
                           :box (:line-width -1 :style released-button)))
      (t :inverse-video t)))
   `(mode-line-buffer-id ((t (:foreground ,nezburn-yellow :weight bold))))
   `(mode-line-inactive
     ((t (:foreground ,nezburn-green-2
                      :background ,nezburn-bg-05
                      :box (:line-width -1 :style released-button)))))
   `(region ((,class (:background ,nezburn-bg-1 :extend t))
             (t :inverse-video t)))
   `(secondary-selection ((t (:background ,nezburn-bg+2))))
   `(trailing-whitespace ((t (:background ,nezburn-red))))
   `(vertical-border ((t (:foreground ,nezburn-fg))))
;;;;; font lock
   `(font-lock-builtin-face ((t (:foreground ,nezburn-fg :weight bold))))
   `(font-lock-comment-face ((t (:foreground ,nezburn-green))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,nezburn-green-2))))
   `(font-lock-constant-face ((t (:foreground ,nezburn-green+4))))
   `(font-lock-doc-face ((t (:foreground ,nezburn-green+2))))
   `(font-lock-function-name-face ((t (:foreground ,nezburn-cyan))))
   `(font-lock-keyword-face ((t (:foreground ,nezburn-yellow :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,nezburn-yellow :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,nezburn-blue+1))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,nezburn-yellow :weight bold))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,nezburn-green :weight bold))))
   `(font-lock-string-face ((t (:foreground ,nezburn-red))))
   `(font-lock-type-face ((t (:foreground ,nezburn-blue-1))))
   `(font-lock-variable-name-face ((t (:foreground ,nezburn-orange))))
   `(font-lock-warning-face ((t (:foreground ,nezburn-yellow-2 :weight bold))))

   `(c-annotation-face ((t (:inherit font-lock-constant-face))))
;;;;; line numbers (Emacs 26.1 and above)
   `(line-number ((t (:inherit default :foreground ,nezburn-bg+3 :background ,nezburn-bg-05))))
   `(line-number-current-line ((t (:inherit line-number :foreground ,nezburn-yellow-2))))
;;;;; man
   '(Man-overstrike ((t (:inherit font-lock-keyword-face))))
   '(Man-underline  ((t (:inherit (font-lock-string-face underline)))))
;;;;; newsticker
   `(newsticker-date-face ((t (:foreground ,nezburn-fg))))
   `(newsticker-default-face ((t (:foreground ,nezburn-fg))))
   `(newsticker-enclosure-face ((t (:foreground ,nezburn-green+3))))
   `(newsticker-extra-face ((t (:foreground ,nezburn-bg+2 :height 0.8))))
   `(newsticker-feed-face ((t (:foreground ,nezburn-fg))))
   `(newsticker-immortal-item-face ((t (:foreground ,nezburn-green))))
   `(newsticker-new-item-face ((t (:foreground ,nezburn-blue))))
   `(newsticker-obsolete-item-face ((t (:foreground ,nezburn-red))))
   `(newsticker-old-item-face ((t (:foreground ,nezburn-bg+3))))
   `(newsticker-statistics-face ((t (:foreground ,nezburn-fg))))
   `(newsticker-treeview-face ((t (:foreground ,nezburn-fg))))
   `(newsticker-treeview-immortal-face ((t (:foreground ,nezburn-green))))
   `(newsticker-treeview-listwindow-face ((t (:foreground ,nezburn-fg))))
   `(newsticker-treeview-new-face ((t (:foreground ,nezburn-blue :weight bold))))
   `(newsticker-treeview-obsolete-face ((t (:foreground ,nezburn-red))))
   `(newsticker-treeview-old-face ((t (:foreground ,nezburn-bg+3))))
   `(newsticker-treeview-selection-face ((t (:background ,nezburn-bg-1 :foreground ,nezburn-yellow))))
;;;;; woman
   '(woman-bold   ((t (:inherit font-lock-keyword-face))))
   '(woman-italic ((t (:inherit (font-lock-string-face italic)))))

;;;; Third-party packages

;;;;; ace-jump
   `(ace-jump-face-background
     ((t (:foreground ,nezburn-fg-1 :background ,nezburn-bg :inverse-video nil))))
   `(ace-jump-face-foreground
     ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg :inverse-video nil))))
;;;;; ace-window
   `(aw-background-face
     ((t (:foreground ,nezburn-fg-1 :background ,nezburn-bg :inverse-video nil))))
   `(aw-leading-char-face ((t (:inherit aw-mode-line-face))))
;;;;; adoc-mode
   `(adoc-anchor-face ((t (:foreground ,nezburn-blue+1))))
   `(adoc-code-face ((t (:inherit font-lock-constant-face))))
   `(adoc-command-face ((t (:foreground ,nezburn-yellow))))
   `(adoc-emphasis-face ((t (:inherit bold))))
   `(adoc-internal-reference-face ((t (:foreground ,nezburn-yellow-2 :underline t))))
   `(adoc-list-face ((t (:foreground ,nezburn-fg+1))))
   `(adoc-meta-face ((t (:foreground ,nezburn-yellow))))
   `(adoc-meta-hide-face ((t (:foreground ,nezburn-yellow))))
   `(adoc-secondary-text-face ((t (:foreground ,nezburn-yellow-1))))
   `(adoc-title-0-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(adoc-title-1-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(adoc-title-2-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(adoc-title-3-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(adoc-title-4-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(adoc-typewriter-face ((t (:inherit font-lock-constant-face))))
   `(adoc-verbatim-face ((t (:inherit font-lock-constant-face))))
   `(adoc-value-face ((t (:foreground ,nezburn-yellow))))
;;;;; android mode
   `(android-mode-debug-face ((t (:foreground ,nezburn-green+1))))
   `(android-mode-error-face ((t (:foreground ,nezburn-orange :weight bold))))
   `(android-mode-info-face ((t (:foreground ,nezburn-fg))))
   `(android-mode-verbose-face ((t (:foreground ,nezburn-green))))
   `(android-mode-warning-face ((t (:foreground ,nezburn-yellow))))
;;;;; anzu
   `(anzu-mode-line ((t (:foreground ,nezburn-cyan :weight bold))))
   `(anzu-mode-line-no-match ((t (:foreground ,nezburn-red :weight bold))))
   `(anzu-match-1 ((t (:foreground ,nezburn-bg :background ,nezburn-green))))
   `(anzu-match-2 ((t (:foreground ,nezburn-bg :background ,nezburn-orange))))
   `(anzu-match-3 ((t (:foreground ,nezburn-bg :background ,nezburn-blue))))
   `(anzu-replace-to ((t (:inherit anzu-replace-highlight :foreground ,nezburn-yellow))))
;;;;; auctex
   `(font-latex-bold-face ((t (:inherit bold))))
   `(font-latex-warning-face ((t (:foreground nil :inherit font-lock-warning-face))))
   `(font-latex-sectioning-5-face ((t (:foreground ,nezburn-red :weight bold ))))
   `(font-latex-sedate-face ((t (:foreground ,nezburn-yellow))))
   `(font-latex-italic-face ((t (:foreground ,nezburn-cyan :slant italic))))
   `(font-latex-string-face ((t (:inherit ,font-lock-string-face))))
   `(font-latex-math-face ((t (:foreground ,nezburn-orange))))
   `(font-latex-script-char-face ((t (:foreground ,nezburn-orange))))
;;;;; agda-mode
   `(agda2-highlight-keyword-face ((t (:foreground ,nezburn-yellow :weight bold))))
   `(agda2-highlight-string-face ((t (:foreground ,nezburn-red))))
   `(agda2-highlight-symbol-face ((t (:foreground ,nezburn-orange))))
   `(agda2-highlight-primitive-type-face ((t (:foreground ,nezburn-blue-1))))
   `(agda2-highlight-inductive-constructor-face ((t (:foreground ,nezburn-fg))))
   `(agda2-highlight-coinductive-constructor-face ((t (:foreground ,nezburn-fg))))
   `(agda2-highlight-datatype-face ((t (:foreground ,nezburn-blue))))
   `(agda2-highlight-function-face ((t (:foreground ,nezburn-blue))))
   `(agda2-highlight-module-face ((t (:foreground ,nezburn-blue-1))))
   `(agda2-highlight-error-face ((t (:foreground ,nezburn-bg :background ,nezburn-magenta))))
   `(agda2-highlight-unsolved-meta-face ((t (:foreground ,nezburn-bg :background ,nezburn-magenta))))
   `(agda2-highlight-unsolved-constraint-face ((t (:foreground ,nezburn-bg :background ,nezburn-magenta))))
   `(agda2-highlight-termination-problem-face ((t (:foreground ,nezburn-bg :background ,nezburn-magenta))))
   `(agda2-highlight-incomplete-pattern-face ((t (:foreground ,nezburn-bg :background ,nezburn-magenta))))
   `(agda2-highlight-typechecks-face ((t (:background ,nezburn-red-4))))
;;;;; auto-complete
   `(ac-candidate-face ((t (:background ,nezburn-bg+3 :foreground ,nezburn-bg-2))))
   `(ac-selection-face ((t (:background ,nezburn-blue-4 :foreground ,nezburn-fg))))
   `(popup-tip-face ((t (:background ,nezburn-yellow-2 :foreground ,nezburn-bg-2))))
   `(popup-menu-mouse-face ((t (:background ,nezburn-yellow-2 :foreground ,nezburn-bg-2))))
   `(popup-summary-face ((t (:background ,nezburn-bg+3 :foreground ,nezburn-bg-2))))
   `(popup-scroll-bar-foreground-face ((t (:background ,nezburn-blue-5))))
   `(popup-scroll-bar-background-face ((t (:background ,nezburn-bg-1))))
   `(popup-isearch-match ((t (:background ,nezburn-bg :foreground ,nezburn-fg))))
;;;;; avy
   `(avy-background-face
     ((t (:foreground ,nezburn-fg-1 :background ,nezburn-bg :inverse-video nil))))
   `(avy-lead-face-0
     ((t (:foreground ,nezburn-green+3 :background ,nezburn-bg :inverse-video nil :weight bold))))
   `(avy-lead-face-1
     ((t (:foreground ,nezburn-yellow :background ,nezburn-bg :inverse-video nil :weight bold))))
   `(avy-lead-face-2
     ((t (:foreground ,nezburn-red+1 :background ,nezburn-bg :inverse-video nil :weight bold))))
   `(avy-lead-face
     ((t (:foreground ,nezburn-cyan :background ,nezburn-bg :inverse-video nil :weight bold))))
;;;;; company-mode
   `(company-tooltip ((t (:foreground ,nezburn-fg :background ,nezburn-bg+1))))
   `(company-tooltip-annotation ((t (:foreground ,nezburn-orange :background ,nezburn-bg+1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,nezburn-orange :background ,nezburn-bg-1))))
   `(company-tooltip-selection ((t (:foreground ,nezburn-fg :background ,nezburn-bg-1))))
   `(company-tooltip-mouse ((t (:background ,nezburn-bg-1))))
   `(company-tooltip-common ((t (:foreground ,nezburn-green+2))))
   `(company-tooltip-common-selection ((t (:foreground ,nezburn-green+2))))
   `(company-scrollbar-fg ((t (:background ,nezburn-bg-1))))
   `(company-scrollbar-bg ((t (:background ,nezburn-bg+2))))
   `(company-preview ((t (:background ,nezburn-green+2))))
   `(company-preview-common ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg-1))))
;;;;; bm
   `(bm-face ((t (:background ,nezburn-yellow-1 :foreground ,nezburn-bg))))
   `(bm-fringe-face ((t (:background ,nezburn-yellow-1 :foreground ,nezburn-bg))))
   `(bm-fringe-persistent-face ((t (:background ,nezburn-green-2 :foreground ,nezburn-bg))))
   `(bm-persistent-face ((t (:background ,nezburn-green-2 :foreground ,nezburn-bg))))
;;;;; calfw
   `(cfw:face-annotation ((t (:foreground ,nezburn-red :inherit cfw:face-day-title))))
   `(cfw:face-day-title ((t nil)))
   `(cfw:face-default-content ((t (:foreground ,nezburn-green))))
   `(cfw:face-default-day ((t (:weight bold))))
   `(cfw:face-disable ((t (:foreground ,nezburn-fg-1))))
   `(cfw:face-grid ((t (:inherit shadow))))
   `(cfw:face-header ((t (:inherit font-lock-keyword-face))))
   `(cfw:face-holiday ((t (:inherit cfw:face-sunday))))
   `(cfw:face-periods ((t (:foreground ,nezburn-cyan))))
   `(cfw:face-saturday ((t (:foreground ,nezburn-blue :weight bold))))
   `(cfw:face-select ((t (:background ,nezburn-blue-5))))
   `(cfw:face-sunday ((t (:foreground ,nezburn-red :weight bold))))
   `(cfw:face-title ((t (:height 2.0 :inherit (variable-pitch font-lock-keyword-face)))))
   `(cfw:face-today ((t (:foreground ,nezburn-cyan :weight bold))))
   `(cfw:face-today-title ((t (:inherit highlight bold))))
   `(cfw:face-toolbar ((t (:background ,nezburn-blue-5))))
   `(cfw:face-toolbar-button-off ((t (:underline nil :inherit link))))
   `(cfw:face-toolbar-button-on ((t (:underline nil :inherit link-visited))))
;;;;; centaur-tabs
   `(centaur-tabs-default ((t (:background ,nezburn-bg :foreground ,nezburn-fg :box nil))))
   `(centaur-tabs-selected ((t (:background ,nezburn-bg :foreground ,nezburn-fg+2 :box nil))))
   `(centaur-tabs-unselected ((t (:background ,nezburn-bg-1 :foreground ,nezburn-fg-05 :box nil))))
   `(centaur-tabs-selected-modified ((t (:background ,nezburn-bg :foreground ,nezburn-orange :box nil))))
   `(centaur-tabs-unselected-modified ((t (:background ,nezburn-bg-1 :foreground ,nezburn-orange :box nil))))
   `(centaur-tabs-active-bar-face ((t (:background ,nezburn-yellow :box nil))))
   `(centaur-tabs-modified-marker-selected ((t (:inherit 'centaur-tabs-selected-modified :foreground ,nezburn-yellow :box nil))))
   `(centaur-tabs-modified-marker-unselected ((t (:inherit 'centaur-tabs-unselected-modified :foreground ,nezburn-yellow :box nil))))
;;;;; cider
   `(cider-result-overlay-face ((t (:background unspecified))))
   `(cider-enlightened-face ((t (:box (:color ,nezburn-orange :line-width -1)))))
   `(cider-enlightened-local-face ((t (:weight bold :foreground ,nezburn-green+1))))
   `(cider-deprecated-face ((t (:background ,nezburn-yellow-2))))
   `(cider-instrumented-face ((t (:box (:color ,nezburn-red :line-width -1)))))
   `(cider-traced-face ((t (:box (:color ,nezburn-cyan :line-width -1)))))
   `(cider-test-failure-face ((t (:background ,nezburn-red-4))))
   `(cider-test-error-face ((t (:background ,nezburn-magenta))))
   `(cider-test-success-face ((t (:background ,nezburn-green-2))))
   `(cider-fringe-good-face ((t (:foreground ,nezburn-green+4))))
;;;;; circe
   `(circe-highlight-nick-face ((t (:foreground ,nezburn-cyan))))
   `(circe-my-message-face ((t (:foreground ,nezburn-fg))))
   `(circe-fool-face ((t (:foreground ,nezburn-red+1))))
   `(circe-topic-diff-removed-face ((t (:foreground ,nezburn-red :weight bold))))
   `(circe-originator-face ((t (:foreground ,nezburn-fg))))
   `(circe-server-face ((t (:foreground ,nezburn-green))))
   `(circe-topic-diff-new-face ((t (:foreground ,nezburn-orange :weight bold))))
   `(circe-prompt-face ((t (:foreground ,nezburn-orange :background ,nezburn-bg :weight bold))))
;;;;; context-coloring
   `(context-coloring-level-0-face ((t :foreground ,nezburn-fg)))
   `(context-coloring-level-1-face ((t :foreground ,nezburn-cyan)))
   `(context-coloring-level-2-face ((t :foreground ,nezburn-green+4)))
   `(context-coloring-level-3-face ((t :foreground ,nezburn-yellow)))
   `(context-coloring-level-4-face ((t :foreground ,nezburn-orange)))
   `(context-coloring-level-5-face ((t :foreground ,nezburn-magenta)))
   `(context-coloring-level-6-face ((t :foreground ,nezburn-blue+1)))
   `(context-coloring-level-7-face ((t :foreground ,nezburn-green+2)))
   `(context-coloring-level-8-face ((t :foreground ,nezburn-yellow-2)))
   `(context-coloring-level-9-face ((t :foreground ,nezburn-red+1)))
;;;;; coq
   `(coq-solve-tactics-face ((t (:foreground nil :inherit font-lock-constant-face))))
;;;;; ctable
   `(ctbl:face-cell-select ((t (:background ,nezburn-blue :foreground ,nezburn-bg))))
   `(ctbl:face-continue-bar ((t (:background ,nezburn-bg-05 :foreground ,nezburn-bg))))
   `(ctbl:face-row-select ((t (:background ,nezburn-cyan :foreground ,nezburn-bg))))
;;;;; debbugs
   `(debbugs-gnu-done ((t (:foreground ,nezburn-fg-1))))
   `(debbugs-gnu-handled ((t (:foreground ,nezburn-green))))
   `(debbugs-gnu-new ((t (:foreground ,nezburn-red))))
   `(debbugs-gnu-pending ((t (:foreground ,nezburn-blue))))
   `(debbugs-gnu-stale ((t (:foreground ,nezburn-orange))))
   `(debbugs-gnu-tagged ((t (:foreground ,nezburn-red))))
;;;;; diff
   ;; Please read (info "(magit)Theming Faces") before changing this.
   `(diff-added          ((t (:background "#335533" :foreground ,nezburn-green))))
   `(diff-changed        ((t (:background "#555511" :foreground ,nezburn-yellow-1))))
   `(diff-removed        ((t (:background "#553333" :foreground ,nezburn-red-2))))
   `(diff-refine-added   ((t (:background "#338833" :foreground ,nezburn-green+4))))
   `(diff-refine-changed ((t (:background "#888811" :foreground ,nezburn-yellow))))
   `(diff-refine-removed ((t (:background "#883333" :foreground ,nezburn-red))))
   `(diff-header ((,class (:background ,nezburn-bg+2))
                  (t (:background ,nezburn-fg :foreground ,nezburn-bg))))
   `(diff-file-header
     ((,class (:background ,nezburn-bg+2 :foreground ,nezburn-fg :weight bold))
      (t (:background ,nezburn-fg :foreground ,nezburn-bg :weight bold))))
;;;;; diff-hl
   `(diff-hl-change ((,class (:foreground ,nezburn-blue :background ,nezburn-blue-2))))
   `(diff-hl-delete ((,class (:foreground ,nezburn-red+1 :background ,nezburn-red-1))))
   `(diff-hl-insert ((,class (:foreground ,nezburn-green+1 :background ,nezburn-green-2))))
;;;;; dim-autoload
   `(dim-autoload-cookie-line ((t :foreground ,nezburn-bg+1)))
;;;;; dired+
   `(diredp-display-msg ((t (:foreground ,nezburn-blue))))
   `(diredp-compressed-file-suffix ((t (:foreground ,nezburn-orange))))
   `(diredp-date-time ((t (:foreground ,nezburn-magenta))))
   `(diredp-deletion ((t (:foreground ,nezburn-yellow))))
   `(diredp-deletion-file-name ((t (:foreground ,nezburn-red))))
   `(diredp-dir-heading ((t (:foreground ,nezburn-blue :background ,nezburn-bg-1))))
   `(diredp-dir-priv ((t (:foreground ,nezburn-cyan))))
   `(diredp-exec-priv ((t (:foreground ,nezburn-red))))
   `(diredp-executable-tag ((t (:foreground ,nezburn-green+1))))
   `(diredp-file-name ((t (:foreground ,nezburn-blue))))
   `(diredp-file-suffix ((t (:foreground ,nezburn-green))))
   `(diredp-flag-mark ((t (:foreground ,nezburn-yellow))))
   `(diredp-flag-mark-line ((t (:foreground ,nezburn-orange))))
   `(diredp-ignored-file-name ((t (:foreground ,nezburn-red))))
   `(diredp-link-priv ((t (:foreground ,nezburn-yellow))))
   `(diredp-mode-line-flagged ((t (:foreground ,nezburn-yellow))))
   `(diredp-mode-line-marked ((t (:foreground ,nezburn-orange))))
   `(diredp-no-priv ((t (:foreground ,nezburn-fg))))
   `(diredp-number ((t (:foreground ,nezburn-green+1))))
   `(diredp-other-priv ((t (:foreground ,nezburn-yellow-1))))
   `(diredp-rare-priv ((t (:foreground ,nezburn-red-1))))
   `(diredp-read-priv ((t (:foreground ,nezburn-green-2))))
   `(diredp-symlink ((t (:foreground ,nezburn-yellow))))
   `(diredp-write-priv ((t (:foreground ,nezburn-magenta))))
;;;;; dired-async
   `(dired-async-failures ((t (:foreground ,nezburn-red :weight bold))))
   `(dired-async-message ((t (:foreground ,nezburn-yellow :weight bold))))
   `(dired-async-mode-message ((t (:foreground ,nezburn-yellow))))
;;;;; diredfl
   `(diredfl-compressed-file-suffix ((t (:foreground ,nezburn-orange))))
   `(diredfl-date-time ((t (:foreground ,nezburn-magenta))))
   `(diredfl-deletion ((t (:foreground ,nezburn-yellow))))
   `(diredfl-deletion-file-name ((t (:foreground ,nezburn-red))))
   `(diredfl-dir-heading ((t (:foreground ,nezburn-blue :background ,nezburn-bg-1))))
   `(diredfl-dir-priv ((t (:foreground ,nezburn-cyan))))
   `(diredfl-exec-priv ((t (:foreground ,nezburn-red))))
   `(diredfl-executable-tag ((t (:foreground ,nezburn-green+1))))
   `(diredfl-file-name ((t (:foreground ,nezburn-blue))))
   `(diredfl-file-suffix ((t (:foreground ,nezburn-green))))
   `(diredfl-flag-mark ((t (:foreground ,nezburn-yellow))))
   `(diredfl-flag-mark-line ((t (:foreground ,nezburn-orange))))
   `(diredfl-ignored-file-name ((t (:foreground ,nezburn-red))))
   `(diredfl-link-priv ((t (:foreground ,nezburn-yellow))))
   `(diredfl-no-priv ((t (:foreground ,nezburn-fg))))
   `(diredfl-number ((t (:foreground ,nezburn-green+1))))
   `(diredfl-other-priv ((t (:foreground ,nezburn-yellow-1))))
   `(diredfl-rare-priv ((t (:foreground ,nezburn-red-1))))
   `(diredfl-read-priv ((t (:foreground ,nezburn-green-1))))
   `(diredfl-symlink ((t (:foreground ,nezburn-yellow))))
   `(diredfl-write-priv ((t (:foreground ,nezburn-magenta))))
;;;;; doom-modeline
   `(doom-modeline-bar  ((t (:background ,nezburn-yellow))))
   `(doom-modeline-inactive-bar  ((t (:background nil))))
;;;;; ediff
   `(ediff-current-diff-A ((t (:foreground ,nezburn-fg :background ,nezburn-red-4))))
   `(ediff-current-diff-Ancestor ((t (:foreground ,nezburn-fg :background ,nezburn-red-4))))
   `(ediff-current-diff-B ((t (:foreground ,nezburn-fg :background ,nezburn-green-2))))
   `(ediff-current-diff-C ((t (:foreground ,nezburn-fg :background ,nezburn-blue-5))))
   `(ediff-even-diff-A ((t (:background ,nezburn-bg+1))))
   `(ediff-even-diff-Ancestor ((t (:background ,nezburn-bg+1))))
   `(ediff-even-diff-B ((t (:background ,nezburn-bg+1))))
   `(ediff-even-diff-C ((t (:background ,nezburn-bg+1))))
   `(ediff-fine-diff-A ((t (:foreground ,nezburn-fg :background ,nezburn-red-2 :weight bold))))
   `(ediff-fine-diff-Ancestor ((t (:foreground ,nezburn-fg :background ,nezburn-red-2 weight bold))))
   `(ediff-fine-diff-B ((t (:foreground ,nezburn-fg :background ,nezburn-green :weight bold))))
   `(ediff-fine-diff-C ((t (:foreground ,nezburn-fg :background ,nezburn-blue-3 :weight bold ))))
   `(ediff-odd-diff-A ((t (:background ,nezburn-bg+2))))
   `(ediff-odd-diff-Ancestor ((t (:background ,nezburn-bg+2))))
   `(ediff-odd-diff-B ((t (:background ,nezburn-bg+2))))
   `(ediff-odd-diff-C ((t (:background ,nezburn-bg+2))))
;;;;; egg
   `(egg-text-base ((t (:foreground ,nezburn-fg))))
   `(egg-help-header-1 ((t (:foreground ,nezburn-yellow))))
   `(egg-help-header-2 ((t (:foreground ,nezburn-green+3))))
   `(egg-branch ((t (:foreground ,nezburn-yellow))))
   `(egg-branch-mono ((t (:foreground ,nezburn-yellow))))
   `(egg-term ((t (:foreground ,nezburn-yellow))))
   `(egg-diff-add ((t (:foreground ,nezburn-green+4))))
   `(egg-diff-del ((t (:foreground ,nezburn-red+1))))
   `(egg-diff-file-header ((t (:foreground ,nezburn-yellow-2))))
   `(egg-section-title ((t (:foreground ,nezburn-yellow))))
   `(egg-stash-mono ((t (:foreground ,nezburn-green+4))))
;;;;; elfeed
   `(elfeed-log-error-level-face ((t (:foreground ,nezburn-red))))
   `(elfeed-log-info-level-face ((t (:foreground ,nezburn-blue))))
   `(elfeed-log-warn-level-face ((t (:foreground ,nezburn-yellow))))
   `(elfeed-search-date-face ((t (:foreground ,nezburn-yellow-1 :underline t
                                              :weight bold))))
   `(elfeed-search-tag-face ((t (:foreground ,nezburn-green))))
   `(elfeed-search-feed-face ((t (:foreground ,nezburn-cyan))))
   `(elfeed-search-title-face ((t (:foreground ,nezburn-fg-05))))
   `(elfeed-search-unread-title-face ((t (:foreground ,nezburn-fg :weight bold))))
;;;;; emacs-w3m
   `(w3m-anchor ((t (:foreground ,nezburn-yellow :underline t
                                 :weight bold))))
   `(w3m-arrived-anchor ((t (:foreground ,nezburn-yellow-2
                                         :underline t :weight normal))))
   `(w3m-form ((t (:foreground ,nezburn-red-1 :underline t))))
   `(w3m-header-line-location-title ((t (:foreground ,nezburn-yellow
                                                     :underline t :weight bold))))
   '(w3m-history-current-url ((t (:inherit match))))
   `(w3m-lnum ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg))))
   `(w3m-lnum-match ((t (:background ,nezburn-bg-1
                                     :foreground ,nezburn-orange
                                     :weight bold))))
   `(w3m-lnum-minibuffer-prompt ((t (:foreground ,nezburn-yellow))))
;;;;; erc
   `(erc-action-face ((t (:inherit erc-default-face))))
   `(erc-bold-face ((t (:weight bold))))
   `(erc-current-nick-face ((t (:foreground ,nezburn-blue :weight bold))))
   `(erc-dangerous-host-face ((t (:inherit font-lock-warning-face))))
   `(erc-default-face ((t (:foreground ,nezburn-fg))))
   `(erc-direct-msg-face ((t (:inherit erc-default-face))))
   `(erc-error-face ((t (:inherit font-lock-warning-face))))
   `(erc-fool-face ((t (:inherit erc-default-face))))
   `(erc-highlight-face ((t (:inherit hover-highlight))))
   `(erc-input-face ((t (:foreground ,nezburn-yellow))))
   `(erc-keyword-face ((t (:foreground ,nezburn-blue :weight bold))))
   `(erc-nick-default-face ((t (:foreground ,nezburn-yellow :weight bold))))
   `(erc-my-nick-face ((t (:foreground ,nezburn-red :weight bold))))
   `(erc-nick-msg-face ((t (:inherit erc-default-face))))
   `(erc-notice-face ((t (:foreground ,nezburn-green))))
   `(erc-pal-face ((t (:foreground ,nezburn-orange :weight bold))))
   `(erc-prompt-face ((t (:foreground ,nezburn-orange :background ,nezburn-bg :weight bold))))
   `(erc-timestamp-face ((t (:foreground ,nezburn-green+4))))
   `(erc-underline-face ((t (:underline t))))
;;;;; eros
   `(eros-result-overlay-face ((t (:background unspecified))))
;;;;; ert
   `(ert-test-result-expected ((t (:foreground ,nezburn-green+4 :background ,nezburn-bg))))
   `(ert-test-result-unexpected ((t (:foreground ,nezburn-red :background ,nezburn-bg))))
;;;;; eshell
   `(eshell-prompt ((t (:foreground ,nezburn-yellow :weight bold))))
   `(eshell-ls-archive ((t (:foreground ,nezburn-red-1 :weight bold))))
   `(eshell-ls-backup ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-clutter ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-directory ((t (:foreground ,nezburn-blue+1 :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,nezburn-red+1 :weight bold))))
   `(eshell-ls-unreadable ((t (:foreground ,nezburn-fg))))
   `(eshell-ls-missing ((t (:inherit font-lock-warning-face))))
   `(eshell-ls-product ((t (:inherit font-lock-doc-face))))
   `(eshell-ls-special ((t (:foreground ,nezburn-yellow :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,nezburn-cyan :weight bold))))
;;;;; flx
   `(flx-highlight-face ((t (:foreground ,nezburn-green+2 :weight bold))))
;;;;; flycheck
   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-red-1) :inherit unspecified))
      (t (:foreground ,nezburn-red-1 :weight bold :underline t))))
   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-yellow) :inherit unspecified))
      (t (:foreground ,nezburn-yellow :weight bold :underline t))))
   `(flycheck-info
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-cyan) :inherit unspecified))
      (t (:foreground ,nezburn-cyan :weight bold :underline t))))
   `(flycheck-fringe-error ((t (:foreground ,nezburn-red-1 :weight bold))))
   `(flycheck-fringe-warning ((t (:foreground ,nezburn-yellow :weight bold))))
   `(flycheck-fringe-info ((t (:foreground ,nezburn-cyan :weight bold))))
;;;;; flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-red)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nezburn-red-1 :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-orange)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nezburn-orange :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-green)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nezburn-green-2 :weight bold :underline t))))
   `(flymake-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-red)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nezburn-red-1 :weight bold :underline t))))
   `(flymake-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-orange)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nezburn-orange :weight bold :underline t))))
   `(flymake-note
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-green)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nezburn-green-2 :weight bold :underline t))))
;;;;; flyspell
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-orange) :inherit unspecified))
      (t (:foreground ,nezburn-orange :weight bold :underline t))))
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-red) :inherit unspecified))
      (t (:foreground ,nezburn-red-1 :weight bold :underline t))))
;;;;; full-ack
   `(ack-separator ((t (:foreground ,nezburn-fg))))
   `(ack-file ((t (:foreground ,nezburn-blue))))
   `(ack-line ((t (:foreground ,nezburn-yellow))))
   `(ack-match ((t (:foreground ,nezburn-orange :background ,nezburn-bg-1 :weight bold))))
;;;;; git-annex
   '(git-annex-dired-annexed-available ((t (:inherit success :weight normal))))
   '(git-annex-dired-annexed-unavailable ((t (:inherit error :weight normal))))
;;;;; git-commit
   `(git-commit-comment-action  ((,class (:foreground ,nezburn-green+1 :weight bold))))
   `(git-commit-comment-branch  ((,class (:foreground ,nezburn-blue+1  :weight bold)))) ; obsolete
   `(git-commit-comment-branch-local  ((,class (:foreground ,nezburn-blue+1  :weight bold))))
   `(git-commit-comment-branch-remote ((,class (:foreground ,nezburn-green  :weight bold))))
   `(git-commit-comment-heading ((,class (:foreground ,nezburn-yellow  :weight bold))))
;;;;; git-gutter
   `(git-gutter:added ((t (:foreground ,nezburn-green :weight bold :inverse-video t))))
   `(git-gutter:deleted ((t (:foreground ,nezburn-red :weight bold :inverse-video t))))
   `(git-gutter:modified ((t (:foreground ,nezburn-magenta :weight bold :inverse-video t))))
   `(git-gutter:unchanged ((t (:foreground ,nezburn-fg :weight bold :inverse-video t))))
;;;;; git-gutter-fr
   `(git-gutter-fr:added ((t (:foreground ,nezburn-green  :weight bold))))
   `(git-gutter-fr:deleted ((t (:foreground ,nezburn-red :weight bold))))
   `(git-gutter-fr:modified ((t (:foreground ,nezburn-magenta :weight bold))))
;;;;; git-rebase
   `(git-rebase-hash ((t (:foreground, nezburn-orange))))
;;;;; gnus
   `(gnus-group-mail-1 ((t (:weight bold :inherit gnus-group-mail-1-empty))))
   `(gnus-group-mail-1-empty ((t (:inherit gnus-group-news-1-empty))))
   `(gnus-group-mail-2 ((t (:weight bold :inherit gnus-group-mail-2-empty))))
   `(gnus-group-mail-2-empty ((t (:inherit gnus-group-news-2-empty))))
   `(gnus-group-mail-3 ((t (:weight bold :inherit gnus-group-mail-3-empty))))
   `(gnus-group-mail-3-empty ((t (:inherit gnus-group-news-3-empty))))
   `(gnus-group-mail-4 ((t (:weight bold :inherit gnus-group-mail-4-empty))))
   `(gnus-group-mail-4-empty ((t (:inherit gnus-group-news-4-empty))))
   `(gnus-group-mail-5 ((t (:weight bold :inherit gnus-group-mail-5-empty))))
   `(gnus-group-mail-5-empty ((t (:inherit gnus-group-news-5-empty))))
   `(gnus-group-mail-6 ((t (:weight bold :inherit gnus-group-mail-6-empty))))
   `(gnus-group-mail-6-empty ((t (:inherit gnus-group-news-6-empty))))
   `(gnus-group-mail-low ((t (:weight bold :inherit gnus-group-mail-low-empty))))
   `(gnus-group-mail-low-empty ((t (:inherit gnus-group-news-low-empty))))
   `(gnus-group-news-1 ((t (:weight bold :inherit gnus-group-news-1-empty))))
   `(gnus-group-news-2 ((t (:weight bold :inherit gnus-group-news-2-empty))))
   `(gnus-group-news-3 ((t (:weight bold :inherit gnus-group-news-3-empty))))
   `(gnus-group-news-4 ((t (:weight bold :inherit gnus-group-news-4-empty))))
   `(gnus-group-news-5 ((t (:weight bold :inherit gnus-group-news-5-empty))))
   `(gnus-group-news-6 ((t (:weight bold :inherit gnus-group-news-6-empty))))
   `(gnus-group-news-low ((t (:weight bold :inherit gnus-group-news-low-empty))))
   `(gnus-header-content ((t (:inherit message-header-other))))
   `(gnus-header-from ((t (:inherit message-header-to))))
   `(gnus-header-name ((t (:inherit message-header-name))))
   `(gnus-header-newsgroups ((t (:inherit message-header-other))))
   `(gnus-header-subject ((t (:inherit message-header-subject))))
   `(gnus-server-opened ((t (:foreground ,nezburn-green+2 :weight bold))))
   `(gnus-server-denied ((t (:foreground ,nezburn-red+1 :weight bold))))
   `(gnus-server-closed ((t (:foreground ,nezburn-blue :slant italic))))
   `(gnus-server-offline ((t (:foreground ,nezburn-yellow :weight bold))))
   `(gnus-server-agent ((t (:foreground ,nezburn-blue :weight bold))))
   `(gnus-summary-cancelled ((t (:foreground ,nezburn-orange))))
   `(gnus-summary-high-ancient ((t (:foreground ,nezburn-blue))))
   `(gnus-summary-high-read ((t (:foreground ,nezburn-green :weight bold))))
   `(gnus-summary-high-ticked ((t (:foreground ,nezburn-orange :weight bold))))
   `(gnus-summary-high-unread ((t (:foreground ,nezburn-fg :weight bold))))
   `(gnus-summary-low-ancient ((t (:foreground ,nezburn-blue))))
   `(gnus-summary-low-read ((t (:foreground ,nezburn-green))))
   `(gnus-summary-low-ticked ((t (:foreground ,nezburn-orange :weight bold))))
   `(gnus-summary-low-unread ((t (:foreground ,nezburn-fg))))
   `(gnus-summary-normal-ancient ((t (:foreground ,nezburn-blue))))
   `(gnus-summary-normal-read ((t (:foreground ,nezburn-green))))
   `(gnus-summary-normal-ticked ((t (:foreground ,nezburn-orange :weight bold))))
   `(gnus-summary-normal-unread ((t (:foreground ,nezburn-fg))))
   `(gnus-summary-selected ((t (:foreground ,nezburn-yellow :weight bold))))
   `(gnus-cite-1 ((t (:foreground ,nezburn-blue))))
   `(gnus-cite-10 ((t (:foreground ,nezburn-yellow-1))))
   `(gnus-cite-11 ((t (:foreground ,nezburn-yellow))))
   `(gnus-cite-2 ((t (:foreground ,nezburn-blue-1))))
   `(gnus-cite-3 ((t (:foreground ,nezburn-blue-2))))
   `(gnus-cite-4 ((t (:foreground ,nezburn-green+2))))
   `(gnus-cite-5 ((t (:foreground ,nezburn-green+1))))
   `(gnus-cite-6 ((t (:foreground ,nezburn-green))))
   `(gnus-cite-7 ((t (:foreground ,nezburn-red))))
   `(gnus-cite-8 ((t (:foreground ,nezburn-red-1))))
   `(gnus-cite-9 ((t (:foreground ,nezburn-red-2))))
   `(gnus-group-news-1-empty ((t (:foreground ,nezburn-yellow))))
   `(gnus-group-news-2-empty ((t (:foreground ,nezburn-green+3))))
   `(gnus-group-news-3-empty ((t (:foreground ,nezburn-green+1))))
   `(gnus-group-news-4-empty ((t (:foreground ,nezburn-blue-2))))
   `(gnus-group-news-5-empty ((t (:foreground ,nezburn-blue-3))))
   `(gnus-group-news-6-empty ((t (:foreground ,nezburn-bg+2))))
   `(gnus-group-news-low-empty ((t (:foreground ,nezburn-bg+2))))
   `(gnus-signature ((t (:foreground ,nezburn-yellow))))
   `(gnus-x ((t (:background ,nezburn-fg :foreground ,nezburn-bg))))
   `(mm-uu-extract ((t (:background ,nezburn-bg-05 :foreground ,nezburn-green+1))))
;;;;; go-guru
   `(go-guru-hl-identifier-face ((t (:foreground ,nezburn-bg-1 :background ,nezburn-green+1))))
;;;;; guide-key
   `(guide-key/highlight-command-face ((t (:foreground ,nezburn-blue))))
   `(guide-key/key-face ((t (:foreground ,nezburn-green))))
   `(guide-key/prefix-command-face ((t (:foreground ,nezburn-green+1))))
;;;;; hackernews
   '(hackernews-comment-count ((t (:inherit link-visited :underline nil))))
   '(hackernews-link          ((t (:inherit link         :underline nil))))
;;;;; helm
   `(helm-header
     ((t (:foreground ,nezburn-green
                      :background ,nezburn-bg
                      :underline nil
                      :box nil
                      :extend t))))
   `(helm-source-header
     ((t (:foreground ,nezburn-yellow
                      :background ,nezburn-bg-1
                      :underline nil
                      :weight bold
                      :box (:line-width -1 :style released-button)
                      :extend t))))
   `(helm-selection ((t (:background ,nezburn-bg+1 :underline nil))))
   `(helm-selection-line ((t (:background ,nezburn-bg+1))))
   `(helm-visible-mark ((t (:foreground ,nezburn-bg :background ,nezburn-yellow-2))))
   `(helm-candidate-number ((t (:foreground ,nezburn-green+4 :background ,nezburn-bg-1))))
   `(helm-separator ((t (:foreground ,nezburn-red :background ,nezburn-bg))))
   `(helm-time-zone-current ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg))))
   `(helm-time-zone-home ((t (:foreground ,nezburn-red :background ,nezburn-bg))))
   `(helm-bookmark-addressbook ((t (:foreground ,nezburn-orange :background ,nezburn-bg))))
   `(helm-bookmark-directory ((t (:foreground nil :background nil :inherit helm-ff-directory))))
   `(helm-bookmark-file ((t (:foreground nil :background nil :inherit helm-ff-file))))
   `(helm-bookmark-gnus ((t (:foreground ,nezburn-magenta :background ,nezburn-bg))))
   `(helm-bookmark-info ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg))))
   `(helm-bookmark-man ((t (:foreground ,nezburn-yellow :background ,nezburn-bg))))
   `(helm-bookmark-w3m ((t (:foreground ,nezburn-magenta :background ,nezburn-bg))))
   `(helm-buffer-not-saved ((t (:foreground ,nezburn-red :background ,nezburn-bg))))
   `(helm-buffer-process ((t (:foreground ,nezburn-cyan :background ,nezburn-bg))))
   `(helm-buffer-saved-out ((t (:foreground ,nezburn-fg :background ,nezburn-bg))))
   `(helm-buffer-size ((t (:foreground ,nezburn-fg-1 :background ,nezburn-bg))))
   `(helm-ff-directory ((t (:foreground ,nezburn-cyan :background ,nezburn-bg :weight bold))))
   `(helm-ff-file ((t (:foreground ,nezburn-fg :background ,nezburn-bg :weight normal))))
   `(helm-ff-file-extension ((t (:foreground ,nezburn-fg :background ,nezburn-bg :weight normal))))
   `(helm-ff-executable ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg :weight normal))))
   `(helm-ff-invalid-symlink ((t (:foreground ,nezburn-red :background ,nezburn-bg :weight bold))))
   `(helm-ff-symlink ((t (:foreground ,nezburn-yellow :background ,nezburn-bg :weight bold))))
   `(helm-ff-prefix ((t (:foreground ,nezburn-bg :background ,nezburn-yellow :weight normal))))
   `(helm-grep-cmd-line ((t (:foreground ,nezburn-cyan :background ,nezburn-bg))))
   `(helm-grep-file ((t (:foreground ,nezburn-fg :background ,nezburn-bg))))
   `(helm-grep-finish ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg))))
   `(helm-grep-lineno ((t (:foreground ,nezburn-fg-1 :background ,nezburn-bg))))
   `(helm-grep-match ((t (:foreground nil :background nil :inherit helm-match))))
   `(helm-grep-running ((t (:foreground ,nezburn-red :background ,nezburn-bg))))
   `(helm-match ((t (:foreground ,nezburn-orange :background ,nezburn-bg-1 :weight bold))))
   `(helm-moccur-buffer ((t (:foreground ,nezburn-cyan :background ,nezburn-bg))))
   `(helm-mu-contacts-address-face ((t (:foreground ,nezburn-fg-1 :background ,nezburn-bg))))
   `(helm-mu-contacts-name-face ((t (:foreground ,nezburn-fg :background ,nezburn-bg))))
;;;;; helm-lxc
   `(helm-lxc-face-frozen ((t (:foreground ,nezburn-blue :background ,nezburn-bg))))
   `(helm-lxc-face-running ((t (:foreground ,nezburn-green :background ,nezburn-bg))))
   `(helm-lxc-face-stopped ((t (:foreground ,nezburn-red :background ,nezburn-bg))))
;;;;; helm-swoop
   `(helm-swoop-target-line-face ((t (:foreground ,nezburn-fg :background ,nezburn-bg+1))))
   `(helm-swoop-target-word-face ((t (:foreground ,nezburn-yellow :background ,nezburn-bg+2 :weight bold))))
;;;;; highlight-numbers
   `(highlight-numbers-number ((t (:foreground ,nezburn-blue))))
;;;;; highlight-symbol
   `(highlight-symbol-face ((t (:background ,nezburn-bg+2))))
;;;;; highlight-thing
   `(highlight-thing ((t (:background ,nezburn-bg+2))))
;;;;; hl-line-mode
   `(hl-line-face ((,class (:background ,nezburn-bg-05))
                   (t :weight bold)))
   `(hl-line ((,class (:background ,nezburn-bg-05 :extend t)) ; old emacsen
              (t :weight bold)))
;;;;; hl-sexp
   `(hl-sexp-face ((,class (:background ,nezburn-bg+1))
                   (t :weight bold)))
;;;;; hydra
   `(hydra-face-red ((t (:foreground ,nezburn-red-1 :background ,nezburn-bg))))
   `(hydra-face-amaranth ((t (:foreground ,nezburn-red-3 :background ,nezburn-bg))))
   `(hydra-face-blue ((t (:foreground ,nezburn-blue :background ,nezburn-bg))))
   `(hydra-face-pink ((t (:foreground ,nezburn-magenta :background ,nezburn-bg))))
   `(hydra-face-teal ((t (:foreground ,nezburn-cyan :background ,nezburn-bg))))
;;;;; info+
   `(info-command-ref-item ((t (:background ,nezburn-bg-1 :foreground ,nezburn-orange))))
   `(info-constant-ref-item ((t (:background ,nezburn-bg-1 :foreground ,nezburn-magenta))))
   `(info-double-quoted-name ((t (:inherit font-lock-comment-face))))
   `(info-file ((t (:background ,nezburn-bg-1 :foreground ,nezburn-yellow))))
   `(info-function-ref-item ((t (:background ,nezburn-bg-1 :inherit font-lock-function-name-face))))
   `(info-macro-ref-item ((t (:background ,nezburn-bg-1 :foreground ,nezburn-yellow))))
   `(info-menu ((t (:foreground ,nezburn-yellow))))
   `(info-quoted-name ((t (:inherit font-lock-constant-face))))
   `(info-reference-item ((t (:background ,nezburn-bg-1))))
   `(info-single-quote ((t (:inherit font-lock-keyword-face))))
   `(info-special-form-ref-item ((t (:background ,nezburn-bg-1 :foreground ,nezburn-yellow))))
   `(info-string ((t (:inherit font-lock-string-face))))
   `(info-syntax-class-item ((t (:background ,nezburn-bg-1 :foreground ,nezburn-blue+1))))
   `(info-user-option-ref-item ((t (:background ,nezburn-bg-1 :foreground ,nezburn-red))))
   `(info-variable-ref-item ((t (:background ,nezburn-bg-1 :foreground ,nezburn-orange))))
;;;;; irfc
   `(irfc-head-name-face ((t (:foreground ,nezburn-red :weight bold))))
   `(irfc-head-number-face ((t (:foreground ,nezburn-red :weight bold))))
   `(irfc-reference-face ((t (:foreground ,nezburn-blue-1 :weight bold))))
   `(irfc-requirement-keyword-face ((t (:inherit font-lock-keyword-face))))
   `(irfc-rfc-link-face ((t (:inherit link))))
   `(irfc-rfc-number-face ((t (:foreground ,nezburn-cyan :weight bold))))
   `(irfc-std-number-face ((t (:foreground ,nezburn-green+4 :weight bold))))
   `(irfc-table-item-face ((t (:foreground ,nezburn-green+3))))
   `(irfc-title-face ((t (:foreground ,nezburn-yellow
                                      :underline t :weight bold))))
;;;;; ivy
   `(ivy-confirm-face ((t (:foreground ,nezburn-green :background ,nezburn-bg))))
   `(ivy-current-match ((t (:foreground ,nezburn-yellow :weight bold :underline t))))
   `(ivy-cursor ((t (:foreground ,nezburn-bg :background ,nezburn-fg))))
   `(ivy-match-required-face ((t (:foreground ,nezburn-red :background ,nezburn-bg))))
   `(ivy-minibuffer-match-face-1 ((t (:background ,nezburn-bg+1))))
   `(ivy-minibuffer-match-face-2 ((t (:background ,nezburn-green-2))))
   `(ivy-minibuffer-match-face-3 ((t (:background ,nezburn-green))))
   `(ivy-minibuffer-match-face-4 ((t (:background ,nezburn-green+1))))
   `(ivy-remote ((t (:foreground ,nezburn-blue :background ,nezburn-bg))))
   `(ivy-subdir ((t (:foreground ,nezburn-yellow :background ,nezburn-bg))))
;;;;; ido-mode
   `(ido-first-match ((t (:foreground ,nezburn-yellow :weight bold))))
   `(ido-only-match ((t (:foreground ,nezburn-orange :weight bold))))
   `(ido-subdir ((t (:foreground ,nezburn-yellow))))
   `(ido-indicator ((t (:foreground ,nezburn-yellow :background ,nezburn-red-4))))
;;;;; iedit-mode
   `(iedit-occurrence ((t (:background ,nezburn-bg+2 :weight bold))))
;;;;; jabber-mode
   `(jabber-roster-user-away ((t (:foreground ,nezburn-green+2))))
   `(jabber-roster-user-online ((t (:foreground ,nezburn-blue-1))))
   `(jabber-roster-user-dnd ((t (:foreground ,nezburn-red+1))))
   `(jabber-roster-user-xa ((t (:foreground ,nezburn-magenta))))
   `(jabber-roster-user-chatty ((t (:foreground ,nezburn-orange))))
   `(jabber-roster-user-error ((t (:foreground ,nezburn-red+1))))
   `(jabber-rare-time-face ((t (:foreground ,nezburn-green+1))))
   `(jabber-chat-prompt-local ((t (:foreground ,nezburn-blue-1))))
   `(jabber-chat-prompt-foreign ((t (:foreground ,nezburn-red+1))))
   `(jabber-chat-prompt-system ((t (:foreground ,nezburn-green+3))))
   `(jabber-activity-face((t (:foreground ,nezburn-red+1))))
   `(jabber-activity-personal-face ((t (:foreground ,nezburn-blue+1))))
   `(jabber-title-small ((t (:height 1.1 :weight bold))))
   `(jabber-title-medium ((t (:height 1.2 :weight bold))))
   `(jabber-title-large ((t (:height 1.3 :weight bold))))
;;;;; js2-mode
   `(js2-warning ((t (:underline ,nezburn-orange))))
   `(js2-error ((t (:foreground ,nezburn-red :weight bold))))
   `(js2-jsdoc-tag ((t (:foreground ,nezburn-green-2))))
   `(js2-jsdoc-type ((t (:foreground ,nezburn-green+2))))
   `(js2-jsdoc-value ((t (:foreground ,nezburn-green+3))))
   `(js2-function-param ((t (:foreground, nezburn-orange))))
   `(js2-external-variable ((t (:foreground ,nezburn-orange))))
;;;;; additional js2 mode attributes for better syntax highlighting
   `(js2-instance-member ((t (:foreground ,nezburn-green-2))))
   `(js2-jsdoc-html-tag-delimiter ((t (:foreground ,nezburn-orange))))
   `(js2-jsdoc-html-tag-name ((t (:foreground ,nezburn-red-1))))
   `(js2-object-property ((t (:foreground ,nezburn-blue+1))))
   `(js2-magic-paren ((t (:foreground ,nezburn-blue-5))))
   `(js2-private-function-call ((t (:foreground ,nezburn-cyan))))
   `(js2-function-call ((t (:foreground ,nezburn-cyan))))
   `(js2-private-member ((t (:foreground ,nezburn-blue-1))))
   `(js2-keywords ((t (:foreground ,nezburn-magenta))))
;;;;; ledger-mode
   `(ledger-font-payee-uncleared-face ((t (:foreground ,nezburn-red-1 :weight bold))))
   `(ledger-font-payee-cleared-face ((t (:foreground ,nezburn-fg :weight normal))))
   `(ledger-font-payee-pending-face ((t (:foreground ,nezburn-red :weight normal))))
   `(ledger-font-xact-highlight-face ((t (:background ,nezburn-bg+1))))
   `(ledger-font-auto-xact-face ((t (:foreground ,nezburn-yellow-1 :weight normal))))
   `(ledger-font-periodic-xact-face ((t (:foreground ,nezburn-green :weight normal))))
   `(ledger-font-pending-face ((t (:foreground ,nezburn-orange weight: normal))))
   `(ledger-font-other-face ((t (:foreground ,nezburn-fg))))
   `(ledger-font-posting-date-face ((t (:foreground ,nezburn-orange :weight normal))))
   `(ledger-font-posting-account-face ((t (:foreground ,nezburn-blue-1))))
   `(ledger-font-posting-account-cleared-face ((t (:foreground ,nezburn-fg))))
   `(ledger-font-posting-account-pending-face ((t (:foreground ,nezburn-orange))))
   `(ledger-font-posting-amount-face ((t (:foreground ,nezburn-orange))))
   `(ledger-occur-narrowed-face ((t (:foreground ,nezburn-fg-1 :invisible t))))
   `(ledger-occur-xact-face ((t (:background ,nezburn-bg+1))))
   `(ledger-font-comment-face ((t (:foreground ,nezburn-green))))
   `(ledger-font-reconciler-uncleared-face ((t (:foreground ,nezburn-red-1 :weight bold))))
   `(ledger-font-reconciler-cleared-face ((t (:foreground ,nezburn-fg :weight normal))))
   `(ledger-font-reconciler-pending-face ((t (:foreground ,nezburn-orange :weight normal))))
   `(ledger-font-report-clickable-face ((t (:foreground ,nezburn-orange :weight normal))))
;;;;; linum-mode
   `(linum ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg))))
;;;;; lispy
   `(lispy-command-name-face ((t (:background ,nezburn-bg-05 :inherit font-lock-function-name-face))))
   `(lispy-cursor-face ((t (:foreground ,nezburn-bg :background ,nezburn-fg))))
   `(lispy-face-hint ((t (:inherit highlight :foreground ,nezburn-yellow))))
;;;;; ruler-mode
   `(ruler-mode-column-number ((t (:inherit 'ruler-mode-default :foreground ,nezburn-fg))))
   `(ruler-mode-fill-column ((t (:inherit 'ruler-mode-default :foreground ,nezburn-yellow))))
   `(ruler-mode-goal-column ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-comment-column ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-tab-stop ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-current-column ((t (:foreground ,nezburn-yellow :box t))))
   `(ruler-mode-default ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg))))

;;;;; lui
   `(lui-time-stamp-face ((t (:foreground ,nezburn-blue-1))))
   `(lui-hilight-face ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg))))
   `(lui-button-face ((t (:inherit hover-highlight))))
;;;;; macrostep
   `(macrostep-gensym-1
     ((t (:foreground ,nezburn-green+2 :background ,nezburn-bg-1))))
   `(macrostep-gensym-2
     ((t (:foreground ,nezburn-red+1 :background ,nezburn-bg-1))))
   `(macrostep-gensym-3
     ((t (:foreground ,nezburn-blue+1 :background ,nezburn-bg-1))))
   `(macrostep-gensym-4
     ((t (:foreground ,nezburn-magenta :background ,nezburn-bg-1))))
   `(macrostep-gensym-5
     ((t (:foreground ,nezburn-yellow :background ,nezburn-bg-1))))
   `(macrostep-expansion-highlight-face
     ((t (:inherit highlight))))
   `(macrostep-macro-face
     ((t (:underline t))))
;;;;; magit
;;;;;; headings and diffs
   ;; Please read (info "(magit)Theming Faces") before changing this.
   `(magit-section-highlight           ((t (:background ,nezburn-bg+05))))
   `(magit-section-heading             ((t (:foreground ,nezburn-yellow :weight bold))))
   `(magit-section-heading-selection   ((t (:foreground ,nezburn-orange :weight bold))))
   `(magit-diff-file-heading           ((t (:weight bold))))
   `(magit-diff-file-heading-highlight ((t (:background ,nezburn-bg+05 :weight bold))))
   `(magit-diff-file-heading-selection ((t (:background ,nezburn-bg+05 :weight bold
                                                        :foreground ,nezburn-orange))))
   `(magit-diff-added                  ((t (:background ,nezburn-green-2))))
   `(magit-diff-added-highlight        ((t (:background ,nezburn-green))))
   `(magit-diff-removed                ((t (:background ,nezburn-red-4))))
   `(magit-diff-removed-highlight      ((t (:background ,nezburn-red-3))))
   `(magit-diff-hunk-heading           ((t (:background ,nezburn-bg+1))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,nezburn-bg+2))))
   `(magit-diff-hunk-heading-selection ((t (:background ,nezburn-bg+2
                                                        :foreground ,nezburn-orange))))
   `(magit-diff-lines-heading          ((t (:background ,nezburn-orange
                                                        :foreground ,nezburn-bg+2))))
   `(magit-diff-context-highlight      ((t (:background ,nezburn-bg+05
                                                        :foreground "grey70"))))
   `(magit-diffstat-added              ((t (:foreground ,nezburn-green+4))))
   `(magit-diffstat-removed            ((t (:foreground ,nezburn-red))))
;;;;;; popup
   `(magit-popup-heading             ((t (:foreground ,nezburn-yellow  :weight bold))))
   `(magit-popup-key                 ((t (:foreground ,nezburn-green-2 :weight bold))))
   `(magit-popup-argument            ((t (:foreground ,nezburn-green   :weight bold))))
   `(magit-popup-disabled-argument   ((t (:foreground ,nezburn-fg-1    :weight normal))))
   `(magit-popup-option-value        ((t (:foreground ,nezburn-blue-2  :weight bold))))
;;;;;; process
   `(magit-process-ok    ((t (:foreground ,nezburn-green  :weight bold))))
   `(magit-process-ng    ((t (:foreground ,nezburn-red    :weight bold))))
;;;;;; log
   `(magit-log-author    ((t (:foreground ,nezburn-orange))))
   `(magit-log-date      ((t (:foreground ,nezburn-fg-1))))
   `(magit-log-graph     ((t (:foreground ,nezburn-fg+1))))
;;;;;; sequence
   `(magit-sequence-pick ((t (:foreground ,nezburn-yellow-2))))
   `(magit-sequence-stop ((t (:foreground ,nezburn-green))))
   `(magit-sequence-part ((t (:foreground ,nezburn-yellow))))
   `(magit-sequence-head ((t (:foreground ,nezburn-blue))))
   `(magit-sequence-drop ((t (:foreground ,nezburn-red))))
   `(magit-sequence-done ((t (:foreground ,nezburn-fg-1))))
   `(magit-sequence-onto ((t (:foreground ,nezburn-fg-1))))
;;;;;; bisect
   `(magit-bisect-good ((t (:foreground ,nezburn-green))))
   `(magit-bisect-skip ((t (:foreground ,nezburn-yellow))))
   `(magit-bisect-bad  ((t (:foreground ,nezburn-red))))
;;;;;; blame
   `(magit-blame-heading ((t (:background ,nezburn-bg-1 :foreground ,nezburn-blue-2))))
   `(magit-blame-hash    ((t (:background ,nezburn-bg-1 :foreground ,nezburn-blue-2))))
   `(magit-blame-name    ((t (:background ,nezburn-bg-1 :foreground ,nezburn-orange))))
   `(magit-blame-date    ((t (:background ,nezburn-bg-1 :foreground ,nezburn-orange))))
   `(magit-blame-summary ((t (:background ,nezburn-bg-1 :foreground ,nezburn-blue-2
                                          :weight bold))))
;;;;;; references etc
   `(magit-dimmed         ((t (:foreground ,nezburn-bg+3))))
   `(magit-hash           ((t (:foreground ,nezburn-bg+3))))
   `(magit-tag            ((t (:foreground ,nezburn-orange :weight bold))))
   `(magit-branch-remote  ((t (:foreground ,nezburn-green  :weight bold))))
   `(magit-branch-local   ((t (:foreground ,nezburn-blue   :weight bold))))
   `(magit-branch-current ((t (:foreground ,nezburn-blue   :weight bold :box t))))
   `(magit-head           ((t (:foreground ,nezburn-blue   :weight bold))))
   `(magit-refname        ((t (:background ,nezburn-bg+2 :foreground ,nezburn-fg :weight bold))))
   `(magit-refname-stash  ((t (:background ,nezburn-bg+2 :foreground ,nezburn-fg :weight bold))))
   `(magit-refname-wip    ((t (:background ,nezburn-bg+2 :foreground ,nezburn-fg :weight bold))))
   `(magit-signature-good      ((t (:foreground ,nezburn-green))))
   `(magit-signature-bad       ((t (:foreground ,nezburn-red))))
   `(magit-signature-untrusted ((t (:foreground ,nezburn-yellow))))
   `(magit-signature-expired   ((t (:foreground ,nezburn-orange))))
   `(magit-signature-revoked   ((t (:foreground ,nezburn-magenta))))
   '(magit-signature-error     ((t (:inherit    magit-signature-bad))))
   `(magit-cherry-unmatched    ((t (:foreground ,nezburn-cyan))))
   `(magit-cherry-equivalent   ((t (:foreground ,nezburn-magenta))))
   `(magit-reflog-commit       ((t (:foreground ,nezburn-green))))
   `(magit-reflog-amend        ((t (:foreground ,nezburn-magenta))))
   `(magit-reflog-merge        ((t (:foreground ,nezburn-green))))
   `(magit-reflog-checkout     ((t (:foreground ,nezburn-blue))))
   `(magit-reflog-reset        ((t (:foreground ,nezburn-red))))
   `(magit-reflog-rebase       ((t (:foreground ,nezburn-magenta))))
   `(magit-reflog-cherry-pick  ((t (:foreground ,nezburn-green))))
   `(magit-reflog-remote       ((t (:foreground ,nezburn-cyan))))
   `(magit-reflog-other        ((t (:foreground ,nezburn-cyan))))
;;;;; markup-faces
   `(markup-anchor-face ((t (:foreground ,nezburn-blue+1))))
   `(markup-code-face ((t (:inherit font-lock-constant-face))))
   `(markup-command-face ((t (:foreground ,nezburn-yellow))))
   `(markup-emphasis-face ((t (:inherit bold))))
   `(markup-internal-reference-face ((t (:foreground ,nezburn-yellow-2 :underline t))))
   `(markup-list-face ((t (:foreground ,nezburn-fg+1))))
   `(markup-meta-face ((t (:foreground ,nezburn-yellow))))
   `(markup-meta-hide-face ((t (:foreground ,nezburn-yellow))))
   `(markup-secondary-text-face ((t (:foreground ,nezburn-yellow-1))))
   `(markup-title-0-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(markup-title-1-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(markup-title-2-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(markup-title-3-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(markup-title-4-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(markup-typewriter-face ((t (:inherit font-lock-constant-face))))
   `(markup-verbatim-face ((t (:inherit font-lock-constant-face))))
   `(markup-value-face ((t (:foreground ,nezburn-yellow))))
;;;;; message-mode
   `(message-cited-text ((t (:inherit font-lock-comment-face))))
   `(message-header-name ((t (:foreground ,nezburn-green+1))))
   `(message-header-other ((t (:foreground ,nezburn-green))))
   `(message-header-to ((t (:foreground ,nezburn-yellow :weight bold))))
   `(message-header-cc ((t (:foreground ,nezburn-yellow :weight bold))))
   `(message-header-newsgroups ((t (:foreground ,nezburn-yellow :weight bold))))
   `(message-header-subject ((t (:foreground ,nezburn-orange :weight bold))))
   `(message-header-xheader ((t (:foreground ,nezburn-green))))
   `(message-mml ((t (:foreground ,nezburn-yellow :weight bold))))
   `(message-separator ((t (:inherit font-lock-comment-face))))
;;;;; mew
   `(mew-face-header-subject ((t (:foreground ,nezburn-orange))))
   `(mew-face-header-from ((t (:foreground ,nezburn-yellow))))
   `(mew-face-header-date ((t (:foreground ,nezburn-green))))
   `(mew-face-header-to ((t (:foreground ,nezburn-red))))
   `(mew-face-header-key ((t (:foreground ,nezburn-green))))
   `(mew-face-header-private ((t (:foreground ,nezburn-green))))
   `(mew-face-header-important ((t (:foreground ,nezburn-blue))))
   `(mew-face-header-marginal ((t (:foreground ,nezburn-fg :weight bold))))
   `(mew-face-header-warning ((t (:foreground ,nezburn-red))))
   `(mew-face-header-xmew ((t (:foreground ,nezburn-green))))
   `(mew-face-header-xmew-bad ((t (:foreground ,nezburn-red))))
   `(mew-face-body-url ((t (:foreground ,nezburn-orange))))
   `(mew-face-body-comment ((t (:foreground ,nezburn-fg :slant italic))))
   `(mew-face-body-cite1 ((t (:foreground ,nezburn-green))))
   `(mew-face-body-cite2 ((t (:foreground ,nezburn-blue))))
   `(mew-face-body-cite3 ((t (:foreground ,nezburn-orange))))
   `(mew-face-body-cite4 ((t (:foreground ,nezburn-yellow))))
   `(mew-face-body-cite5 ((t (:foreground ,nezburn-red))))
   `(mew-face-mark-review ((t (:foreground ,nezburn-blue))))
   `(mew-face-mark-escape ((t (:foreground ,nezburn-green))))
   `(mew-face-mark-delete ((t (:foreground ,nezburn-red))))
   `(mew-face-mark-unlink ((t (:foreground ,nezburn-yellow))))
   `(mew-face-mark-refile ((t (:foreground ,nezburn-green))))
   `(mew-face-mark-unread ((t (:foreground ,nezburn-red-2))))
   `(mew-face-eof-message ((t (:foreground ,nezburn-green))))
   `(mew-face-eof-part ((t (:foreground ,nezburn-yellow))))
;;;;; mic-paren
   `(paren-face-match ((t (:foreground ,nezburn-cyan :background ,nezburn-bg :weight bold))))
   `(paren-face-mismatch ((t (:foreground ,nezburn-bg :background ,nezburn-magenta :weight bold))))
   `(paren-face-no-match ((t (:foreground ,nezburn-bg :background ,nezburn-red :weight bold))))
;;;;; mingus
   `(mingus-directory-face ((t (:foreground ,nezburn-blue))))
   `(mingus-pausing-face ((t (:foreground ,nezburn-magenta))))
   `(mingus-playing-face ((t (:foreground ,nezburn-cyan))))
   `(mingus-playlist-face ((t (:foreground ,nezburn-cyan ))))
   `(mingus-mark-face ((t (:bold t :foreground ,nezburn-magenta))))
   `(mingus-song-file-face ((t (:foreground ,nezburn-yellow))))
   `(mingus-artist-face ((t (:foreground ,nezburn-cyan))))
   `(mingus-album-face ((t (:underline t :foreground ,nezburn-red+1))))
   `(mingus-album-stale-face ((t (:foreground ,nezburn-red+1))))
   `(mingus-stopped-face ((t (:foreground ,nezburn-red))))
;;;;; nav
   `(nav-face-heading ((t (:foreground ,nezburn-yellow))))
   `(nav-face-button-num ((t (:foreground ,nezburn-cyan))))
   `(nav-face-dir ((t (:foreground ,nezburn-green))))
   `(nav-face-hdir ((t (:foreground ,nezburn-red))))
   `(nav-face-file ((t (:foreground ,nezburn-fg))))
   `(nav-face-hfile ((t (:foreground ,nezburn-red-4))))
;;;;; merlin
   `(merlin-type-face ((t (:inherit highlight))))
   `(merlin-compilation-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-orange)))
      (t
       (:underline ,nezburn-orange))))
   `(merlin-compilation-error-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-red)))
      (t
       (:underline ,nezburn-red))))
;;;;; mu4e
   `(mu4e-cited-1-face ((t (:foreground ,nezburn-blue    :slant italic))))
   `(mu4e-cited-2-face ((t (:foreground ,nezburn-green+2 :slant italic))))
   `(mu4e-cited-3-face ((t (:foreground ,nezburn-blue-2  :slant italic))))
   `(mu4e-cited-4-face ((t (:foreground ,nezburn-green   :slant italic))))
   `(mu4e-cited-5-face ((t (:foreground ,nezburn-blue-4  :slant italic))))
   `(mu4e-cited-6-face ((t (:foreground ,nezburn-green-2 :slant italic))))
   `(mu4e-cited-7-face ((t (:foreground ,nezburn-blue    :slant italic))))
   `(mu4e-replied-face ((t (:foreground ,nezburn-bg+3))))
   `(mu4e-trashed-face ((t (:foreground ,nezburn-bg+3 :strike-through t))))
;;;;; mumamo
   `(mumamo-background-chunk-major ((t (:background nil))))
   `(mumamo-background-chunk-submode1 ((t (:background ,nezburn-bg-1))))
   `(mumamo-background-chunk-submode2 ((t (:background ,nezburn-bg+2))))
   `(mumamo-background-chunk-submode3 ((t (:background ,nezburn-bg+3))))
   `(mumamo-background-chunk-submode4 ((t (:background ,nezburn-bg+1))))
;;;;; neotree
   `(neo-banner-face ((t (:foreground ,nezburn-blue+1 :weight bold))))
   `(neo-header-face ((t (:foreground ,nezburn-fg))))
   `(neo-root-dir-face ((t (:foreground ,nezburn-blue+1 :weight bold))))
   `(neo-dir-link-face ((t (:foreground ,nezburn-blue))))
   `(neo-file-link-face ((t (:foreground ,nezburn-fg))))
   `(neo-expand-btn-face ((t (:foreground ,nezburn-blue))))
   `(neo-vc-default-face ((t (:foreground ,nezburn-fg+1))))
   `(neo-vc-user-face ((t (:foreground ,nezburn-red :slant italic))))
   `(neo-vc-up-to-date-face ((t (:foreground ,nezburn-fg))))
   `(neo-vc-edited-face ((t (:foreground ,nezburn-magenta))))
   `(neo-vc-needs-merge-face ((t (:foreground ,nezburn-red+1))))
   `(neo-vc-unlocked-changes-face ((t (:foreground ,nezburn-red :background ,nezburn-blue-5))))
   `(neo-vc-added-face ((t (:foreground ,nezburn-green+1))))
   `(neo-vc-conflict-face ((t (:foreground ,nezburn-red+1))))
   `(neo-vc-missing-face ((t (:foreground ,nezburn-red+1))))
   `(neo-vc-ignored-face ((t (:foreground ,nezburn-fg-1))))
;;;;; notmuch
   `(notmuch-crypto-decryption ((t (:foreground ,nezburn-bg :background ,nezburn-magenta))))
   `(notmuch-crypto-part-header ((t (:foreground ,nezburn-blue+1))))
   `(notmuch-crypto-signature-bad ((t (:foreground ,nezburn-bg :background ,nezburn-red))))
   `(notmuch-crypto-signature-good ((t (:foreground ,nezburn-bg :background ,nezburn-green+1))))
   `(notmuch-crypto-signature-good-key ((t (:foreground ,nezburn-bg :background ,nezburn-orange))))
   `(notmuch-crypto-signature-unknown ((t (:foreground ,nezburn-bg :background ,nezburn-red))))
   `(notmuch-hello-logo-background ((t (:background ,nezburn-bg+2))))
   `(notmuch-message-summary-face ((t (:background ,nezburn-bg-08))))
   `(notmuch-search-flagged-face ((t (:foreground ,nezburn-blue+1))))
   `(notmuch-search-non-matching-authors ((t (:foreground ,nezburn-fg-1))))
   `(notmuch-tag-added ((t (:underline ,nezburn-green+1))))
   `(notmuch-tag-deleted ((t (:strike-through ,nezburn-red))))
   `(notmuch-tag-face ((t (:foreground ,nezburn-green+1))))
   `(notmuch-tag-flagged ((t (:foreground ,nezburn-blue+1))))
   `(notmuch-tag-unread ((t (:foreground ,nezburn-red))))
   `(notmuch-tree-match-author-face ((t (:foreground ,nezburn-green+1))))
   `(notmuch-tree-match-tag-face ((t (:foreground ,nezburn-green+1))))
;;;;; orderless
   `(orderless-match-face-0 ((t (:foreground ,nezburn-green))))
   `(orderless-match-face-1 ((t (:foreground ,nezburn-magenta))))
   `(orderless-match-face-2 ((t (:foreground ,nezburn-blue))))
   `(orderless-match-face-3 ((t (:foreground ,nezburn-orange))))
;;;;; org-mode
   `(org-agenda-date-today
     ((t (:foreground ,nezburn-fg+1 :slant italic :weight bold))) t)
   `(org-agenda-structure
     ((t (:inherit font-lock-comment-face))))
   `(org-archived ((t (:foreground ,nezburn-fg :weight bold))))
   `(org-block ((t (:background ,nezburn-bg+05 :extend t))))
   `(org-checkbox ((t (:background ,nezburn-bg+2 :foreground ,nezburn-fg+1
                                   :box (:line-width 1 :style released-button)))))
   `(org-date ((t (:foreground ,nezburn-blue :underline t))))
   `(org-deadline-announce ((t (:foreground ,nezburn-red-1))))
   `(org-done ((t (:weight bold :weight bold :foreground ,nezburn-green+3))))
   `(org-formula ((t (:foreground ,nezburn-yellow-2))))
   `(org-headline-done ((t (:foreground ,nezburn-green+3))))
   `(org-hide ((t (:foreground ,nezburn-bg))))
   `(org-level-1 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-orange
                               ,@(when nezburn-scale-org-headlines
                                   (list :height nezburn-height-plus-4))))))
   `(org-level-2 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-green+4
                               ,@(when nezburn-scale-org-headlines
                                   (list :height nezburn-height-plus-3))))))
   `(org-level-3 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-blue-1
                               ,@(when nezburn-scale-org-headlines
                                   (list :height nezburn-height-plus-2))))))
   `(org-level-4 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-yellow-2
                               ,@(when nezburn-scale-org-headlines
                                   (list :height nezburn-height-plus-1))))))
   `(org-level-5 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-cyan))))
   `(org-level-6 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-green+2))))
   `(org-level-7 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-red+2))))
   `(org-level-8 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-magenta))))
   `(org-link ((t (:foreground ,nezburn-yellow-2 :underline t))))
   `(org-quote ((t (:background ,nezburn-bg+05 :extend t))))
   `(org-scheduled ((t (:foreground ,nezburn-green+4))))
   `(org-scheduled-previously ((t (:foreground ,nezburn-red))))
   `(org-scheduled-today ((t (:foreground ,nezburn-blue+1))))
   `(org-sexp-date ((t (:foreground ,nezburn-blue+1 :underline t))))
   `(org-special-keyword ((t (:inherit font-lock-comment-face))))
   `(org-table ((t (:foreground ,nezburn-green+2))))
   `(org-tag ((t (:weight bold :weight bold))))
   `(org-time-grid ((t (:foreground ,nezburn-orange))))
   `(org-todo ((t (:weight bold :foreground ,nezburn-red :weight bold))))
   `(org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
   `(org-warning ((t (:weight bold :foreground ,nezburn-red :weight bold :underline nil))))
   `(org-column ((t (:background ,nezburn-bg-1))))
   `(org-column-title ((t (:background ,nezburn-bg-1 :underline t :weight bold))))
   `(org-mode-line-clock ((t (:foreground ,nezburn-fg :background ,nezburn-bg-1))))
   `(org-mode-line-clock-overrun ((t (:foreground ,nezburn-bg :background ,nezburn-red-1))))
   `(org-ellipsis ((t (:foreground ,nezburn-yellow-1 :underline t))))
   `(org-footnote ((t (:foreground ,nezburn-cyan :underline t))))
   `(org-document-title ((t (:inherit ,z-variable-pitch :foreground ,nezburn-blue
                                      :weight bold
                                      ,@(when nezburn-scale-org-headlines
                                          (list :height nezburn-height-plus-4))))))
   `(org-document-info ((t (:foreground ,nezburn-blue))))
   `(org-habit-ready-face ((t :background ,nezburn-green)))
   `(org-habit-alert-face ((t :background ,nezburn-yellow-1 :foreground ,nezburn-bg)))
   `(org-habit-clear-face ((t :background ,nezburn-blue-3)))
   `(org-habit-overdue-face ((t :background ,nezburn-red-3)))
   `(org-habit-clear-future-face ((t :background ,nezburn-blue-4)))
   `(org-habit-ready-future-face ((t :background ,nezburn-green-2)))
   `(org-habit-alert-future-face ((t :background ,nezburn-yellow-2 :foreground ,nezburn-bg)))
   `(org-habit-overdue-future-face ((t :background ,nezburn-red-4)))
;;;;; org-ref
   `(org-ref-ref-face ((t :underline t)))
   `(org-ref-label-face ((t :underline t)))
   `(org-ref-cite-face ((t :underline t)))
   `(org-ref-glossary-face ((t :underline t)))
   `(org-ref-acronym-face ((t :underline t)))
;;;;; outline
   `(outline-1 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-orange
                             ,@(when nezburn-scale-outline-headlines
                                 (list :height nezburn-height-plus-4))))))
   `(outline-2 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-green+4
                             ,@(when nezburn-scale-outline-headlines
                                 (list :height nezburn-height-plus-3))))))
   `(outline-3 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-blue-1
                             ,@(when nezburn-scale-outline-headlines
                                 (list :height nezburn-height-plus-2))))))
   `(outline-4 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-yellow-2
                             ,@(when nezburn-scale-outline-headlines
                                 (list :height nezburn-height-plus-1))))))
   `(outline-5 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-cyan))))
   `(outline-6 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-green+2))))
   `(outline-7 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-red-4))))
   `(outline-8 ((t (:inherit ,z-variable-pitch :foreground ,nezburn-blue-4))))
;;;;; p4
   `(p4-depot-added-face ((t :inherit diff-added)))
   `(p4-depot-branch-op-face ((t :inherit diff-changed)))
   `(p4-depot-deleted-face ((t :inherit diff-removed)))
   `(p4-depot-unmapped-face ((t :inherit diff-changed)))
   `(p4-diff-change-face ((t :inherit diff-changed)))
   `(p4-diff-del-face ((t :inherit diff-removed)))
   `(p4-diff-file-face ((t :inherit diff-file-header)))
   `(p4-diff-head-face ((t :inherit diff-header)))
   `(p4-diff-ins-face ((t :inherit diff-added)))
;;;;; c/perl
   `(cperl-nonoverridable-face ((t (:foreground ,nezburn-magenta))))
   `(cperl-array-face ((t (:foreground ,nezburn-yellow, :background ,nezburn-bg))))
   `(cperl-hash-face ((t (:foreground ,nezburn-yellow-1, :background ,nezburn-bg))))
;;;;; paren-face
   `(parenthesis ((t (:foreground ,nezburn-fg-1))))
;;;;; perspective
   `(persp-selected-face ((t (:foreground ,nezburn-yellow-2))))
;;;;; powerline
   `(powerline-active1 ((t (:background ,nezburn-bg-05 :inherit mode-line))))
   `(powerline-active2 ((t (:background ,nezburn-bg+2 :inherit mode-line))))
   `(powerline-inactive1 ((t (:background ,nezburn-bg+1 :inherit mode-line-inactive))))
   `(powerline-inactive2 ((t (:background ,nezburn-bg+3 :inherit mode-line-inactive))))
;;;;; proofgeneral
   `(proof-active-area-face ((t (:underline t))))
   `(proof-boring-face ((t (:foreground ,nezburn-fg :background ,nezburn-bg+2))))
   `(proof-command-mouse-highlight-face ((t (:inherit proof-mouse-highlight-face))))
   `(proof-debug-message-face ((t (:inherit proof-boring-face))))
   `(proof-declaration-name-face ((t (:inherit font-lock-keyword-face :foreground nil))))
   `(proof-eager-annotation-face ((t (:foreground ,nezburn-bg :background ,nezburn-orange))))
   `(proof-error-face ((t (:foreground ,nezburn-fg :background ,nezburn-red-4))))
   `(proof-highlight-dependency-face ((t (:foreground ,nezburn-bg :background ,nezburn-yellow-1))))
   `(proof-highlight-dependent-face ((t (:foreground ,nezburn-bg :background ,nezburn-orange))))
   `(proof-locked-face ((t (:background ,nezburn-blue-5))))
   `(proof-mouse-highlight-face ((t (:foreground ,nezburn-bg :background ,nezburn-orange))))
   `(proof-queue-face ((t (:background ,nezburn-red-4))))
   `(proof-region-mouse-highlight-face ((t (:inherit proof-mouse-highlight-face))))
   `(proof-script-highlight-error-face ((t (:background ,nezburn-red-2))))
   `(proof-tacticals-name-face ((t (:inherit font-lock-constant-face :foreground nil :background ,nezburn-bg))))
   `(proof-tactics-name-face ((t (:inherit font-lock-constant-face :foreground nil :background ,nezburn-bg))))
   `(proof-warning-face ((t (:foreground ,nezburn-bg :background ,nezburn-yellow-1))))
;;;;; racket-mode
   `(racket-keyword-argument-face ((t (:inherit font-lock-constant-face))))
   `(racket-selfeval-face ((t (:inherit font-lock-type-face))))
;;;;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,nezburn-fg))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,nezburn-green+4))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,nezburn-yellow-2))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,nezburn-cyan))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,nezburn-green+2))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,nezburn-blue+1))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,nezburn-yellow-1))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,nezburn-green+1))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,nezburn-blue-2))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,nezburn-orange))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,nezburn-green))))
   `(rainbow-delimiters-depth-12-face ((t (:foreground ,nezburn-blue-5))))
;;;;; rcirc
   `(rcirc-my-nick ((t (:foreground ,nezburn-blue))))
   `(rcirc-other-nick ((t (:foreground ,nezburn-orange))))
   `(rcirc-bright-nick ((t (:foreground ,nezburn-blue+1))))
   `(rcirc-dim-nick ((t (:foreground ,nezburn-blue-2))))
   `(rcirc-server ((t (:foreground ,nezburn-green))))
   `(rcirc-server-prefix ((t (:foreground ,nezburn-green+1))))
   `(rcirc-timestamp ((t (:foreground ,nezburn-green+2))))
   `(rcirc-nick-in-message ((t (:foreground ,nezburn-yellow))))
   `(rcirc-nick-in-message-full-line ((t (:weight bold))))
   `(rcirc-prompt ((t (:foreground ,nezburn-yellow :weight bold))))
   `(rcirc-track-nick ((t (:inverse-video t))))
   `(rcirc-track-keyword ((t (:weight bold))))
   `(rcirc-url ((t (:weight bold))))
   `(rcirc-keyword ((t (:foreground ,nezburn-yellow :weight bold))))
;;;;; re-builder
   `(reb-match-0 ((t (:foreground ,nezburn-bg :background ,nezburn-magenta))))
   `(reb-match-1 ((t (:foreground ,nezburn-bg :background ,nezburn-blue))))
   `(reb-match-2 ((t (:foreground ,nezburn-bg :background ,nezburn-orange))))
   `(reb-match-3 ((t (:foreground ,nezburn-bg :background ,nezburn-red))))
;;;;; realgud
   `(realgud-overlay-arrow1 ((t (:foreground ,nezburn-green))))
   `(realgud-overlay-arrow2 ((t (:foreground ,nezburn-yellow))))
   `(realgud-overlay-arrow3 ((t (:foreground ,nezburn-orange))))
   `(realgud-bp-enabled-face ((t (:inherit error))))
   `(realgud-bp-disabled-face ((t (:inherit secondary-selection))))
   `(realgud-bp-line-enabled-face ((t (:box (:color ,nezburn-red :style nil)))))
   `(realgud-bp-line-disabled-face ((t (:box (:color "grey70" :style nil)))))
   `(realgud-line-number ((t (:foreground ,nezburn-yellow))))
   `(realgud-backtrace-number ((t (:foreground ,nezburn-yellow, :weight bold))))
;;;;; regex-tool
   `(regex-tool-matched-face ((t (:background ,nezburn-blue-4 :weight bold))))
;;;;; rmail
   `(rmail-highlight ((t (:foreground ,nezburn-yellow :weight bold))))
   `(rmail-header-name ((t (:foreground ,nezburn-blue))))
;;;;; rpm-mode
   `(rpm-spec-dir-face ((t (:foreground ,nezburn-green))))
   `(rpm-spec-doc-face ((t (:foreground ,nezburn-green))))
   `(rpm-spec-ghost-face ((t (:foreground ,nezburn-red))))
   `(rpm-spec-macro-face ((t (:foreground ,nezburn-yellow))))
   `(rpm-spec-obsolete-tag-face ((t (:foreground ,nezburn-red))))
   `(rpm-spec-package-face ((t (:foreground ,nezburn-red))))
   `(rpm-spec-section-face ((t (:foreground ,nezburn-yellow))))
   `(rpm-spec-tag-face ((t (:foreground ,nezburn-blue))))
   `(rpm-spec-var-face ((t (:foreground ,nezburn-red))))
;;;;; rst-mode
   `(rst-level-1-face ((t (:foreground ,nezburn-orange))))
   `(rst-level-2-face ((t (:foreground ,nezburn-green+1))))
   `(rst-level-3-face ((t (:foreground ,nezburn-blue-1))))
   `(rst-level-4-face ((t (:foreground ,nezburn-yellow-2))))
   `(rst-level-5-face ((t (:foreground ,nezburn-cyan))))
   `(rst-level-6-face ((t (:foreground ,nezburn-green-2))))
;;;;; selectrum
   `(selectrum-current-candidate ((t (:foreground ,nezburn-yellow :weight bold :underline t))))
   `(selectrum-primary-highlight ((t (:background ,nezburn-green-2))))
   `(selectrum-secondary-highlight ((t (:background ,nezburn-green))))
;;;;; sh-mode
   `(sh-heredoc     ((t (:foreground ,nezburn-yellow :weight bold))))
   `(sh-quoted-exec ((t (:foreground ,nezburn-red))))
;;;;; show-paren
   `(show-paren-mismatch ((t (:foreground ,nezburn-red+1 :background ,nezburn-bg+3 :weight bold))))
   `(show-paren-match ((t (:foreground ,nezburn-fg :background ,nezburn-bg+3 :weight bold))))
;;;;; smart-mode-line
   ;; use (setq sml/theme nil) to enable nezburn for sml
   `(sml/global ((,class (:foreground ,nezburn-fg :weight bold))))
   `(sml/modes ((,class (:foreground ,nezburn-yellow :weight bold))))
   `(sml/minor-modes ((,class (:foreground ,nezburn-fg-1 :weight bold))))
   `(sml/filename ((,class (:foreground ,nezburn-yellow :weight bold))))
   `(sml/line-number ((,class (:foreground ,nezburn-blue :weight bold))))
   `(sml/col-number ((,class (:foreground ,nezburn-blue+1 :weight bold))))
   `(sml/position-percentage ((,class (:foreground ,nezburn-blue-1 :weight bold))))
   `(sml/prefix ((,class (:foreground ,nezburn-orange))))
   `(sml/git ((,class (:foreground ,nezburn-green+3))))
   `(sml/process ((,class (:weight bold))))
   `(sml/sudo ((,class  (:foreground ,nezburn-orange :weight bold))))
   `(sml/read-only ((,class (:foreground ,nezburn-red-2))))
   `(sml/outside-modified ((,class (:foreground ,nezburn-orange))))
   `(sml/modified ((,class (:foreground ,nezburn-red))))
   `(sml/vc-edited ((,class (:foreground ,nezburn-green+2))))
   `(sml/charging ((,class (:foreground ,nezburn-green+4))))
   `(sml/discharging ((,class (:foreground ,nezburn-red+1))))
;;;;; smartparens
   `(sp-show-pair-mismatch-face ((t (:foreground ,nezburn-red+1 :background ,nezburn-bg+3 :weight bold))))
   `(sp-show-pair-match-face ((t (:background ,nezburn-bg+3 :weight bold))))
;;;;; sml-mode-line
   '(sml-modeline-end-face ((t :inherit default :width condensed)))
;;;;; SLIME
   `(slime-repl-output-face ((t (:foreground ,nezburn-red))))
   `(slime-repl-inputed-output-face ((t (:foreground ,nezburn-green))))
   `(slime-error-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-red)))
      (t
       (:underline ,nezburn-red))))
   `(slime-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-orange)))
      (t
       (:underline ,nezburn-orange))))
   `(slime-style-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-yellow)))
      (t
       (:underline ,nezburn-yellow))))
   `(slime-note-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-green)))
      (t
       (:underline ,nezburn-green))))
   `(slime-highlight-face ((t (:inherit highlight))))
;;;;; SLY
   `(sly-mrepl-output-face ((t (:foreground ,nezburn-red))))
   `(sly-error-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-red)))
      (t
       (:underline ,nezburn-red))))
   `(sly-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-orange)))
      (t
       (:underline ,nezburn-orange))))
   `(sly-style-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-yellow)))
      (t
       (:underline ,nezburn-yellow))))
   `(sly-note-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nezburn-green)))
      (t
       (:underline ,nezburn-green))))
   `(sly-stickers-placed-face ((t (:foreground ,nezburn-fg :background ,nezburn-bg+3))))
;;;;; solaire
   `(solaire-default-face ((t (:inherit default :background ,nezburn-bg-08))))
   `(solaire-minibuffer-face ((t (:inherit default :background ,nezburn-bg-08))))
   `(solaire-hl-line-face ((t (:inherit hl-line :background ,nezburn-bg))))
   `(solaire-org-hide-face ((t (:inherit org-hide :background ,nezburn-bg-08))))
;;;;; speedbar
   `(speedbar-button-face ((t (:foreground ,nezburn-green+2))))
   `(speedbar-directory-face ((t (:foreground ,nezburn-cyan))))
   `(speedbar-file-face ((t (:foreground ,nezburn-fg))))
   `(speedbar-highlight-face ((t (:foreground ,nezburn-bg :background ,nezburn-green+2))))
   `(speedbar-selected-face ((t (:foreground ,nezburn-red))))
   `(speedbar-separator-face ((t (:foreground ,nezburn-bg :background ,nezburn-blue-1))))
   `(speedbar-tag-face ((t (:foreground ,nezburn-yellow))))
;;;;; swiper
   `(swiper-line-face ((t (:underline t))))
;;;;; sx
   `(sx-custom-button
     ((t (:background ,nezburn-fg :foreground ,nezburn-bg-1
                      :box (:line-width 3 :style released-button) :height 0.9))))
   `(sx-question-list-answers
     ((t (:foreground ,nezburn-green+3
                      :height 1.0 :inherit sx-question-list-parent))))
   `(sx-question-mode-accepted
     ((t (:foreground ,nezburn-green+3
                      :height 1.3 :inherit sx-question-mode-title))))
   '(sx-question-mode-content-face ((t (:inherit highlight))))
   `(sx-question-mode-kbd-tag
     ((t (:box (:color ,nezburn-bg-1 :line-width 3 :style released-button)
               :height 0.9 :weight semi-bold))))
;;;;; tabbar
   `(tabbar-button ((t (:foreground ,nezburn-fg
                                    :background ,nezburn-bg))))
   `(tabbar-selected ((t (:foreground ,nezburn-fg
                                      :background ,nezburn-bg
                                      :box (:line-width -1 :style pressed-button)))))
   `(tabbar-unselected ((t (:foreground ,nezburn-fg
                                        :background ,nezburn-bg+1
                                        :box (:line-width -1 :style released-button)))))
;;;;; tab-bar
   `(tab-bar ((t (:background ,nezburn-bg+1))))
   `(tab-bar-tab ((t (:foreground ,nezburn-fg
                                  :background ,nezburn-bg
                                  :weight bold
                                  :box (:line-width -1 :style released-button)))))
   `(tab-bar-tab-inactive ((t (:foreground ,nezburn-fg
                                           :background ,nezburn-bg+1
                                           :box (:line-width -1 :style released-button)))))
;;;;; tab-line
   `(tab-line ((t (:background ,nezburn-bg+1))))
   `(tab-line-tab ((t (:foreground ,nezburn-fg
                                  :background ,nezburn-bg
                                  :weight bold
                                  :box (:line-width -1 :style released-button)))))
   `(tab-line-tab-inactive ((t (:foreground ,nezburn-fg
                                           :background ,nezburn-bg+1
                                           :box (:line-width -1 :style released-button)))))
   `(tab-line-tab-current ((t (:foreground ,nezburn-fg
                                           :background ,nezburn-bg+1
                                           :box (:line-width -1 :style pressed-button)))))
;;;;; term
   `(term-color-black ((t (:foreground ,nezburn-bg
                                       :background ,nezburn-bg-1))))
   `(term-color-red ((t (:foreground ,nezburn-red-2
                                     :background ,nezburn-red-4))))
   `(term-color-green ((t (:foreground ,nezburn-green
                                       :background ,nezburn-green+2))))
   `(term-color-yellow ((t (:foreground ,nezburn-orange
                                        :background ,nezburn-yellow))))
   `(term-color-blue ((t (:foreground ,nezburn-blue-1
                                      :background ,nezburn-blue-4))))
   `(term-color-magenta ((t (:foreground ,nezburn-magenta
                                         :background ,nezburn-red))))
   `(term-color-cyan ((t (:foreground ,nezburn-cyan
                                      :background ,nezburn-blue))))
   `(term-color-white ((t (:foreground ,nezburn-fg
                                       :background ,nezburn-fg-1))))
   '(term-default-fg-color ((t (:inherit term-color-white))))
   '(term-default-bg-color ((t (:inherit term-color-black))))
;;;;; undo-tree
   `(undo-tree-visualizer-active-branch-face ((t (:foreground ,nezburn-fg+1 :weight bold))))
   `(undo-tree-visualizer-current-face ((t (:foreground ,nezburn-red-1 :weight bold))))
   `(undo-tree-visualizer-default-face ((t (:foreground ,nezburn-fg))))
   `(undo-tree-visualizer-register-face ((t (:foreground ,nezburn-yellow))))
   `(undo-tree-visualizer-unmodified-face ((t (:foreground ,nezburn-cyan))))
;;;;; vertico
   `(vertico-current ((t (:foreground ,nezburn-yellow :weight bold :underline t))))
;;;;; visual-regexp
   `(vr/group-0 ((t (:foreground ,nezburn-bg :background ,nezburn-green :weight bold))))
   `(vr/group-1 ((t (:foreground ,nezburn-bg :background ,nezburn-orange :weight bold))))
   `(vr/group-2 ((t (:foreground ,nezburn-bg :background ,nezburn-blue :weight bold))))
   `(vr/match-0 ((t (:inherit isearch))))
   `(vr/match-1 ((t (:foreground ,nezburn-yellow-2 :background ,nezburn-bg-1 :weight bold))))
   `(vr/match-separator-face ((t (:foreground ,nezburn-red :weight bold))))
;;;;; volatile-highlights
   `(vhl/default-face ((t (:background ,nezburn-bg-05))))
;;;;; web-mode
   `(web-mode-builtin-face ((t (:inherit ,font-lock-builtin-face))))
   `(web-mode-comment-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-constant-face ((t (:inherit ,font-lock-constant-face))))
   `(web-mode-css-at-rule-face ((t (:foreground ,nezburn-orange ))))
   `(web-mode-css-prop-face ((t (:foreground ,nezburn-orange))))
   `(web-mode-css-pseudo-class-face ((t (:foreground ,nezburn-green+3 :weight bold))))
   `(web-mode-css-rule-face ((t (:foreground ,nezburn-blue))))
   `(web-mode-doctype-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-folded-face ((t (:underline t))))
   `(web-mode-function-name-face ((t (:foreground ,nezburn-blue))))
   `(web-mode-html-attr-name-face ((t (:foreground ,nezburn-orange))))
   `(web-mode-html-attr-value-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-html-tag-face ((t (:foreground ,nezburn-cyan))))
   `(web-mode-keyword-face ((t (:inherit ,font-lock-keyword-face))))
   `(web-mode-preprocessor-face ((t (:inherit ,font-lock-preprocessor-face))))
   `(web-mode-string-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-type-face ((t (:inherit ,font-lock-type-face))))
   `(web-mode-variable-name-face ((t (:inherit ,font-lock-variable-name-face))))
   `(web-mode-server-background-face ((t (:background ,nezburn-bg))))
   `(web-mode-server-comment-face ((t (:inherit web-mode-comment-face))))
   `(web-mode-server-string-face ((t (:inherit web-mode-string-face))))
   `(web-mode-symbol-face ((t (:inherit font-lock-constant-face))))
   `(web-mode-warning-face ((t (:inherit font-lock-warning-face))))
   `(web-mode-whitespaces-face ((t (:background ,nezburn-red))))
;;;;; whitespace-mode
   `(whitespace-space ((t (:background ,nezburn-bg+1 :foreground ,nezburn-bg+1))))
   `(whitespace-hspace ((t (:background ,nezburn-bg+1 :foreground ,nezburn-bg+1))))
   `(whitespace-tab ((t (:background ,nezburn-red-1))))
   `(whitespace-newline ((t (:foreground ,nezburn-bg+1))))
   `(whitespace-trailing ((t (:background ,nezburn-red))))
   `(whitespace-line ((t (:background ,nezburn-bg :foreground ,nezburn-magenta))))
   `(whitespace-space-before-tab ((t (:background ,nezburn-orange :foreground ,nezburn-orange))))
   `(whitespace-indentation ((t (:background ,nezburn-yellow :foreground ,nezburn-red))))
   `(whitespace-empty ((t (:background ,nezburn-yellow))))
   `(whitespace-space-after-tab ((t (:background ,nezburn-yellow :foreground ,nezburn-red))))
;;;;; wanderlust
   `(wl-highlight-folder-few-face ((t (:foreground ,nezburn-red-2))))
   `(wl-highlight-folder-many-face ((t (:foreground ,nezburn-red-1))))
   `(wl-highlight-folder-path-face ((t (:foreground ,nezburn-orange))))
   `(wl-highlight-folder-unread-face ((t (:foreground ,nezburn-blue))))
   `(wl-highlight-folder-zero-face ((t (:foreground ,nezburn-fg))))
   `(wl-highlight-folder-unknown-face ((t (:foreground ,nezburn-blue))))
   `(wl-highlight-message-citation-header ((t (:foreground ,nezburn-red-1))))
   `(wl-highlight-message-cited-text-1 ((t (:foreground ,nezburn-red))))
   `(wl-highlight-message-cited-text-2 ((t (:foreground ,nezburn-green+2))))
   `(wl-highlight-message-cited-text-3 ((t (:foreground ,nezburn-blue))))
   `(wl-highlight-message-cited-text-4 ((t (:foreground ,nezburn-blue+1))))
   `(wl-highlight-message-header-contents-face ((t (:foreground ,nezburn-green))))
   `(wl-highlight-message-headers-face ((t (:foreground ,nezburn-red+1))))
   `(wl-highlight-message-important-header-contents ((t (:foreground ,nezburn-green+2))))
   `(wl-highlight-message-header-contents ((t (:foreground ,nezburn-green+1))))
   `(wl-highlight-message-important-header-contents2 ((t (:foreground ,nezburn-green+2))))
   `(wl-highlight-message-signature ((t (:foreground ,nezburn-green))))
   `(wl-highlight-message-unimportant-header-contents ((t (:foreground ,nezburn-fg))))
   `(wl-highlight-summary-answered-face ((t (:foreground ,nezburn-blue))))
   `(wl-highlight-summary-disposed-face ((t (:foreground ,nezburn-fg
                                                         :slant italic))))
   `(wl-highlight-summary-new-face ((t (:foreground ,nezburn-blue))))
   `(wl-highlight-summary-normal-face ((t (:foreground ,nezburn-fg))))
   `(wl-highlight-summary-thread-top-face ((t (:foreground ,nezburn-yellow))))
   `(wl-highlight-thread-indent-face ((t (:foreground ,nezburn-magenta))))
   `(wl-highlight-summary-refiled-face ((t (:foreground ,nezburn-fg))))
   `(wl-highlight-summary-displaying-face ((t (:underline t :weight bold))))
;;;;; which-func-mode
   `(which-func ((t (:foreground ,nezburn-green+4))))
;;;;; xcscope
   `(cscope-file-face ((t (:foreground ,nezburn-yellow :weight bold))))
   `(cscope-function-face ((t (:foreground ,nezburn-cyan :weight bold))))
   `(cscope-line-number-face ((t (:foreground ,nezburn-red :weight bold))))
   `(cscope-mouse-face ((t (:foreground ,nezburn-bg :background ,nezburn-blue+1))))
   `(cscope-separator-face ((t (:foreground ,nezburn-red :weight bold
                                            :underline t :overline t))))
;;;;; yascroll
   `(yascroll:thumb-text-area ((t (:background ,nezburn-bg-1))))
   `(yascroll:thumb-fringe ((t (:background ,nezburn-bg-1 :foreground ,nezburn-bg-1))))
   ))

;;; Theme Variables
(nezburn-with-color-variables
  (custom-theme-set-variables
   'nezburn
;;;;; ansi-color
   `(ansi-color-names-vector [,nezburn-bg ,nezburn-red ,nezburn-green ,nezburn-yellow
                                          ,nezburn-blue ,nezburn-magenta ,nezburn-cyan ,nezburn-fg])
;;;;; company-quickhelp
   `(company-quickhelp-color-background ,nezburn-bg+1)
   `(company-quickhelp-color-foreground ,nezburn-fg)
;;;;; fill-column-indicator
   `(fci-rule-color ,nezburn-bg-05)
;;;;; nrepl-client
   `(nrepl-message-colors
     '(,nezburn-red ,nezburn-orange ,nezburn-yellow ,nezburn-green ,nezburn-green+4
       ,nezburn-cyan ,nezburn-blue+1 ,nezburn-magenta))
;;;;; pdf-tools
   `(pdf-view-midnight-colors '(,nezburn-fg . ,nezburn-bg-05))
;;;;; vc-annotate
   `(vc-annotate-color-map
     '(( 20. . ,nezburn-red-1)
       ( 40. . ,nezburn-red)
       ( 60. . ,nezburn-orange)
       ( 80. . ,nezburn-yellow-2)
       (100. . ,nezburn-yellow-1)
       (120. . ,nezburn-yellow)
       (140. . ,nezburn-green-2)
       (160. . ,nezburn-green)
       (180. . ,nezburn-green+1)
       (200. . ,nezburn-green+2)
       (220. . ,nezburn-green+3)
       (240. . ,nezburn-green+4)
       (260. . ,nezburn-cyan)
       (280. . ,nezburn-blue-2)
       (300. . ,nezburn-blue-1)
       (320. . ,nezburn-blue)
       (340. . ,nezburn-blue+1)
       (360. . ,nezburn-magenta)))
   `(vc-annotate-very-old-color ,nezburn-magenta)
   `(vc-annotate-background ,nezburn-bg-1)
   ))

;;; Rainbow Support

(declare-function rainbow-mode 'rainbow-mode)
(declare-function rainbow-colorize-by-assoc 'rainbow-mode)

(defcustom nezburn-add-font-lock-keywords nil
  "Whether to add font-lock keywords for nezburn color names.

In buffers visiting library `nezburn-theme.el' the nezburn
specific keywords are always added, provided that library has
been loaded (because that is where the code that does it is
defined).  If you visit this file and only enable the theme,
then you have to turn `rainbow-mode' off and on again for the
nezburn-specific font-lock keywords to be used.

In all other Emacs-Lisp buffers this variable controls whether
this should be done.  This requires library `rainbow-mode'."
  :type 'boolean
  :group 'nezburn-theme)

(defvar nezburn-colors-font-lock-keywords nil)

(defun nezburn--rainbow-turn-on ()
  "Maybe also add font-lock keywords for nezburn colors."
  (when (and (derived-mode-p 'emacs-lisp-mode)
             (or nezburn-add-font-lock-keywords
                 (and (buffer-file-name)
                      (equal (file-name-nondirectory (buffer-file-name))
                             "nezburn-theme.el"))))
    (unless nezburn-colors-font-lock-keywords
      (setq nezburn-colors-font-lock-keywords
            `((,(regexp-opt (mapcar 'car nezburn-default-colors-alist) 'words)
               (0 (rainbow-colorize-by-assoc nezburn-default-colors-alist))))))
    (font-lock-add-keywords nil nezburn-colors-font-lock-keywords 'end)))

(defun nezburn--rainbow-turn-off ()
  "Also remove font-lock keywords for nezburn colors."
  (font-lock-remove-keywords nil nezburn-colors-font-lock-keywords))

(when (fboundp 'advice-add)
  (advice-add 'rainbow-turn-on :after  #'nezburn--rainbow-turn-on)
  (advice-add 'rainbow-turn-off :after #'nezburn--rainbow-turn-off))

;;; Footer

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'nezburn)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; eval: (when (require 'rainbow-mode nil t) (rainbow-mode 1))
;; End:
;;; nezburn-theme.el ends here
