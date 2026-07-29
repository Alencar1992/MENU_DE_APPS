create table public.app_admin_requests (
  user_id uuid primary key references auth.users(id) on delete cascade,
  email text not null check (position('@' in email) > 1),
  requested_at timestamptz not null default now()
);

alter table public.app_admin_requests enable row level security;
revoke all on public.app_admin_requests from anon, authenticated;
grant select, insert on public.app_admin_requests to authenticated;

create policy "users_can_read_own_admin_request"
on public.app_admin_requests
for select
to authenticated
using ((select auth.uid()) = user_id);

create policy "users_can_create_own_admin_request"
on public.app_admin_requests
for insert
to authenticated
with check ((select auth.uid()) = user_id);
