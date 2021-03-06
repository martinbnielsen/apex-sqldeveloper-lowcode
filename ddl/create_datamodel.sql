-- Generated by Oracle SQL Developer Data Modeler 17.2.0.188.1104
--   at:        2017-11-22 16:18:13 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



CREATE TABLE cars (
    cars_id              NUMBER NOT NULL,
    dealers_dealers_id   NUMBER NOT NULL,
    status_code          VARCHAR2(1) NOT NULL,
    reg_no               VARCHAR2(8),
    make                 VARCHAR2(60),
    model                VARCHAR2(60),
    reg_date             DATE,
    created_by           NUMBER NOT NULL,
    creation_date        DATE NOT NULL,
    last_updated_by      NUMBER,
    last_update_date     DATE
);

ALTER TABLE cars
    ADD CHECK (
        status_code IN (
            'A','D','I','X'
        )
    );

COMMENT ON TABLE cars IS
    'Cars are very central to this solution. Each car i registered with at licence plate (reg_no). Cars are unique and relates to the physical cars which are going in and out of the dealerships.'
;

COMMENT ON COLUMN cars.status_code IS
    'What is the status of this car';

COMMENT ON COLUMN cars.reg_no IS
    'The car registration number';

COMMENT ON COLUMN cars.make IS
    'The make of the car.Ex. BMW,Mercedes...';

COMMENT ON COLUMN cars.model IS
    'Model of the car. Ex. 330D,520i...';

COMMENT ON COLUMN cars.reg_date IS
    'The first registration date of the car';

CREATE INDEX cars__idx ON
    cars ( dealers_dealers_id ASC );

ALTER TABLE cars ADD CONSTRAINT cars_pk PRIMARY KEY ( cars_id );

CREATE TABLE customer_cars (
    customers_customers_id   NUMBER NOT NULL,
    cars_cars_id             NUMBER NOT NULL,
    created_by               NUMBER NOT NULL,
    creation_date            DATE NOT NULL,
    last_updated_by          NUMBER,
    last_update_date         DATE
);

CREATE INDEX customer_cars__idx ON
    customer_cars ( customers_customers_id ASC );

CREATE INDEX customer_cars__idxv1 ON
    customer_cars ( cars_cars_id ASC );

ALTER TABLE customer_cars ADD CONSTRAINT customer_cars_pk PRIMARY KEY ( customers_customers_id,cars_cars_id );

CREATE TABLE customers (
    customers_id       NUMBER NOT NULL,
    customer_name      VARCHAR2(250) NOT NULL,
    city               VARCHAR2(60),
    car_preferences    VARCHAR2(250),
    phone_no           VARCHAR2(30),
    email              VARCHAR2(100),
    created_by         NUMBER NOT NULL,
    creation_date      DATE NOT NULL,
    last_updated_by    NUMBER,
    last_update_date   DATE
);

COMMENT ON COLUMN customers.customer_name IS
    'The name of the customer';

COMMENT ON COLUMN customers.city IS
    'The city where the customer lives';

COMMENT ON COLUMN customers.car_preferences IS
    'What is the customer looking for when byuing a new car ?';

COMMENT ON COLUMN customers.phone_no IS
    'The primary phone number of the customer';

COMMENT ON COLUMN customers.email IS
    'e-Mail address of the customer. Used for sending out newsletters.';

ALTER TABLE customers ADD CONSTRAINT customers_pk PRIMARY KEY ( customers_id );

CREATE TABLE dealer_customers (
    dealers_dealers_id       NUMBER NOT NULL,
    customers_customers_id   NUMBER NOT NULL,
    created_by               NUMBER NOT NULL,
    creation_date            DATE NOT NULL,
    last_updated_by          NUMBER,
    last_update_date         DATE
);

CREATE INDEX dealer_customers__idx ON
    dealer_customers ( dealers_dealers_id ASC );

CREATE INDEX dealer_customers__idxv1 ON
    dealer_customers ( customers_customers_id ASC );

ALTER TABLE dealer_customers ADD CONSTRAINT dealer_customers_pk PRIMARY KEY ( dealers_dealers_id,customers_customers_id );

CREATE TABLE dealers (
    dealers_id         NUMBER NOT NULL,
    dealer_name        VARCHAR2(250) NOT NULL,
    employees          NUMBER(11,2),
    address            VARCHAR2(60),
    created_by         NUMBER NOT NULL,
    creation_date      DATE NOT NULL,
    last_updated_by    NUMBER,
    last_update_date   DATE
);

COMMENT ON COLUMN dealers.employees IS
    'Number of employees';

COMMENT ON COLUMN dealers.address IS
    'The address of the dealership';

ALTER TABLE dealers ADD CONSTRAINT dealers_pk PRIMARY KEY ( dealers_id );

ALTER TABLE cars
    ADD CONSTRAINT cars_dealers_fk FOREIGN KEY ( dealers_dealers_id )
        REFERENCES dealers ( dealers_id );

ALTER TABLE customer_cars
    ADD CONSTRAINT customer_cars_cars_fk FOREIGN KEY ( cars_cars_id )
        REFERENCES cars ( cars_id );

ALTER TABLE customer_cars
    ADD CONSTRAINT customer_cars_customers_fk FOREIGN KEY ( customers_customers_id )
        REFERENCES customers ( customers_id );

ALTER TABLE dealer_customers
    ADD CONSTRAINT dealer_customers_customers_fk FOREIGN KEY ( customers_customers_id )
        REFERENCES customers ( customers_id );

ALTER TABLE dealer_customers
    ADD CONSTRAINT dealer_customers_dealers_fk FOREIGN KEY ( dealers_dealers_id )
        REFERENCES dealers ( dealers_id );

CREATE SEQUENCE cars_cars_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER cars_cars_id_trg BEFORE
    INSERT ON cars
    FOR EACH ROW
    WHEN (
        new.cars_id IS NULL
    )
BEGIN
    :new.cars_id := cars_cars_id_seq.nextval;
END;
/

CREATE SEQUENCE customers_customers_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER customers_customers_id_trg BEFORE
    INSERT ON customers
    FOR EACH ROW
    WHEN (
        new.customers_id IS NULL
    )
BEGIN
    :new.customers_id := customers_customers_id_seq.nextval;
END;
/

CREATE SEQUENCE dealers_dealers_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER dealers_dealers_id_trg BEFORE
    INSERT ON dealers
    FOR EACH ROW
    WHEN (
        new.dealers_id IS NULL
    )
BEGIN
    :new.dealers_id := dealers_dealers_id_seq.nextval;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             5
-- ALTER TABLE                             11
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           3
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          3
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
