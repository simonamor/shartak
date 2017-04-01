-- Convert schema 'ddl/_source/deploy/2/001-auto.yml' to 'ddl/_source/deploy/3/001-auto.yml':;

;
BEGIN;

;
CREATE INDEX account_roles_idx_account_id on account_roles (account_id);

;
CREATE INDEX account_roles_idx_role_id on account_roles (role_id);

;
ALTER TABLE account_roles ADD CONSTRAINT account_roles_fk_account_id FOREIGN KEY (account_id)
  REFERENCES accounts (account_id) ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE account_roles ADD CONSTRAINT account_roles_fk_role_id FOREIGN KEY (role_id)
  REFERENCES roles (role_id) DEFERRABLE;

;
ALTER TABLE characters DROP CONSTRAINT characters_fk_account_id;

;
ALTER TABLE characters ADD CONSTRAINT characters_fk_account_id FOREIGN KEY (account_id)
  REFERENCES accounts (account_id) ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;

COMMIT;

