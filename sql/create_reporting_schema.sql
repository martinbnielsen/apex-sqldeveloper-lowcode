REM Create a user for the reporting schema

create user datamodel identified by oracle;
grant create session, create table, create view to datamodel;
alter user datamodel quota unlimited on users;
