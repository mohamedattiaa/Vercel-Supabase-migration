# Operations

## How to Run Migrations

Migrations are executed automatically when:
- A SQL file is added or modified in `supabase/migrations/`
- Changes are pushed to the configured branch

No manual database access is required.

## Environment Configuration

The following GitHub Actions secret must be defined:

- `SUPABASE_DIRECT_URL`
  - Format:
    postgresql://postgres:PASSWORD@HOST:5432/postgres?sslmode=disable

## Monitoring

After each run, the workflow logs:
- Applied migrations
- Execution time
- Current database tables
- RLS status

Failures stop the pipeline immediately.
