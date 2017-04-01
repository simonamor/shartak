-- Convert schema 'ddl/_source/deploy/2/001-auto.yml' to 'ddl/_source/deploy/3/001-auto.yml':;

;
BEGIN;

;
CREATE INDEX account_roles_idx_account_id ON account_roles (account_id);

;
CREATE INDEX account_roles_idx_role_id ON account_roles (role_id);

;

;

;
DROP INDEX characters_fk_account_id;

;

;

COMMIT;

