;;; delete-mode.el --- Swapping kill commands with delete

;; Copyright (C) 2015 Adrian Teng <adrian@teng.io>

;;; Commentary:
;; This package replaces a collection of kill commands shortcuts with a respective delete version.

;; Currently the following commands are replaced:
;; kill-word              (<C-delete>, M-d)
;; backward-kill-word     (<C-backspace>, M-DEL)

;; This package also supports `subword-mode'. If `subword-mode' is on, then `subword-kill' and
;; `backward-subword-kill' will be replaced by a corresponding delete version.

;;; Code:

(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-word (- arg)))


(defun subword-delete (arg)
  "Delete characters forward until encountering the end of a subword.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (subword-forward arg)))

(defun backward-subword-delete (arg)
  "Delete characters backward until encountering the end of a subword.
With argument ARG, do this that many times."
  (interactive "p")
  (subword-delete (- arg)))

(defun delete-word-dwim (arg)
  "If `subword-mode' is on, run subword-delete, otherwise run delete-word.
With argument ARG, do this that many times"
  (interactive "p")
  (if (boundp 'subword-mode)
      (subword-delete (arg)))
    (delete-word arg))

(defun backward-delete-word-dwim (arg)
  "If `subword-mode' is on, run backward-subword-delete, otherwise run\
backward-delete-word.  With argument ARG, do this that many times"
  (interactive "p")
  (if (boundp 'subword-mode)
      (backward-subword-delete (arg))
    (backward-delete-word arg)))

(defvar delete-mode-map (make-keymap)
  "Kepmap for delete-mode.")

(define-key delete-mode-map [remap kill-word] 'delete-word-dwim)
(define-key delete-mode-map [remap backward-kill-word] 'backward-delete-word-dwim)


(define-minor-mode delete-mode
 "This package replaces a collection of kill commands shortcuts with a respective delete version.
Currently the following commands are replaced:
kill-word              (<C-delete>, M-d)
backward-kill-word     (<C-backspace>, M-DEL)
This package also supports `subword-mode'. If `subword-mode' is on, then `subword-kill' and
`backward-subword-kill' will be replaced by a corresponding delete version.
"
  :lighter " del"
  :keymap delete-mode-map)

(define-globalized-minor-mode global-delete-mode delete-mode
  (lambda () (delete-mode t)))

(provide 'delete-mode)
;;; delete-mode.el ends here
