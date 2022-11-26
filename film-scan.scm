(define (crop-coolscan image)
     (let*
          (
               (border-size-horizontal 190)
               (border-size-vertical 140)
               (new-width (- (car (gimp-image-width image)) (* 2 border-size-horizontal)))
               (new-height (- (car (gimp-image-height image)) (* 2 border-size-vertical)))
          )

          (gimp-image-crop image new-width new-height border-size-horizontal border-size-vertical)
     )
)

(define (script-fu-scan-bw image drawable)
     (crop-coolscan image)
     (gimp-image-convert-grayscale image)
     (plug-in-autostretch-hsv RUN-NONINTERACTIVE image drawable)
)

(define (script-fu-scan-color image drawable)
     (crop-coolscan image)
     (plug-in-autostretch-hsv RUN-NONINTERACTIVE image drawable)
)

(script-fu-register
     "script-fu-scan-bw"
     "Film Scan B/W"
     "Basic processing for b/w film scans (cropping frames, convert to grayscale, stretch contrast)"
     "Timofey Utrobin"
     "lol"
     "October 27, 2022"
     ""
     SF-IMAGE "Image" 0
     SF-DRAWABLE "Current Layer" 0
)
(script-fu-menu-register "script-fu-scan-bw" "<Image>/Colors/Auto")

(script-fu-register
     "script-fu-scan-color"
     "Film Scan Color"
     "Basic processing for color film scans (cropping frames, stretch contrast)"
     "Timofey Utrobin"
     "lol"
     "November 9, 2022"
     ""
     SF-IMAGE "Image" 0
     SF-DRAWABLE "Current Layer" 0
)
(script-fu-menu-register "script-fu-scan-color" "<Image>/Colors/Auto")
