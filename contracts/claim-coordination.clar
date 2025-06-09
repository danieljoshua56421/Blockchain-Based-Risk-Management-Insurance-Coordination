;; Claim Coordination Contract
;; Coordinates insurance claims

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u400))
(define-constant ERR_CLAIM_NOT_FOUND (err u401))
(define-constant ERR_POLICY_INACTIVE (err u402))
(define-constant ERR_CLAIM_ALREADY_PROCESSED (err u403))

;; Claim status constants
(define-constant CLAIM_PENDING u1)
(define-constant CLAIM_APPROVED u2)
(define-constant CLAIM_REJECTED u3)
(define-constant CLAIM_PAID u4)

;; Data structures
(define-map insurance-claims
  { claim-id: uint }
  {
    claimant: principal,
    policy-id: uint,
    claim-amount: uint,
    incident-date: uint,
    claim-date: uint,
    description: (string-ascii 200),
    status: uint,
    approved-amount: uint
  }
)

(define-map claim-counter uint uint)
(map-set claim-counter u0 u0)

;; Public functions
(define-public (file-claim
  (policy-id uint)
  (claim-amount uint)
  (incident-date uint)
  (description (string-ascii 200))
)
  (let ((current-id (+ (default-to u0 (map-get? claim-counter u0)) u1)))
    (begin
      (map-set insurance-claims
        { claim-id: current-id }
        {
          claimant: tx-sender,
          policy-id: policy-id,
          claim-amount: claim-amount,
          incident-date: incident-date,
          claim-date: block-height,
          description: description,
          status: CLAIM_PENDING,
          approved-amount: u0
        }
      )
      (map-set claim-counter u0 current-id)
      (ok current-id)
    )
  )
)

(define-public (process-claim (claim-id uint) (approved-amount uint) (approve bool))
  (let ((claim (unwrap! (map-get? insurance-claims { claim-id: claim-id }) ERR_CLAIM_NOT_FOUND)))
    (begin
      (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
      (asserts! (is-eq (get status claim) CLAIM_PENDING) ERR_CLAIM_ALREADY_PROCESSED)
      (map-set insurance-claims
        { claim-id: claim-id }
        (merge claim {
          status: (if approve CLAIM_APPROVED CLAIM_REJECTED),
          approved-amount: (if approve approved-amount u0)
        })
      )
      (ok true)
    )
  )
)

(define-public (pay-claim (claim-id uint))
  (let ((claim (unwrap! (map-get? insurance-claims { claim-id: claim-id }) ERR_CLAIM_NOT_FOUND)))
    (begin
      (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
      (asserts! (is-eq (get status claim) CLAIM_APPROVED) ERR_CLAIM_ALREADY_PROCESSED)
      (map-set insurance-claims
        { claim-id: claim-id }
        (merge claim { status: CLAIM_PAID })
      )
      (ok (get approved-amount claim))
    )
  )
)

;; Read-only functions
(define-read-only (get-claim (claim-id uint))
  (map-get? insurance-claims { claim-id: claim-id })
)

(define-read-only (get-claim-status (claim-id uint))
  (match (map-get? insurance-claims { claim-id: claim-id })
    claim (ok (get status claim))
    ERR_CLAIM_NOT_FOUND
  )
)
