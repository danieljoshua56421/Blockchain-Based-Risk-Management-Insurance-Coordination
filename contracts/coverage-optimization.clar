;; Coverage Optimization Contract
;; Optimizes insurance coverage based on risk profiles

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u500))
(define-constant ERR_INVALID_PARAMETERS (err u501))

;; Data structures
(define-map coverage-recommendations
  { recommendation-id: uint }
  {
    policy-id: uint,
    current-coverage: uint,
    recommended-coverage: uint,
    risk-score: uint,
    optimization-date: uint,
    savings-potential: uint
  }
)

(define-map recommendation-counter uint uint)
(map-set recommendation-counter u0 u0)

;; Public functions
(define-public (generate-coverage-recommendation
  (policy-id uint)
  (current-coverage uint)
  (risk-score uint)
)
  (let (
    (current-id (+ (default-to u0 (map-get? recommendation-counter u0)) u1))
    (recommended-coverage (calculate-optimal-coverage current-coverage risk-score))
    (savings (if (> current-coverage recommended-coverage)
               (- current-coverage recommended-coverage)
               u0))
  )
    (begin
      (asserts! (<= risk-score u10) ERR_INVALID_PARAMETERS)
      (asserts! (>= risk-score u1) ERR_INVALID_PARAMETERS)
      (map-set coverage-recommendations
        { recommendation-id: current-id }
        {
          policy-id: policy-id,
          current-coverage: current-coverage,
          recommended-coverage: recommended-coverage,
          risk-score: risk-score,
          optimization-date: block-height,
          savings-potential: savings
        }
      )
      (map-set recommendation-counter u0 current-id)
      (ok current-id)
    )
  )
)

;; Read-only functions
(define-read-only (get-recommendation (recommendation-id uint))
  (map-get? coverage-recommendations { recommendation-id: recommendation-id })
)

(define-read-only (calculate-optimal-coverage (current-coverage uint) (risk-score uint))
  (let ((risk-multiplier (+ u80 (* risk-score u5)))) ;; 80% to 130% based on risk
    (/ (* current-coverage risk-multiplier) u100)
  )
)

(define-read-only (estimate-premium-savings (current-coverage uint) (recommended-coverage uint) (base-premium uint))
  (if (> current-coverage recommended-coverage)
    (/ (* base-premium (- current-coverage recommended-coverage)) current-coverage)
    u0
  )
)
