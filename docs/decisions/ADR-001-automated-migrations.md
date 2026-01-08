# ADR-001: Automated Supabase Migrations via GitHub Actions

## Status
Accepted

## Context

As the number of Vercel v0 projects increased, managing database schema changes
manually became error-prone and difficult to audit. There was no reliable way to:

- Ensure migrations were applied consistently across environments
- Track which migrations had already been executed
- Safely re-run CI/CD pipelines without risking duplicate changes
- Handle Supabase deployments hosted outside the default SaaS assumptions

Additionally, when implementing CI-based migrations, several infrastructure and
connectivity issues were encountered, revealing gaps between local Supabase
development workflows and remote execution in GitHub Actions.

---

## Problems Identified

1. **Manual migration execution**
   - No central history or audit trail
   - High risk of human error

2. **Incorrect database connectivity assumptions**
   - Supabase UI exposes `localhost` URLs intended for local development
   - These URLs are invalid from GitHub-hosted runners

3. **TLS negotiation mismatches**
   - VM-hosted PostgreSQL instances refused TLS connections
   - Default clients attempted to enforce TLS

4. **Secrets formatting issues**
   - GitHub Secrets preserved whitespace and trailing newlines
   - Resulted in invalid PostgreSQL connection strings

5. **Migration idempotency limitations**
   - Supabase CLI alone did not provide sufficient control over which migrations
     had already been executed in CI/CD contexts

---

## Decision

We implemented an **automated database migration framework** based on the
following decisions:

### 1. Use GitHub Actions for Migration Automation
GitHub Actions was selected to provide a reproducible, CI-driven migration
process triggered by repository changes.

### 2. Use Direct PostgreSQL Connectivity
Instead of relying solely on Supabase CLI abstractions, migrations connect
directly to PostgreSQL using `psql` and an explicit `SUPABASE_DIRECT_URL`.

### 3. Explicitly Control TLS Behavior
For VM-hosted Supabase deployments, TLS is explicitly configured in the
connection string (e.g. `sslmode=disable`) to match server capabilities.

### 4. Sanitize Secrets at Runtime
All database URLs are sanitized within the workflow to remove whitespace and
newline characters before use.

### 5. Introduce a Custom Migration Tracking Table
A dedicated `migration_history` table is used to:
- Track executed migrations
- Prevent re-execution
- Store execution metadata (status, duration, type)
- Enable auditing and debugging

### 6. Treat Database State as the Source of Truth
Migration execution decisions are based on database state rather than CI/CD
filesystem state or tool-internal history.

---

## Consequences

### Positive
- Database schema changes are reproducible and auditable
- CI/CD pipelines can be safely re-run
- Clear visibility into migration state
- Framework is reusable across multiple projects
- Works consistently across Supabase SaaS and VM-hosted deployments

### Trade-offs
- Increased CI/CD workflow complexity
- Requires PostgreSQL client availability in CI runners

These trade-offs were considered acceptable given the gains in reliability,
scalability, and operational safety.

---

## Lessons Learned

- Supabase connection details are context-dependent (local vs hosted vs VM)
- CI/CD environments require explicit, defensive configuration
- Database-driven migration tracking is more reliable than tool-based state
- Minor formatting issues (e.g. whitespace in secrets) can break production
  pipelines

This decision establishes a robust foundation for database change management
across all current and future projects.
