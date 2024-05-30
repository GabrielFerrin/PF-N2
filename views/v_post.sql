CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `railway`.`v_post` AS
    SELECT 
        `a`.`post_id` AS `post_id`,
        `a`.`title` AS `title`,
        `a`.`content` AS `content`,
        `b`.`name` AS `user`
    FROM
        (`railway`.`post` `a`
        JOIN `railway`.`user` `b` ON ((`a`.`user_id` = `b`.`user_id`)))