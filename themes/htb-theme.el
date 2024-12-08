
;; If you are distributing this theme, please replace this comment
;; with the appropriate license attributing the original VS Code
;; theme author.

(deftheme htb "A nice dark theme.")


(let (
(color0 "#141d2b")
(color1 "#a4b1cd")
(color2 "#28313f")
(acidgreen "#9fef00")
(color4 "#414a58")
(color5 "#2d3644")
(color6 "#2e3746")
(color7 "#b8c5e1")
(color8 "#424b5a")
(color9 "#ccd9f5")
(color10 "#1a2332")
(color11 "#5f6876")
(yellow "#FFCC5C")
(lightblue "#5CB2FF")
(red "#FF8484")
(lightgreen "#C5F467")
(color16 "#A4B1CD")
(color17 "#313f55")
(color18 "#232c3a")
(color19 "#b3c0dc")
(color20 "#1f2836")
(color21 "#afbcd8")
(purple "CF8DFB"))

(custom-theme-set-faces
'htb


;; BASIC FACES
`(default                                       ((t (:background ,color0 :foreground ,color1 ))))
`(hl-line                                       ((t (:background ,color2 ))))
`(cursor ((t (:background ,acidgreen))))
`(region ((t (:background ,color4 ))))
`(secondary-selection ((t (:background ,color5 ))))
`(fringe ((t (:background ,color0 ))))
`(mode-line-inactive ((t (:background ,color6 :foreground ,color7 ))))
`(mode-line ((t (:background ,color8 :foreground ,color9 ))))
`(minibuffer-prompt ((t (:background ,color10 ))))
`(border ((t (:background ,color10 :foreground ,color10 ))))
`(vertical-border ((t (:foreground ,color11 ))))


;; FONT LOCK FACES
`(font-lock-builtin-face ((t (:foreground ,yellow))))
`(font-lock-comment-face ((t (:fontStyle :italic t ))))
`(font-lock-constant-face ((t (:foreground ,lightblue))))
`(font-lock-function-name-face ((t (:foreground ,yellow))))
`(font-lock-keyword-face ((t (:foreground ,red))))
`(font-lock-string-face ((t (:foreground ,lightgreen))))
`(font-lock-variable-name-face ((t (:foreground ,color16 ))))


;; linum-mode
`(linum ((t (:foreground ,color17 ))))
`(linum-relative-current-face ((t (:foreground ,color17 ))))


;; display-line-number-mode
`(line-number ((t (:foreground ,color17 ))))
`(line-number-current-line ((t (:foreground ,color17 ))))


;; THIRD PARTY PACKAGE FACES


;; doom-modeline-mode
`(doom-modeline-bar ((t (:background ,color8 :foreground ,color9 ))))
`(doom-modeline-inactive-bar ((t (:background ,color6 :foreground ,color7 ))))


;; web-mode
`(web-mode-string-face ((t (:foreground ,lightgreen))))
`(web-mode-html-tag-face ((t (:foreground ,red))))
`(web-mode-html-tag-bracket-face ((t (:foreground ,red))))


;; company-mode
`(company-tooltip ((t (:background ,color18 :foreground ,color19 ))))


;; org-mode
`(org-block ((t (:background ,color20 :foreground ,color21 ))))))


(custom-theme-set-variables
  'htb
  '(linum-format " %3i "))


;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))


;;;###autoload
(defun htb-theme()
  "Apply the htb-theme."
  (interactive)
  (load-theme 'htb t))


(provide-theme 'htb)


;; Local Variables:
;; no-byte-compile: t
;; End:


