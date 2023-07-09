;;; acid-green-fanta-theme.el --- inspired by Atom One Dark -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: May 23, 2016 (28620647f838)
;; Author: Henrik Lissner <https://github.com/hlissner>
;; Maintainer: Henrik Lissner <https://github.com/hlissner>
;; Source: https://github.com/atom/one-dark-ui
;;
;;; Commentary:
;;
;; This themepack's flagship theme.
;;
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup acid-green-fanta nil
  "Options for the `acid-green-fanta' theme."
  :group 'doom-themes)

(defcustom acid-green-fanta-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'acid-green-fanta
  :type 'boolean)

(defcustom acid-green-fanta-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'acid-green-fanta
  :type 'boolean)

(defcustom acid-green-fanta-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'acid-green-fanta
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme acid-green-fanta
  "A very dark theme - a darkified port of Github Dark."

  ;; name        default   256           16
  ((bg          '("#101010" "black"       "black"        ))
   (fg          '("#d3dbe3" "#bfbfbf"     "brightwhite"  ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt      '("#252525" "black"       "black"        ))
   (fg-alt      '("#d3dbe3" "#2d2d2d"     "white"        ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0       '("#343332" "black"       "black"          ))
   (base1       '("#1c1f24" "#1e1e1e"     "brightblack"    ))
   (base2       '("#202328" "#2e2e2e"     "brightblack"    ))
   (base3       '("#23272e" "#262626"     "brightblack"    ))
   (base4       '("#3f444a" "#3f3f3f"     "brightblack"    ))
   (base5       '("#5B6268" "#525252"     "brightblack"    ))
   (base6       '("#73797e" "#6b6b6b"     "brightblack"    ))
   (base7       '("#9ca0a4" "#979797"     "brightblack"    ))
   (base8       '("#d3dbe3" "#d3dbe3"     "white"          ))

   (grey        base4)
   (red         '("#ff6c6b" "#ff6655"     "red"            ))
   (orange      '("#ffab70" "#dd8844"     "brightred"      ))
   (green       '("#85d89a" "#99bb66"     "green"          ))
   (based-green '("#50ffb0" "#50ffb0"     "darkgreen"      ))
   (teal        '("#39c5cf" "#44b9b1"     "brightgreen"    ))
   (yellow      '("#ffdf5d" "#ECBE7B"     "yellow"         ))
   (blue        '("#58a6ff" "#51afef"     "brightblue"     ))
   (dark-blue   '("#009eff" "#2257A0"     "blue"           ))
   (magenta     '("#c678dd" "#c678dd"     "brightmagenta"  ))
   (violet      '("#a9a1e1" "#a9a1e1"     "magenta"        ))
   (cyan        '("#56d4dd" "#46D9FF"     "brightcyan"     ))
   (dark-cyan   '("#39c5cf" "#5699AF"     "cyan"           ))

   (n-constant  '("#79b8ff" "#b392e9"     "magenta"        ))
   (n-method    '("#b392f0" "#b30000"     "magenta"        ))
   (n-operator  '("#f97583" "#fa88aa"     "red"            ))
   (n-ident     '("#a5ffef" "#a5ffef"     "white"          ))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if acid-green-fanta-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if acid-green-fanta-brighter-comments dark-cyan base5) 0.25))
   (constants      n-constant)
   (functions      blue)
   (keywords       based-green)
   (methods        n-method)
   (operators      blue)
   (type           yellow)
   (strings        green)
   (variables      n-ident)
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; These are extra color variables used only in this theme; i.e. they aren't
   ;; mandatory for derived themes.
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if acid-green-fanta-brighter-modeline
                                 (doom-darken blue 0.45)
                               bg-alt))
   (modeline-bg-alt          (if acid-green-fanta-brighter-modeline
                                 (doom-darken blue 0.475)
                               `(,(doom-darken (car bg-alt) 0.35) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when acid-green-fanta-padded-modeline
      (if (integerp acid-green-fanta-padded-modeline) doom-one-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if acid-green-fanta-brighter-comments (doom-lighten bg 0.05)))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if acid-green-fanta-brighter-modeline base8 highlight))

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if acid-green-fanta-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-attr :foreground orange)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt))))

  ;;;; Base theme variable overrides-
  ())

;;; acid-green-fanta-theme.el ends here
