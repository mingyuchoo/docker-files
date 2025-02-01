;; Load Quicklisp
(load "~/quicklisp/setup.lisp")

;; Load Hunchentoot server
(ql:quickload "hunchentoot")

;; Define packages
(defpackage :my-web-server
  (:use :cl :hunchentoot))
(in-package :my-web-server)

;; Define simple handler
(define-easy-handler (hello :uri "/") ()
  (setf (hunchentoot:content-type*) "text/plain")
  "Hello, World from Hunchentoot!")

;; Run web server
(defvar *my-server* (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :address "0.0.0.0" :port 4000)))

(format t "Server started on http://0.0.0.0:4000~%")

(loop (sleep 60))
