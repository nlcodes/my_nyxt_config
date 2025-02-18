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
  ((theme
    (make-instance 'theme:theme
      :background-color "black"
      :background-color+ "#00ff00"
      :background-color- "#00FF00"
      :on-background-color "white"    
      :action-color "#FF0000"
      :primary-color "#0000FF"
      :secondary-color "#080808"
      :text-color "white"
      :contrast-text-color "black"))))
