# AWS Multi-Account IAM & Cross-Account Access

## Account A: 000000000000
- group1: engine, ci (CLI/programmatic access)
- group2: alice, bob (console + CLI access)
- roleA: Administrator access excluding IAM API actions
- roleB: Can assume roleC only

## Account B: 111111111111
- roleC: Access to one designated S3 bucket
- Trusts only roleB from Account A

## Security
- Least privilege
- Cross-account AWS STS AssumeRole
- Restricted S3 access
- CloudTrail auditing

See NOTES.md for explanations and the real-world scenario.
