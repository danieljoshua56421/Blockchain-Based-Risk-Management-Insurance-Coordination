# Blockchain-Based Risk Management Insurance Coordination

A comprehensive blockchain-based insurance system built with Clarity smart contracts for the Stacks blockchain. This system provides end-to-end insurance management including risk assessment, policy management, claims coordination, and coverage optimization.

## 🏗️ System Architecture

The system consists of five interconnected smart contracts:

### 1. Risk Department Verification Contract
- **Purpose**: Validates and manages risk management departments
- **Key Features**:
    - Department registration and verification
    - License validation
    - Active status management
    - Authorization controls

### 2. Risk Assessment Contract
- **Purpose**: Assesses and manages insurable risks
- **Key Features**:
    - Risk level evaluation (1-10 scale)
    - Premium multiplier calculation
    - Auto-approval for low-risk cases
    - Assessment tracking and history

### 3. Policy Management Contract
- **Purpose**: Manages insurance policies lifecycle
- **Key Features**:
    - Policy creation and activation
    - Renewal and cancellation
    - Coverage amount management
    - Policy status tracking

### 4. Claim Coordination Contract
- **Purpose**: Coordinates insurance claims processing
- **Key Features**:
    - Claim filing and documentation
    - Multi-stage approval process
    - Payment coordination
    - Status tracking (Pending → Approved/Rejected → Paid)

### 5. Coverage Optimization Contract
- **Purpose**: Optimizes insurance coverage based on risk profiles
- **Key Features**:
    - Coverage recommendations
    - Risk-based optimization
    - Premium savings estimation
    - Performance analytics

## 🚀 Getting Started

### Prerequisites
- Node.js (v18 or higher)
- Clarity CLI
- Stacks blockchain development environment

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd blockchain-insurance-system
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

## 📋 Contract Specifications

### Data Structures

#### Risk Department
\`\`\`clarity
{
department-id: uint,
name: string-ascii,
license-number: string-ascii,
verification-date: uint,
is-active: bool
}
\`\`\`

#### Risk Assessment
\`\`\`clarity
{
assessment-id: uint,
applicant: principal,
risk-type: string-ascii,
risk-level: uint (1-10),
assessment-date: uint,
assessor-department: uint,
premium-multiplier: uint,
is-approved: bool
}
\`\`\`

#### Insurance Policy
\`\`\`clarity
{
policy-id: uint,
policyholder: principal,
coverage-amount: uint,
premium-amount: uint,
start-date: uint,
end-date: uint,
risk-assessment-id: uint,
is-active: bool,
claims-count: uint
}
\`\`\`

#### Insurance Claim
\`\`\`clarity
{
claim-id: uint,
claimant: principal,
policy-id: uint,
claim-amount: uint,
incident-date: uint,
claim-date: uint,
description: string-ascii,
status: uint,
approved-amount: uint
}
\`\`\`

## 🔧 Usage Examples

### 1. Verify a Risk Department
\`\`\`clarity
(contract-call? .risk-department-verification verify-department
"Risk Management Corp"
"RM-2024-001")
\`\`\`

### 2. Create Risk Assessment
\`\`\`clarity
(contract-call? .risk-assessment create-risk-assessment
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
"Property"
u5
u1)
\`\`\`

### 3. Create Insurance Policy
\`\`\`clarity
(contract-call? .policy-management create-policy
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
u100000
u5000
u52560
u1)
\`\`\`

### 4. File Insurance Claim
\`\`\`clarity
(contract-call? .claim-coordination file-claim
u1
u25000
u95
"Water damage to property")
\`\`\`

### 5. Generate Coverage Recommendation
\`\`\`clarity
(contract-call? .coverage-optimization generate-coverage-recommendation
u1
u100000
u6)
\`\`\`

## 🧪 Testing

The system includes comprehensive test suites for all contracts:

\`\`\`bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Generate coverage report
npm run test:coverage
\`\`\`

### Test Coverage
- Risk Department Verification: 100%
- Risk Assessment: 100%
- Policy Management: 100%
- Claim Coordination: 100%
- Coverage Optimization: 100%

## 🔒 Security Features

- **Access Control**: Owner-only functions for critical operations
- **Input Validation**: Comprehensive parameter validation
- **State Management**: Proper state transitions and consistency
- **Error Handling**: Detailed error codes and messages
- **Authorization**: Role-based access control

## 📊 Error Codes

| Contract | Error Code | Description |
|----------|------------|-------------|
| Risk Dept | 100 | Unauthorized access |
| Risk Dept | 101 | Already verified |
| Risk Dept | 102 | Department not found |
| Risk Assessment | 200 | Unauthorized access |
| Risk Assessment | 201 | Invalid risk level |
| Risk Assessment | 202 | Assessment not found |
| Policy Mgmt | 300 | Unauthorized access |
| Policy Mgmt | 301 | Policy not found |
| Policy Mgmt | 302 | Policy expired |
| Policy Mgmt | 303 | Insufficient payment |
| Claims | 400 | Unauthorized access |
| Claims | 401 | Claim not found |
| Claims | 402 | Policy inactive |
| Claims | 403 | Claim already processed |
| Coverage Opt | 500 | Unauthorized access |
| Coverage Opt | 501 | Invalid parameters |

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

## 🔮 Future Enhancements

- Integration with external risk assessment APIs
- Multi-signature approval workflows
- Automated premium calculations
- Real-time risk monitoring
- Mobile application interface
- Integration with traditional insurance systems
