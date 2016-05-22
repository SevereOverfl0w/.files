(ns bar
  (:require [pixie.io :as io]
            [pixie.string :as string]
            [pixie.io-blocking :as io-blocking]))

;; Helpers
(defn ucmd
  [& args]
  (string/trim (apply io/run-command args)))

;; Lemonbar Formatting
(defn fg
  [hex string]
  (string/interp
    "%{F$hex$}$string$%{F-}"))

(defn bg
  [hex string]
  (string/interp
    "%{B$hex$}$string$%{B-}"))

;; Icons
(def icons
  {:battery-full ""
   :battery-quarter""
   :bolt ""
   :clock ""
   :unknown ""
   :wifi ""
   })

;; Data Collection
(defn clock
  []
  (ucmd "date \"+%a %b %d, %T\"")) 

; (defn volume
;   []
;   (io/run-command "amixer get Master | sed -n 's/^.*\[\([0-9]\+%\).*$/\1/p'"))

(defn battery-status
  []
  {:status (string/trim
             (io/slurp "/sys/class/power_supply/BAT0/status"))})

(defn level-status
  [level]
  (condp < level
    50 "warning"
    25 "urgent"
    "good"))

(defn battery-level
  []
  (let [level (read-string
                (string/trim
                  (io/slurp "/sys/class/power_supply/BAT0/capacity")))]
    {:level level
     :level-status (level-status level)}))

(defn volume
  []
  (let [amixer (ucmd "amixer get Master")]
    (io-blocking/popen
      "sed -n 's/^.*\\[\\([0-9]\\+%\\).*$/\\1/p'"
      )
    ))

;; Into a string
(let [data {:date (clock)
            :battery (merge (battery-status)
                            (battery-level))
            :volume (volume)}]
  (println
    (pr-str data)))
