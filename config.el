;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

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
(setq doom-theme 'doom-material)

;; Open Doom in fullscreen
(add-hook 'window-setup-hook #'toggle-frame-maximized)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(after! latex
        ;; Automatically breaks lines
        (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(after! org-download
        ;; Setting the default way of storing images to be linked from a directory.
        (setq-default org-download-method 'directory)
        ;; Setting default directory to store images related to the use of org-download.
        (setq-default org-download-image-dir "~/org/roam/cs_notes/Assets")
        ;; Set all images to have width 600
        (setq org-download-image-org-width 600)
        ;; Set links to be correctly formatted with the approach of storing in directory.
        (setq org-download-link-format "[[file:%s]]\n"
                org-download-abbreviate-filename-function #'file-relative-name)
        ;; Ensure images are inserted instead of their links when exporting to pdf (I think).
        (setq org-download-link-format-function #'org-download-link-format-function-default))

(after! org
        ;; Automatically breaks lines
        (add-hook 'org-mode-hook 'turn-on-auto-fill)
        ;; Resize Org headings
        (dolist (face '((org-level-1 . 1.35)
                        (org-level-2 . 1.3)
                        (org-level-3 . 1.2)
                        (org-level-4 . 1.1)
                        (org-level-5 . 1.1)
                        (org-level-6 . 1.1)
                        (org-level-7 . 1.1)
                        (org-level-8 . 1.1)))
        (set-face-attribute (car face) nil :weight 'bold :height (cdr face)))

        ;; Make the document title a bit bigger
        (set-face-attribute 'org-document-title nil  :weight
        'bold :height 1.8)

        ;; Hide leading stars and display entities like
        ;; \alpha as the actual greek letter.
        (setq org-hide-leading-stars t
                org-pretty-entities t

                ;; Make src-code be displayed using the corresponding major mode in Org-mode
                ;; and let tab act in a source code block as it would when normally writing
                ;; that language.
                org-src-fontify-natively t
                org-src-tab-acts-natively t
                org-edit-src-content-indentation 0
        )

        ;; Hide emphasis markers (e.g. *...* for bold) but show when hovering over
        ;; for easy editing.
        (use-package org-appear
                :commands (org-appear-mode)
                :hook     (org-mode . org-appear-mode)
                :config
                (setq org-hide-emphasis-markers t)  ; Must be activated for org-appear to work
                (setq org-appear-autoemphasis   t   ; Show bold, italics, verbatim, etc.
                        org-appear-autolinks      t   ; Show links
                        org-appear-autosubmarkers t)) ; Show sub- and superscripts

        ;; Styling of UI elements like bullets, TODOs and checkboxes.
        (use-package org-superstar
                :config
                (setq org-superstar-leading-bullet " ")
                (setq org-superstar-headline-bullets-list '("◉" "○" "⚬" "◈" "◇"))
                (setq org-superstar-special-todo-items t)
                ;; Makes TODO header bullets into boxes
                (setq org-superstar-todo-bullet-alist '(("TODO"  . 9744)
                                                        ("WAIT"  . 9744)
                                                        ("READ"  . 9744)
                                                        ("PROG"  . 9744)
                                                        ("DONE"  . 9745)))
                :hook (org-mode . org-superstar-mode))

        ;; SVG styling of elements like progressbar, tags, priorities, and dates.
        (use-package svg-tag-mode
                :config
                (defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
                (defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
                (defconst day-re "[A-Za-z]\\{3\\}")
                (defconst day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re))

                (defun svg-progress-percent (value)
                        (svg-image (svg-lib-concat
                                (svg-lib-progress-bar (/ (string-to-number value) 100.0)
                                        nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                                (svg-lib-tag (concat value "%")
                                        nil :stroke 0 :margin 0)) :ascent 'center))

                (defun svg-progress-count (value)
                        (let* ((seq (mapcar #'string-to-number (split-string value "/")))
                                (count (float (car seq)))
                                (total (float (cadr seq))))
                        (svg-image (svg-lib-concat
                                (svg-lib-progress-bar (/ count total) nil
                                        :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                                (svg-lib-tag value nil
                                        :stroke 0 :margin 0)) :ascent 'center)))
                (setq svg-tag-tags
                `(
                        ;; Task priority
                        ("\\[#[A-Z]\\]" . ( (lambda (tag)
                                        (svg-tag-make tag :face 'org-priority
                                                        :beg 2 :end -1 :margin 0))))

                        ;; Progress
                        ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
                        (svg-progress-percent (substring tag 1 -2)))))
                        ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
                        (svg-progress-count (substring tag 1 -1)))))

                        ;; Citation of the form [cite:@Knuth:1984]
                        ("\\(\\[cite:@[A-Za-z]+:\\)" . ((lambda (tag)
                                                        (svg-tag-make tag
                                                                        :inverse t
                                                                        :beg 7 :end -1
                                                                        :crop-right t))))
                        ("\\[cite:@[A-Za-z]+:\\([0-9]+\\]\\)" . ((lambda (tag)
                                                                (svg-tag-make tag
                                                                        :end -1
                                                                        :crop-left t))))


                        ;; Active date (with or without day name, with or without time)
                        (,(format "\\(<%s>\\)" date-re) .
                        ((lambda (tag)
                        (svg-tag-make tag :beg 1 :end -1 :margin 0))))
                        (,(format "\\(<%s \\)%s>" date-re day-time-re) .
                        ((lambda (tag)
                        (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
                        (,(format "<%s \\(%s>\\)" date-re day-time-re) .
                        ((lambda (tag)
                        (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))

                        ;; Inactive date  (with or without day name, with or without time)
                        (,(format "\\(\\[%s\\]\\)" date-re) .
                        ((lambda (tag)
                        (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
                        (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
                        ((lambda (tag)
                        (svg-tag-make tag :beg 1 :inverse nil
                                                                :crop-right t :margin 0 :face 'org-date))))
                        (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
                        ((lambda (tag)
                        (svg-tag-make tag :end -1 :inverse t
                                                                :crop-left t :margin 0 :face 'org-date)))))))

                (add-hook 'org-mode-hook 'svg-tag-mode)

        ;; Prettiying symbols and source-blocks.
        (defun my/prettify-symbols-setup ()
                ;; Checkboxes
                (push '("[ ]" . "") prettify-symbols-alist)
                (push '("[X]" . "") prettify-symbols-alist)
                (push '("[-]" . "" ) prettify-symbols-alist)

                ;; org-abel
                (push '("#+BEGIN_SRC" . ?≫) prettify-symbols-alist)
                (push '("#+END_SRC" . ?≫) prettify-symbols-alist)
                (push '("#+begin_src" . ?≫) prettify-symbols-alist)
                (push '("#+end_src" . ?≫) prettify-symbols-alist)

                (push '("#+BEGIN_QUOTE" . ?❝) prettify-symbols-alist)
                (push '("#+END_QUOTE" . ?❞) prettify-symbols-alist)

                ;; Drawers
                (push '(":PROPERTIES:" . "") prettify-symbols-alist)

                ;; Tags
                (push '(":projects:" . "") prettify-symbols-alist)
                (push '(":work:"     . "") prettify-symbols-alist)
                (push '(":inbox:"    . "") prettify-symbols-alist)
                (push '(":task:"     . "") prettify-symbols-alist)
                (push '(":thesis:"   . "") prettify-symbols-alist)
                (push '(":uio:"      . "") prettify-symbols-alist)
                (push '(":emacs:"    . "") prettify-symbols-alist)
                (push '(":learn:"    . "") prettify-symbols-alist)
                (push '(":code:"     . "") prettify-symbols-alist)

                (prettify-symbols-mode))

        (add-hook 'org-mode-hook        #'my/prettify-symbols-setup)
        (add-hook 'org-agenda-mode-hook #'my/prettify-symbols-setup)

        ;; Change format of org-journal entries.
        (setq org-journal-date-prefix "#+TITLE: "
              org-journal-time-prefix "* "
              org-journal-date-format "%a, %Y-%m-%d"
              org-journal-file-format "%Y-%m-%d.org")

  )



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
