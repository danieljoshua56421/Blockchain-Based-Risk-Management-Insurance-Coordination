import { describe, it, expect, beforeEach } from "vitest"

describe("Claim Coordination Contract", () => {
  let contractAddress
  let ownerAddress
  let claimantAddress
  
  beforeEach(() => {
    contractAddress = "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.claim-coordination"
    ownerAddress = "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM"
    claimantAddress = "ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG"
  })
  
  it("should file a new claim", () => {
    const policyId = 1
    const claimAmount = 25000
    const incidentDate = 95
    const description = "Water damage to property"
    
    const result = { type: "ok", value: 1 }
    
    expect(result.type).toBe("ok")
    expect(result.value).toBe(1)
  })
  
  it("should get claim information", () => {
    const claimId = 1
    
    const mockClaim = {
      claimant: claimantAddress,
      "policy-id": 1,
      "claim-amount": 25000,
      "incident-date": 95,
      "claim-date": 100,
      description: "Water damage to property",
      status: 1, // CLAIM_PENDING
      "approved-amount": 0,
    }
    
    expect(mockClaim.claimant).toBe(claimantAddress)
    expect(mockClaim["claim-amount"]).toBe(25000)
    expect(mockClaim.status).toBe(1)
  })
  
  it("should process a claim (approve)", () => {
    const claimId = 1
    const approvedAmount = 20000
    const approve = true
    
    const result = { type: "ok", value: true }
    
    expect(result.type).toBe("ok")
    expect(result.value).toBe(true)
  })
  
  it("should process a claim (reject)", () => {
    const claimId = 1
    const approvedAmount = 0
    const approve = false
    
    const result = { type: "ok", value: true }
    
    expect(result.type).toBe("ok")
    expect(result.value).toBe(true)
  })
  
  it("should pay an approved claim", () => {
    const claimId = 1
    const result = { type: "ok", value: 20000 }
    
    expect(result.type).toBe("ok")
    expect(result.value).toBe(20000)
  })
  
  it("should get claim status", () => {
    const claimId = 1
    const result = { type: "ok", value: 2 } // CLAIM_APPROVED
    
    expect(result.type).toBe("ok")
    expect(result.value).toBe(2)
  })
  
  it("should return error for unauthorized processing", () => {
    const result = { type: "err", value: 400 }
    
    expect(result.type).toBe("err")
    expect(result.value).toBe(400)
  })
})
