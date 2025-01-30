# Use a specific SBCL version
FROM daewok/sbcl:2.2.4-slim

# Install necessary system packages
RUN apt-get update && \
    apt-get install -y curl git && \
    rm -rf /var/lib/apt/lists/*

# Install Quicklisp
COPY quicklisp.lisp /root/quicklisp.lisp
RUN sbcl --load /root/quicklisp.lisp --eval '(quicklisp-quickstart:install)' --eval '(ql:add-to-init-file)' --eval '(quit)'

# Copy source code
COPY src /root/src

# Install hunchentoot by Quicklisp
RUN sbcl --eval '(ql:quickload "hunchentoot")' --eval '(quit)'

# Run main script
CMD ["sbcl", "--load", "/root/src/main.lisp"]
