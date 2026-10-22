# Task 3: Multi-Account IAM & Cross-Account Access

## 1. Would I give engine and ci IAM users with access keys in production?

No, not as the preferred production approach.

For engine, I would use AWS IAM Identity Center and AWS CLI SSO
to provide temporary credentials to a human engineer.

For ci, I would use an IAM role with a supported CI/CD OIDC
integration, avoiding long-lived AWS access keys in pipeline secrets.

Temporary credentials reduce the risk of leaked or forgotten keys.
If legacy IAM users are unavoidable, restrict permissions, protect
credentials, monitor usage, and plan a migration.

## 2. Why trust roleB's specific ARN instead of Account A root?

Trusting arn:aws:iam::000000000000:root delegates trust to
Account A. It does not mean only the root user can assume roleC.
Account A may authorize other identities, subject to applicable policies.

Trusting arn:aws:iam::000000000000:role/roleB identifies the
specific role intended for cross-account access and follows least privilege.

RoleB must also have an identity policy allowing sts:AssumeRole
on roleC. Administrators who can modify roleB or its permissions
must be controlled and audited.

## 3. Real-time scenario

A company runs its application in Account A and stores sensitive
production reports in an S3 bucket in Account B.

An authorized process assumes roleB in Account A. RoleB then uses
AWS STS AssumeRole to obtain temporary credentials for roleC.

RoleC can list the designated bucket and read, upload, or delete
objects within it. It cannot access other buckets through the
permissions granted for this task.

Other Account A roles cannot directly assume roleC because roleC
trusts only roleB. This reduces unauthorized access and the impact
of compromised credentials. CloudTrail can help audit role sessions.

Production recommendations:
- Prefer temporary credentials over long-lived access keys.
- Restrict who can assume and modify roleB.
- Enable CloudTrail monitoring.
- Test policies in a non-production environment.
- Consider permission boundaries and Organizations SCPs.
