(setq tex-fontify-script nil ;; disables custom fonts in LaTeX buffer display
      font-latex-fontify-sectioning 'color
      font-latex-fontify-script nil
      LaTeX-item-indent -2
      LaTeX-indent-level 4) ;; indents special environments


(setq-default
 TeX-command-list
 (quote
  (("TeX" "%(PDF)%(tex) %(file-line-error) %`%(extraopts) %S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
    (plain-tex-mode ams-tex-mode texinfo-mode)
    :help "Run plain TeX")
   ("LaTeX" "%`%l%(mode)%' %T" TeX-run-TeX nil
    (latex-mode doctex-mode)
    :help "Run LaTeX")
   ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
   ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")

   ("Spell" "(TeX-ispell-document \"\")"
    TeX-run-function nil t :help "Spell-check the
                document")
   ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
   ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
   ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))

(setq-default
 TeX-view-program-selection
 (quote
  (((output-dvi has-no-display-manager) "dvi2tty")
   ((output-dvi style-pstricks) "dvips and gv")
   (output-dvi "xdvi")
   (output-pdf "xpdf")
   (output-html "xdg-open"))))
