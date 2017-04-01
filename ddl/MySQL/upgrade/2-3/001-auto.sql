-- Convert schema 'ddl/_source/deploy/2/001-auto.yml' to 'ddl/_source/deploy/3/001-auto.yml':;
-- Customised since roles table needs ENGINE=InnoDB before the two constraints are added to account_roles

;
BEGIN;

;
ALTER TABLE roles ENGINE=InnoDB;

ALTER TABLE account_roles ENGINE=InnoDB;
;
ALTER TABLE account_roles ADD INDEX account_roles_idx_account_id (account_id),
                          ADD INDEX account_roles_idx_role_id (role_id),
                          ADD CONSTRAINT account_roles_fk_account_id FOREIGN KEY (account_id) REFERENCES accounts (account_id) ON DELETE CASCADE ON UPDATE CASCADE,
                          ADD CONSTRAINT account_roles_fk_role_id FOREIGN KEY (role_id) REFERENCES roles (role_id);

;
ALTER TABLE characters DROP FOREIGN KEY characters_fk_account_id;

;
ALTER TABLE characters ADD CONSTRAINT characters_fk_account_id FOREIGN KEY (account_id) REFERENCES accounts (account_id) ON DELETE CASCADE ON UPDATE CASCADE;

;

COMMIT;

