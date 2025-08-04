(ns io.dominic.mise)

(require '[com.gfredericks.dot-slash-2 :as dot-slash-2])


(defn saved-value
  "Return either value or exception of ep-info"
  [& args]
  (some (apply (requiring-resolve 'sc.api/ep-info) args)
        [:sc.ep/value :sc.ep/error]))

(defmacro with-test-result
  "Example use: (./with-test-result (./test-vars [#'foo-test]))"
  [& body]
  `(let [result# (atom (transient []))]
     (binding [clojure.test/report (fn [m#]
                                     (swap! result# conj! m#))]
       ~@body)
     (persistent! @result#)))

(defmacro with-test-timing
  [& body]
  `(let [result# (atom {:r [] :acc 0})]
     (binding [clojure.test/report
               (fn [m#]
                 (cond
                   (= :begin-test-var (:type m#))
                   (swap! result# assoc :acc (System/currentTimeMillis))
                   (= :end-test-var (:type m#))
                   (swap! result#
                          (fn [result#]
                            {:r (conj (:r result#)
                                      (assoc m# :time-elapsed-ms
                                             (- (System/currentTimeMillis) (:acc result#))))}))))]
       ~@body
       (:r @result#))))

(defmacro time-data
  [expr]
  `(let [start# (. System (nanoTime))
         ret# ~expr]
     [(/ (double (- (. System (nanoTime)) start#)) 1000000.0)
      ret#]))

(dot-slash-2/!
  '{. [clojure.test/run-tests clojure.test/test-vars
       {:var sc.api/spy :lazy? true :macro? true}
       {:var sc.api/letsc :lazy? true :macro? true}
       {:var sc.api/defsc :lazy? true :macro? true}
       {:var sc.api/undefsc :lazy? true :macro? true}
       {:var io.dominic.mise/saved-value}
       {:var io.dominic.mise/with-test-result}
       {:var io.dominic.mise/with-test-timing}
       {:var io.dominic.mise/time-data}
       {:var clj-async-profiler.core/profile :lazy? true :macro? true}
       {:var clj-async-profiler.core/serve-ui :lazy? true :macro? false}
       {:var clj-memory-meter.core/measure :lazy? true :macro? false}

       dev.nu.morse/launch-in-proc dev.nu.morse/inspect]})

(let [platform (java.io.File. (System/getProperty "user.home") ".clojure/platform.clj")]
  (when (.exists platform)
    (load-file (.getAbsolutePath platform))))

(require 'pjstadig.humane-test-output)
(pjstadig.humane-test-output/activate!)
