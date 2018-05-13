
;; Tangling files from input

(setq files-to-tangle argv)

(print (format "Files: %s" argv))

(dolist (file files-to-tangle)
  (progn
    (print (format "Processing file %s" file)) ; print filename
    (find-file file)			; load file
    (org-babel-tangle)))		; tangle
    
