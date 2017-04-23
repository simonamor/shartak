-- Convert schema 'ddl/_source/deploy/3/001-auto.yml' to 'ddl/_source/deploy/4/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE accounts ADD COLUMN date_signup datetime NOT NULL,
                     ADD COLUMN date_verified datetime NULL,
                     ADD COLUMN date_lastlogin datetime NULL;

;

COMMIT;

