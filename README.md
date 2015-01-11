delete-mode
===========

A minor mode that replaces various kill command shortcuts with their delete versions.


Installation
------------

### Melpa
Coming soon


### Manual installation
Clone the repository, load the path in your Emacs init file, and enable delete-mode on startup.

    git clone https://github.com/AdrianTeng/delete-mode.git
    ---------
    ;; On your Emacs init
    (add-to-list 'load-path "<path/to/delete-mode>")
    (require 'delete-mode)
    (add-hook 'after-init-hook 'global-delete-mode)
