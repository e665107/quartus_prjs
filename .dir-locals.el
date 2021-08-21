((verilog-mode . (
                  (eval .
                        (setq verilog-library-directories '("."))
                        )
                  (eval .
                        (mapcar
                         (lambda (file)
                           (add-to-list 'verilog-library-directories (file-name-directory file)))
                         (directory-files-recursively
                          (concat (projectile-project-root) "rtl") "\.[s]?v$")
                         )
                        ))
               ))

