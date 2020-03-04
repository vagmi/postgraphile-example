begin;

  create table if not exists app.person (
    id bigserial primary key,
    full_name text not null,
    created_at timestamp default now() not null,
    updated_at timestamp default now() not null
  );
  comment on table app.person is 'Table to store person details';

  create trigger tg_person_set_updated_at before update
  on app.person 
  for each row execute procedure app.set_updated_at();

  create table if not exists app.restaurant (
    id bigserial primary key,
    name text not null,
    location point,
    created_at timestamp default now() not null,
    updated_at timestamp default now() not null
  );
  comment on table app.restaurant is 'Table to store restaurant details';

  create trigger tg_restaurant_set_updated_at before update
  on app.restaurant
  for each row execute procedure app.set_updated_at();

  create table if not exists app.dish (
    id bigserial primary key,
    name text not null,
    created_at timestamp default now() not null,
    updated_at timestamp default now() not null
  );
  comment on table app.dish is 'Table to store dish details';

  create trigger tg_dish_set_updated_at before update
  on app.dish
  for each row execute procedure app.set_updated_at();

  create table if not exists app.menu_item (
    id bigserial primary key,
    restaurant_id bigint not null references app.restaurant(id) on delete cascade,
    dish_id bigint not null references app.dish(id) on delete cascade,
    price numeric,
    currency text,
    created_at timestamp default now() not null,
    updated_at timestamp default now() not null
  );
  create index idx_fk_menu_item_dish_id on app.menu_item(dish_id);
  create index idx_fk_menu_item_restaurant_id on app.menu_item(restaurant_id);

  create trigger tg_menu_item_set_updated_at before update
  on app.menu_item
  for each row execute procedure app.set_updated_at();

  create table if not exists app.review (
    id bigserial primary key,
    person_id bigint not null references app.person(id) on delete cascade,
    restaurant_id bigint not null references app.restaurant(id) on delete cascade,
    rating int not null,
    details text,
    created_at timestamp default now() not null,
    updated_at timestamp default now() not null
  );
  create index idx_fk_review_person_id on app.review(person_id);
  create index idx_fk_review_restaurant_id on app.review(restaurant_id);
  create trigger tg_review_set_updated_at before update
  on app.review
  for each row execute procedure app.set_updated_at();

  create table if not exists app.review_dish (
    id bigserial primary key,
    review_id bigint not null references app.review(id) on delete cascade,
    menu_item_id bigint not null references app.menu_item(id) on delete cascade,
    rating int,
    details text,
    created_at timestamp default now() not null,
    updated_at timestamp default now() not null
  );
  create trigger tg_review_dish_set_updated_at before update
  on app.review_dish
  for each row execute procedure app.set_updated_at();

  create or replace function app.person_reviewed_dishes(prsn app.person) returns setof app.dish as $$
    select distinct d.* 
    FROM app.person p 
    join app.review r on r.person_id = p.ID
    join app.review_dish rd on rd.review_id = r.ID
    join app.menu_item mi on mi.id = rd.menu_item_id
    join app.dish d on d.id = mi.dish_id
    where p.id = prsn.id;
  $$ language sql stable;

commit;