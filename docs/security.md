# Security

## Data Access

- Database access is performed using a dedicated PostgreSQL connection string
- Credentials are stored only in GitHub Actions secrets
- No secrets are committed to the repository

## Scope of Access

- The workflow has schema-level access only
- No application data is copied or exported

## Risks and Mitigations

| Risk | Mitigation |
|----|----|
| Accidental migration | Branch-based triggering |
| Re-running migrations | migration_history table |
| Unauthorized access | GitHub Secrets |

This framework does not expose sensitive data.
