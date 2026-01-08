# Overview

This project uses an automated database migration framework to synchronize
Supabase database schema changes with application code through GitHub Actions.

The system ensures that:
- Database migrations are applied automatically on code push
- Each migration runs only once
- Execution history is tracked inside the database
- Schema changes are reproducible and auditable

This framework is designed to be reused across multiple Vercel v0 projects.
