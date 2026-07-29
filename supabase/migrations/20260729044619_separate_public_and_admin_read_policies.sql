drop policy "public_can_read_active_apps" on public.menu_apps;

create policy "visitors_can_read_active_apps"
on public.menu_apps
for select
to anon
using (is_active);

create policy "authenticated_users_can_read_allowed_apps"
on public.menu_apps
for select
to authenticated
using (
  is_active
  or exists (
    select 1 from public.app_admins
    where app_admins.user_id = (select auth.uid())
  )
);
