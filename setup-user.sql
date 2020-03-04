create role app_graphile login password 'password123';

grant connect on database reviews to app_graphile;

create role app_anonymous;
grant app_anonymous to app_graphile;

create role app_user;
grant app_user to app_graphile;

create role app_admin;
grant app_admin to app_graphile;