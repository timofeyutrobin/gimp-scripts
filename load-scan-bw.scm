(define (string-split char-delimiter? string)
  (define (maybe-add a b parts)
    (if (= a b) parts (cons (substring string a b) parts)))
  (let ((n (string-length string)))
    (let loop ((a 0) (b 0) (parts '()))
      (if (< b n)
          (if (not (char-delimiter? (string-ref string b)))
              (loop a (+ b 1) parts)
              (loop (+ b 1) (+ b 1) (maybe-add a b parts)))
          (reverse (maybe-add a b parts))))))

(define (char-slash? char)
     (char=? char #\/)
)

(define (script-fu-load-scan-bw in-filename out-filename)
     (let*
          (
               (image (car (gimp-file-load RUN-INTERACTIVE in-filename in-filename)))
               (drawable (car (gimp-image-get-active-layer image)))
               (border-size-horizontal 190)
               (border-size-vertical 140)
               (new-width (- (car (gimp-image-width image)) (* 2 border-size-horizontal)))
               (new-height (- (car (gimp-image-height image)) (* 2 border-size-vertical)))
          )

          (gimp-image-crop image new-width new-height border-size-horizontal border-size-vertical)
          (gimp-image-convert-grayscale image)
          (plug-in-autostretch-hsv RUN-NONINTERACTIVE image drawable)
          (gimp-file-save RUN-NONINTERACTIVE image drawable out-filename out-filename)
          (gimp-image-delete image)
     )
)

(define (script-fu-load-scan-bw-batch pattern out-dir)
     (let*
          (
               (filelist (cadr (file-glob pattern 1)))
          )
          (while (not (null? filelist))
               (let*
                    (
                         (filename (car filelist))
                         (relative-filename (car (reverse (string-split char-slash? filename))))
                         (out-filename (string-append out-dir "/" relative-filename))
                    )
                    (script-fu-load-scan-bw filename out-filename)
               )
               (set! filelist (cdr filelist))
          )
     )
)

(script-fu-register
     "script-fu-load-scan-bw"
     "B/W"
     "Basic processing for b/w film scans (cropping frames, convert to grayscale, stretch contrast)"
     "Timofey Utrobin"
     "lol"
     "October 27, 2022"
     ""
     SF-FILENAME "Image" ""
)
(script-fu-menu-register "script-fu-load-scan-bw" "<Image>/File/Create/Film Scan")
