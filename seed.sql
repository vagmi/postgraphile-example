begin;
  do language plpgsql $$
  declare
    admn app.person;
    user1 app.person;
    user2 app.person;
  begin
    admn := app.register_person('Vagmi Mudumbai', 'vagmi@tarkalabs.com', 'password');
    user1 := app.register_person('User One', 'user1@example.com', 'password');
    user2 := app.register_person('User Two', 'user2@example.com', 'password');

    for i in 1..10 loop
      insert into app.restaurant (name) values ('restaurant ' || i);
      insert into app.dish (name) values ('dish ' || i);
    end loop;
  end;
  $$;
commit;