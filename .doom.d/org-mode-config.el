;;; org-mode-config.el -*- lexical-binding: t; -*-
;;;

(require 'ox-publish)
(require 'org-protocol)
;; org-mode customization
(setq org-use-tag-inheritance t)
(setq org-use-property-inheritance t)
(setq org-startup-folded t)

(setq org-directory "~/Notes/InProgress/")
(setq +org-capture-todo-file "~/Notes/InProgress/inbox.org")

(setq org-agenda-files '("~/Notes/CSNotes/TODO.org"
                         "~/Notes/Linguistics-related/TODO.org"
                         "~/Notes/InProgress/inbox.org"
                         "~/Notes/InProgress/tasks.org"
                         "~/Notes/InProgress/someday.org"
                         "~/Notes/InProgress/trash.org"
                         "~/Notes/InProgress/references.org"))

;; templates for browser to use
(add-to-list 'org-capture-templates '("pp" "Protocol" entry
                                      (file+headline "~/Notes/InProgress/captured-quotes.org" "Quotes")
                                      "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?"))
(add-to-list 'org-capture-templates '("pL" "Protocol Link" entry
                                      (file+headline "~/Notes/InProgress/captured-links.org" "Links")
                                      "* %? [[%:link][%:description]] \nCaptured On: %U"))
