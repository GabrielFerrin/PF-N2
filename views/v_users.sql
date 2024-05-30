CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `railway`.`v_user` AS
    SELECT 
        `a`.`user_id` AS `user_id`,
        `a`.`name` AS `name`,
        `a`.`email` AS `email`,
        `b`.`name` AS `rol_name`,
        `c`.`name` AS `country_name`,
        `a`.`bio` AS `bio`,
        `a`.`image` AS `image`,
        `a`.`date_created` AS `date_created`
    FROM
        ((`railway`.`user` `a`
        JOIN `railway`.`role` `b` ON ((`a`.`role_id` = `b`.`role_id`)))
        JOIN `railway`.`country` `c` ON ((`a`.`country_id` = `c`.`country_id`)))