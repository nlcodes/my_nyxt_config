;; Set vi keybinds
;; When in visual mode, c and v default to toggle highlight text on/off
(define-configuration buffer
  ((default-modes
    (pushnew 'nyxt/mode/vi:vi-normal-mode %slot-value%))))

;; Ad block
(define-configuration web-buffer
  ((default-modes
    (pushnew 'nyxt/mode/blocker:blocker-mode %slot-value%))))

;; Auto cast insert mode when opening prompt buffer
(define-configuration prompt-buffer
  ((default-modes (cons 'nyxt/mode/vi:vi-insert-mode %slot-value%))))

;; Turn off message buffer
(define-configuration browser
  ((after-startup-hook
    (hooks:add-hook %slot-default%
      (lambda (browser)  
        (nyxt:toggle-message-buffer))))))

;; Fix blank screen
(setf (uiop/os:getenv "WEBKIT_DISABLE_COMPOSITING_MODE") "1")

;; Search
(defvar *my-search-engines*
  (list
   '("brave" "https://search.brave.com/search?q=~a"
     "https://search.brave.com")
   '("duckduckgo" "https://duckduckgo.com/?q=~a" 
     "https://duckduckgo.com"))
     "List of search engines")

(define-configuration context-buffer
  "Go through the search engines above and make-search-engine"
  ((search-engines
    (append %slot-default%
      (mapcar
        (lambda (engine) (apply 'make-search-engine engine))
        *my-search-engines*)))))

;; Colorscheme
(define-configuration browser
  ((theme default)))

;; Default theme
(defvar default
  (make-instance 'theme:theme
    :background-color "#000000"
    :background-color+ "#ff0000"
    :background-color- "#00ff00"
    :action-color "#af00ff"
    :primary-color "#0000ff"
    :secondary-color "#080808"
    :highlight-color "af00ff"
    :highlight-color+ "af00ff"
    :highlight-color- "af00ff"
    :text-color "#ffffff"
    :contrast-text-color "#000000"))

;; Dark theme
(defvar my_dark
  (make-instance 'theme:theme
    :background-color "#000000"
    :background-color+ "#333333"
    :background-color- "#666666"
    :action-color "#999999"
    :primary-color "#1a1a1a"
    :secondary-color "#080808"
    :text-color "#f2f2f2"
    :contrast-text-color "#000000"))

;; Set colorscheme
;; Define colorscheme above and plug variable in here
(define-configuration browser ((theme default)))

;; Fix vi mode scrolling
;; Call xbindkeys using xdotool to use y and u in place of j and k for vi mode
;; Was unable to get vi mode scrolling working on certain modern sites with nyxt defaults
;; Fixed by mapping mod4 + y and u to scroll wheel up and down (click 4 and 5 in xdotool)
;; This hack works as a temp fix for the issue and works well with no issues
;; Check .xbindkeysrc for codes (.xbindkeysrc should be placed in ~/ dir)
(uiop:run-program '("xbindkeys"))
