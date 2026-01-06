-- NEW VERSION: Enhanced migration tracking with safety features

CREATE TABLE IF NOT EXISTS public.migration_history (
  filename text PRIMARY KEY,
  checksum text NOT NULL,
  applied_at timestamp with time zone DEFAULT now(),
  applied_by text NOT NULL,
  status text NOT NULL CHECK (status IN ('success', 'failed', 'rolled_back')),
  execution_time_ms integer,
  migration_type text CHECK (migration_type IN ('new_table', 'new_column', 'modify_column', 'delete_column', 'new_index', 'delete_index', 'rls_policy', 'data_migration', 'other'))
);

-- Create indexes for querying
CREATE INDEX IF NOT EXISTS idx_migration_history_applied_at 
  ON public.migration_history(applied_at DESC);

CREATE INDEX IF NOT EXISTS idx_migration_history_status 
  ON public.migration_history(status);

CREATE INDEX IF NOT EXISTS idx_migration_history_migration_type 
  ON public.migration_history(migration_type);-- NEW VERSION: Enhanced migration tracking with safety features

CREATE TABLE IF NOT EXISTS public.migration_history (
  filename text PRIMARY KEY,
  checksum text NOT NULL,
  applied_at timestamp with time zone DEFAULT now(),
  applied_by text NOT NULL,
  status text NOT NULL CHECK (status IN ('success', 'failed', 'rolled_back')),
  execution_time_ms integer,
  migration_type text CHECK (migration_type IN ('new_table', 'new_column', 'modify_column', 'delete_column', 'new_index', 'delete_index', 'rls_policy', 'data_migration', 'other'))
);

-- Create indexes for querying
CREATE INDEX IF NOT EXISTS idx_migration_history_applied_at 
  ON public.migration_history(applied_at DESC);

CREATE INDEX IF NOT EXISTS idx_migration_history_status 
  ON public.migration_history(status);

CREATE INDEX IF NOT EXISTS idx_migration_history_migration_type 
  ON public.migration_history(migration_type);
