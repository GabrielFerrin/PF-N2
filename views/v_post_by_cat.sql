CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `railway`.`v_post_by_cat` AS
    SELECT 
        `a`.`post_id` AS `post_id`,
        `a`.`category_id` AS `category_id`,
        `c`.`name` AS `category`,
        `d`.`user_id` AS `user_id`,
        `d`.`name` AS `user`,
        `b`.`title` AS `title`,
        `b`.`content` AS `content`,
        `b`.`date_created` AS `date_created`
    FROM
        (((`railway`.`post_category` `a`
        JOIN `railway`.`post` `b` ON ((`a`.`post_id` = `b`.`post_id`)))
        JOIN `railway`.`category` `c` ON ((`a`.`category_id` = `c`.`category_id`)))
        JOIN `railway`.`user` `d` ON ((`b`.`user_id` = `d`.`user_id`)))