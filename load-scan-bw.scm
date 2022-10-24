(define (script-fu-load-scan-bw inFilename outFileName)
     (let*
          (
               (image (car (gimp-file-load RUN-INTERACTIVE inFilename inFilename)))
               (drawable (car (gimp-image-get-active-layer image)))
               (borderSizeHorizontal 190)
               (borderSizeVertical 140)
               (newWidth (- (car (gimp-image-width image)) (* 2 borderSizeHorizontal)))
               (newHeight (- (car (gimp-image-height image)) (* 2 borderSizeVertical)))
          )

          (gimp-image-crop image newWidth newHeight borderSizeHorizontal borderSizeVertical)
          (gimp-image-convert-grayscale image)
          (plug-in-autostretch-hsv RUN-NONINTERACTIVE image drawable)
          (gimp-file-save RUN-NONINTERACTIVE image drawable outFileName outFileName)
          (gimp-image-delete image)
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
