ALTER TABLE `owned_vehicles`
  ADD COLUMN `position` VARCHAR(36) NULL AFTER `jamstate`,
  ADD COLUMN `heading` VARCHAR(36) NULL AFTER `position`,
  ADD COLUMN `last_active` TIMESTAMP NULL AFTER `heading`
;
