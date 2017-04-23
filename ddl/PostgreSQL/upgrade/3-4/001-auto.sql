-- Convert schema 'ddl/_source/deploy/3/001-auto.yml' to 'ddl/_source/deploy/4/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE accounts ADD COLUMN date_signup timestamp NOT NULL;

;
ALTER TABLE accounts ADD COLUMN date_verified timestamp;

;
ALTER TABLE accounts ADD COLUMN date_lastlogin timestamp;

;

COMMIT;

