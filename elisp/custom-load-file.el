(defun load-library-wrap-error (lib)
  "Load library lib and catch any errors that it might throw.
Errors will be logged to the buffer *Init Errors*"
  (condition-case err
      (load-library lib)
    (error (progn
           (switch-to-buffer "*Init Errors*")
           (let (buf (get-buffer-create "*Init Errors*"))
             (with-temp-buffer
               (erase-buffer)
               (insert "Error in '" lib
                   ":\n  " (error-message-string err) "\n")
               (print "**")
               (print (car err))
               (append-to-buffer "*Init Errors*"
                       (point-min)
                       (point-max))))))))

(defun load-wrap-error (lib)
  "Load library lib (if it exists bytecompiled version) and
catch any errors that it might throw. Errors will be logged to the
buffer *Init Errors*"
  (condition-case err
      (load lib)
    (error (progn
           (switch-to-buffer "*Init Errors*")
           (let (buf (get-buffer-create "*Init Errors*"))
             (with-temp-buffer
               (erase-buffer)
               (insert "Error in '" lib
                   ":\n  " (error-message-string err) "\n")
               (print "**")
               (print (car err))
               (append-to-buffer "*Init Errors*"
                       (point-min)
                       (point-max))))))))
