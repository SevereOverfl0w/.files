(ns io.dominic.mise)

(require '[com.gfredericks.dot-slash-2 :as dot-slash-2])

(dot-slash-2/!
  '{. [clojure.test/run-tests clojure.test/test-vars
       {:var sc.api/spy :lazy? true :macro? true}
       {:var sc.api/letsc :lazy? true :macro? true}
       {:var sc.api/defsc :lazy? true :macro? true}
       {:var sc.api/undefsc :lazy? true :macro? true}
       {:var clj-async-profiler.core/profile :lazy? true :macro? true}
       {:var clj-async-profiler.core/serve-ui :lazy? true :macro? false}
       {:var clj-memory-meter.core/measure :lazy? true :macro? false}

       dev.nu.morse/launch-in-proc dev.nu.morse/inspect]})

(let [platform (java.io.File. (System/getProperty "user.home") ".clojure/platform.clj")]
  (when (.exists platform)
    (load-file (.getAbsolutePath platform))))

(require 'pjstadig.humane-test-output)
(pjstadig.humane-test-output/activate!)
