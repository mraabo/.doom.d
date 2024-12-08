;;; doom-htb-theme.el --- A theme inspired by hackthebox.com-*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: Dec 08, 2024
;; Author: mraabo <https://github.com/mraabo>
;; Maintainer:
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-htb-theme nil
  "Options for the `doom-htb' theme."
  :group 'doom-themes)

(defcustom doom-htb-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-htb-theme
  :type 'boolean)

(defcustom doom-htb-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-htb-theme
  :type 'boolean)

(defcustom doom-htb-brighter-text nil
  "If non-nil, default text will be brighter."
  :group 'doom-htb-theme
  :type 'boolean)

(defcustom doom-htb-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-htb-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme doom-htb
  "A theme inspired by hackthebox.com"

  ;; name        default   256       16
  ((bg         '("#141d2b" "#141d2b" "black"))
   (fg         (if doom-htb-brighter-text
                   '("#BBBBBB" "#BBBBBB" "brightwhite")
                 '("#a4b1cd" "#a4b1cd" "brightwhite")))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#10141f" "#10141f" "black"       ))
   (fg-alt     '("#5f6876" "#5f6876" "white"       ))
   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#1a2332" "#1a2332" "brightblack" ))
   (base1      '("#232c3a" "#232c3a" "brightblack" ))
   (base2      '("#2d3644" "#2d3644" "brightblack" ))
   (base3      '("#313f55" "#313f55" "brightblack" ))
   (base4      '("#424b5a" "#424b5a" "brightblack" ))
   (base5      '("#414a58" "#414a58" "brightblack" ))
   (base6      '("#afbcd8" "#afbcd8" "brightblack" ))
   (base7      '("#b3c0dc" "#b3c0dc" "brightblack" ))
   (base8      '("#b8c5e1" "#b8c5e1" "white"       ))
   (grey       base4)
   (red        '("#FF8484" "#FF8484" "red"          ))
   (orange     '("#FF8484" "#FF8484" "brightred"    ))
   (spacegreen '("#5CECC6" "#5CECC6" "green"        ))
   (acidgreen  '("#9FEF00" "#9FEF00" "green"        ))
   (green      '("#C5F467" "#C5F467" "green"        ))
   (teal       '("#5CB2FF" "#5CB2FF" "blue"  ))
   (yellow     '("#FFCC5C" "#FFCC5C" "yellow"       ))
   (blue       '("#5CB2FF" "#5CB2FF" "brightblue"   ))
   (dark-blue  '("#313f55" "#313f55" "blue"         ))
   (magenta    '("#5f6876" "#5f6876" "magenta"      ))
   (cyan       '("#5CB2FF" "#5CB2FF" "brightcyan"   ))
   (dark-cyan  '("#28313f" "#28313f" "cyan"         ))
   (purple     '("#CF8DFB" "#CF8DFB" "purple"       ))
   (violet     '("#CF8DFB" "#CF8DFB" "purple"       ))

   ;; face categories -- required for all themes
   (highlight      base8)
   (vertical-bar   (doom-darken base1 0.5))
   (selection      dark-blue)
   (builtin        yellow)
   (comments       base5)
   (doc-comments   acidgreen)
   (constants      blue)
   (functions      yellow)
   (keywords       red)
   (methods        teal)
   (operators      red)
   (type           teal)
   (strings        green)
   (variables      purple)
   (numbers        blue)
   (region         base4)
   (cursor         green)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    yellow)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (-modeline-bright doom-htb-brighter-modeline)
   (-modeline-pad
    (when doom-htb-padded-modeline
      (if (integerp doom-htb-padded-modeline) doom-htb-padded-modeline 4)))

   (modeline-fg 'unspecified)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        base3
      `(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-alt
    (if -modeline-bright
        base3
      `(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt (doom-darken bg 0.1)))


  ;;;; Base theme face overrides
  (((font-lock-comment-face &override)
    :background (if doom-htb-brighter-comments (doom-lighten bg 0.05) 'unspecified))
   ((font-lock-keyword-face &override) :weight 'bold)
   ((font-lock-constant-face &override) :weight 'bold)
   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))

   ;;;; centaur-tabs
   (centaur-tabs-active-bar-face :background blue)
   (centaur-tabs-modified-marker-selected
    :inherit 'centaur-tabs-selected :foreground blue)
   (centaur-tabs-modified-marker-unselected
    :inherit 'centaur-tabs-unselected :foreground blue)
   ;;;; company
   (company-tooltip-selection     :background dark-cyan)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background blue)
   (doom-modeline-evil-emacs-state  :foreground red)
   (doom-modeline-evil-insert-state :foreground blue)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; helm
   (helm-selection :inherit 'bold
                   :background selection
                   :distant-foreground bg
                   :extend t)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-url-face    :foreground teal :weight 'normal)
   (markdown-reference-face :foreground base6)
   ((markdown-bold-face &override)   :foreground fg)
   ((markdown-italic-face &override) :foreground fg-alt)
   ;;;; outline <built-in>
   ((outline-1 &override) :foreground blue)
   ((outline-2 &override) :foreground green)
   ((outline-3 &override) :foreground purple)
   ((outline-4 &override) :foreground (doom-darken blue 0.2))
   ((outline-5 &override) :foreground (doom-darken green 0.2))
   ((outline-6 &override) :foreground (doom-darken teal 0.2))
   ((outline-7 &override) :foreground (doom-darken blue 0.4))
   ((outline-8 &override) :foreground (doom-darken green 0.4))
   ;;;; org <built-in>
   ((org-block &override) :background base0)
   ((org-block-begin-line &override) :foreground comments :background base0)
   ((org-link &override) :foreground purple)
   ((org-level-1 &override) :foreground red)
   ((org-level-2 &override) :foreground spacegreen)
   ((org-level-3 &override) :foreground blue)
   ((org-level-4 &override) :foreground green)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt))))

  ;;;; Base theme variable overrides-
  ;; ()
  )

;;; doom-htb-theme.el ends here
