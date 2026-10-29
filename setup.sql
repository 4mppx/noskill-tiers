-- Pegar completo en Supabase > SQL Editor > Run
create table ranking(id int primary key, data jsonb not null default '[]');
insert into ranking values (1,'[]');
alter table ranking enable row level security;
create policy leer on ranking for select to anon using (true);

create function verificar(pw text) returns boolean
language sql security definer as $$ select pw = 'noskillkotier123' $$;

create function guardar(pw text, nuevos jsonb) returns void
language plpgsql security definer as $$
begin
  if pw <> 'noskillkotier123' then raise exception 'clave incorrecta'; end if;
  update ranking set data = nuevos where id = 1;
end $$;

grant execute on function verificar(text) to anon;
grant execute on function guardar(text, jsonb) to anon;
