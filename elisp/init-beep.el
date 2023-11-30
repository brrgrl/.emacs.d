;;; init-beep.el ---
;;
;; Filename: init-beep.el
;; Description:
;; Author: Andrew Berisha
;; Maintainer:
;; Copyright (C) 2019 Andrew Berisha
;; Created: Fri Jul 28 12:35:52 2023 (-0500)
;; Version:
;; Package-Requires: ()
;; Last-Updated:
;;           By:
;;     Update #: 4
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(defvar beep--loops 0)

(defun beep--tone (tone)
  "Return different tones based on name."
  (shell-command
   (format
    "powershell.exe '-c (New-Object System.Media.SoundPlayer \"C:\\Windows\\Media\\%s.wav\").PlaySync()' > /dev/null 2>&1"
    tone)))


(defun beep-alert ()
  "Function that beeps and call next loop."
  (message "Take a 10 second break")
  (beep--tone "Speech Off")
  (if (= 0 beep--loops)
      (progn
        (message "Session finished")
        (beep--tone "Windows Print Complete"))
    (beeping-loop-timer)))

(defun beeping-loop-timer ()
  "Set a loop of timers."
  (interactive)
  (let ((duration (+ 300 (random 600))))
    (unless (>  beep--loops 0)
      (setq beep--loops (string-to-number (read-string "Number of loops: "))))
    (run-at-time duration nil 'beep-alert)
    (setq beep--loops (1- beep--loops))
    (message "The timer started with duration %s seconds" duration)))


(provide 'init-beep)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-beep.el ends here
