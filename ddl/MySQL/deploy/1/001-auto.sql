-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Wed Dec 28 21:27:32 2016
-- 
;
SET foreign_key_checks=0;
--
-- Table: `account_roles`
--
CREATE TABLE `account_roles` (
  `account_id` integer unsigned NOT NULL,
  `role_id` integer unsigned NOT NULL,
  PRIMARY KEY (`account_id`, `role_id`)
);
--
-- Table: `accounts`
--
CREATE TABLE `accounts` (
  `account_id` integer unsigned NOT NULL auto_increment,
  `email` char(128) NOT NULL,
  `password` text NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE `email` (`email`)
);
--
-- Table: `roles`
--
CREATE TABLE `roles` (
  `role_id` integer unsigned NOT NULL auto_increment,
  `role` char(255) NOT NULL,
  `description` char(255) NULL,
  PRIMARY KEY (`role_id`)
);
--
-- Table: `sessions`
--
CREATE TABLE `sessions` (
  `id` char(72) NOT NULL,
  `session_data` mediumtext NULL,
  `expires` integer NULL,
  PRIMARY KEY (`id`)
);
SET foreign_key_checks=1;
