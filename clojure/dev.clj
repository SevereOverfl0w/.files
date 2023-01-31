(ns io.dominic.mise)

(require '[com.gfredericks.dot-slash-2 :as dot-slash-2])

(dot-slash-2/!
  '{. [clojure.test/run-tests
       {:var sc.api/spy :lazy? true :macro? true}
       {:var sc.api/letsc :lazy? true :macro? true}
       {:var sc.api/defsc :lazy? true :macro? true}
       {:var sc.api/undefsc :lazy? true :macro? true}]})

(let [platform (java.io.File. (System/getProperty "user.home") ".clojure/platform.clj")]
  (when (.exists platform)
    (load-file (.getAbsolutePath platform))))
