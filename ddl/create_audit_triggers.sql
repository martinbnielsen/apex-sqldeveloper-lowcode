-- -------------------------------------------------
-- Title  : Create audit triggers
-- Created: Wed Nov 22 2017 16:16:29 GMT+0100 (CET)
-- -------------------------------------------------


-- Create before insert row trigger: CARS_biur_aud
create or replace trigger CARS_BIUR_AUD
  before insert or update on CARS
    for each row
begin
if inserting then
  :new.created_by := -1;
  :new.creation_date := SYSDATE;
else
  :new.last_updated_by := -1;
  :new.last_update_date := SYSDATE;
end if;
end;
/

-- Create before insert row trigger: CUSTOMER_CARS_biur_aud
create or replace trigger CUSTOMER_CARS_BIUR_AUD
  before insert or update on CUSTOMER_CARS
    for each row
begin
if inserting then
  :new.created_by := -1;
  :new.creation_date := SYSDATE;
else
  :new.last_updated_by := -1;
  :new.last_update_date := SYSDATE;
end if;
end;
/

-- Create before insert row trigger: CUSTOMERS_biur_aud
create or replace trigger CUSTOMERS_BIUR_AUD
  before insert or update on CUSTOMERS
    for each row
begin
if inserting then
  :new.created_by := -1;
  :new.creation_date := SYSDATE;
else
  :new.last_updated_by := -1;
  :new.last_update_date := SYSDATE;
end if;
end;
/

-- Create before insert row trigger: DEALER_CUSTOMERS_biur_aud
create or replace trigger DEALER_CUSTOMERS_BIUR_AUD
  before insert or update on DEALER_CUSTOMERS
    for each row
begin
if inserting then
  :new.created_by := -1;
  :new.creation_date := SYSDATE;
else
  :new.last_updated_by := -1;
  :new.last_update_date := SYSDATE;
end if;
end;
/

-- Create before insert row trigger: DEALERS_biur_aud
create or replace trigger DEALERS_BIUR_AUD
  before insert or update on DEALERS
    for each row
begin
if inserting then
  :new.created_by := -1;
  :new.creation_date := SYSDATE;
else
  :new.last_updated_by := -1;
  :new.last_update_date := SYSDATE;
end if;
end;
/
