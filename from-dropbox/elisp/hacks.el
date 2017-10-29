;; Some useful hacks

(defun nativepath (path)
  (shell-command-to-string 
   (format "echo -n `cygpath -m %s`" 
	   (shell-quote-argument path))))

(defun cygwinpath (path)
  (shell-command-to-string 
   (format "echo -n `cygpath -u %s`" 
	   (shell-quote-argument path))))

;; ------------------------------------------------------------
;; Support for MKS Source Integrity
;; ------------------------------------------------------------

;; Return the current buffer's filename, or directory name if we're in a dired buffer.
(defun get-buffer-file-or-directory-name ()
  (or buffer-file-name
      list-buffers-directory
      (t (error 'invalid-argument
		"No file or directory here"))))

;; Return the MKS .pj in the given directory; traverse upwards if 
;; there is no project file here.
(defun mkssi-get-project (dir)
  (if (or (not dir)
	  (equal dir "/"))
      nil
    (let ((pjfile (car (directory-files dir t ".*\\.pj" nil t))))
      (if pjfile
	  (nativepath pjfile)
	(mkssi-get-project
	 (file-name-directory
	  (directory-file-name (expand-file-name dir))))))))

(defun mkssi-here ()
  "Start MKS Source Integrity and open the project file for the current 
project. The current project is located by searching upwards from the current
buffer file name and taking the first *.pj file found."
  (interactive)
  (let ((project (mkssi-get-project 
		  (file-name-directory
		   (get-buffer-file-or-directory-name)))))
    (if (not project)
	(error 'invalid-argument "No MKS project here.")
      (progn (message "Starting external MKS Source Integrity process")
	     (start-process "mkssi-proc" "*mkssi output*"
			    "mkssi32.exe" project)))))

;; ------------------------------------------------------------
;; Interaction with the Windows shell/explorer
;; ------------------------------------------------------------

(defun start-explorer-process (dir)
  (interactive "P")
  (if dir
      (start-process 
       "explorer-process" "*explorer output*" "explorer.exe" 
       (substitute ?\\ ?/ (nativepath (file-name-directory dir))))
    (start-process 
     "explorer-process" "*explorer output*" "explorer.exe")))

(defun explorer ()
  "Open the Windows Explorer displaying the directory of the current file." 
  (interactive)
  (start-explorer-process (get-buffer-file-or-directory-name)))

(defun w32-browser (doc)
  "Browse to a particular file/URL using default web browser"
  (w32-shell-execute 1 doc))

;; Press F3 in dired to open a file with the default application. Very
;; handy.
(eval-after-load "dired"
  '(define-key dired-mode-map [f3] 
     (lambda () 
       (interactive)
       (w32-browser
	(dired-replace-in-string 
	 "/" "\\" 
	 (dired-get-filename))))))

(defun indent-file-and-save ()
  (interactive)
  (c-indent-region (point-min) (point-max) nil)
  (save-buffer))

;; ------------------------------------------------------------
;; Bind F1 to MSDN help
;; ------------------------------------------------------------

(defun msdn-help ()
  (interactive)
  (start-process "msdn-helper" "*msdn-helper*" 
		 (cygwinpath "c:/Perl/bin/perl")
		 (nativepath "o:/bin/msdn-help.perl")
		 (current-word)))

(global-set-key [f1] 'msdn-help)

(defun current-line ()
  "Return the vertical position of point..."
  (+ (count-lines (point-min) (point))
     (if (= (current-column) 0) 1 0)))
     
;; Compile the "current project" in Visual Studio; i.e. open the
;; current file and call "build selection".o:
(defun compile-current-project ()
  (interactive)
  (start-process "devenv-helper" "*devenv-helper*" 
		 (cygwinpath "c:/Perl/bin/perl")
		 (nativepath "o:/bin/build-project.perl")
                 (nativepath (buffer-file-name))
                 (format "%d" (current-line))))

(global-set-key "\M-r" 'compile-current-project)

(defun debug-current-project ()
  (interactive)
  (start-process "devenv-helper" "*devenv-helper*" 
		 (cygwinpath "c:/Perl/bin/perl")
                 (nativepath "o:/bin/do-ole-command.perl")
                 "VisualStudio.DTE.7.1"
                 "Debug.Start"))

(global-set-key [f5] 'debug-current-project)
