# Architecture

## High-Level Flow

1. A developer adds a SQL migration file under `supabase/migrations/`
2. Code is pushed to the configured Git branch
3. GitHub Actions triggers the Smart Migrations workflow
4. The workflow connects directly to the Supabase PostgreSQL database
5. Only new migrations are executed
6. Results are recorded in `migration_history`
7. The database state is displayed in workflow logs

## Components

- GitHub Actions (CI/CD)
- PostgreSQL client (psql)
- Supabase PostgreSQL database
- Custom migration tracking table

## Key Design Principle

The database is the source of truth for migration state.
