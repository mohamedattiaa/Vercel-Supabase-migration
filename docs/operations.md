# Operations

## Execution Trigger

The migration framework is triggered automatically when changes are pushed to the
configured branch

The entire operational logic is contained in:
.github/workflows/main.yml 

## End-to-End Execution Flow

1. A developer adds or updates SQL migration files in `supabase/migrations/`
2. A push to the integration branch triggers GitHub Actions
3. The workflow sanitizes the database connection secret
4. The workflow connects directly to Supabase PostgreSQL
5. The `migration_history` table is created or validated
6. Previously applied migrations are detected and skipped
7. New migrations are executed sequentially
8. Execution results are persisted in the database
9. The workflow stops immediately on failure

## Safe Re-execution

The workflow is designed to be safely re-runnable:
- Migrations already recorded as `success` are skipped
- Execution is driven by database state, not CI state
- Failed migrations are explicitly recorded for debugging

## Required Configuration

### GitHub Secrets


The following GitHub Actions secret must be defined:

- `SUPABASE_DIRECT_URL`
  - Format:
    postgresql://postgres:PASSWORD@HOST:5432/postgres?sslmode=disable

### Repository Structure

The following structure is required:

.github/workflows/smart-migration.yml
supabase/migrations/



## Monitoring and Troubleshooting

- Full execution logs are available in GitHub Actions
- Migration history can be queried directly from PostgreSQL
- Execution metadata includes timing, status, and migration type
- Failures block further deployments until resolved

## Operational Guarantees

- No migration is executed twice
- No migration is silently skipped
- Database schema changes are auditable
- CI/CD runs are deterministic


