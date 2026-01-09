# Overview

This project uses an automated database migration framework to synchronize
Supabase database schema changes with application code through GitHub Actions.

The system ensures that:
- Database migrations are applied automatically on code push
- Each migration runs only once
- Execution history is tracked inside the database
- Schema changes are reproducible and auditable

The system replaces manual database changes with a CI/CD-driven process based on
GitHub Actions and PostgreSQL-native state tracking.


This framework is designed to be reused across multiple Vercel v0 projects.

## Scope

This framework covers:
- SQL schema migrations stored in the repository
- Automated execution via GitHub Actions
- Migration state tracking inside the database itself

## Key Components

- GitHub Actions workflow: `main.yml`
- PostgreSQL migration tracking table: `migration_history`
- Supabase-hosted PostgreSQL (SaaS or VM-hosted)
