CREATE DATABASE stress;
\c stress
CREATE TABLE main_test (id SERIAL);
INSERT INTO main_test SELECT generate_series(1, 1000000);
