-- Bazaar Ledger — à exécuter une fois dans Supabase → SQL Editor

create table if not exists public.ledger_store (
  room_id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.ledger_store enable row level security;

drop policy if exists "ledger_select" on public.ledger_store;
drop policy if exists "ledger_insert" on public.ledger_store;
drop policy if exists "ledger_update" on public.ledger_store;

create policy "ledger_select"
  on public.ledger_store for select
  using (true);

create policy "ledger_insert"
  on public.ledger_store for insert
  with check (true);

create policy "ledger_update"
  on public.ledger_store for update
  using (true);

alter table public.ledger_store replica identity full;

do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and tablename = 'ledger_store'
  ) then
    alter publication supabase_realtime add table public.ledger_store;
  end if;
end $$;
