
ALTER TABLE `users`
  ADD COLUMN `last_login` TIMESTAMP NULL
;

ALTER TABLE `users`
  ADD COLUMN `last_logout` TIMESTAMP NULL
;
