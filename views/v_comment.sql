CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `railway`.`v_comment` AS
    SELECT 
        `a`.`comment_id` AS `comment_id`,
        `a`.`post_id` AS `post_id`,
        `a`.`content` AS `content`,
        `b`.`name` AS `name`,
        `a`.`date_created` AS `date_created`
    FROM
        (`railway`.`comment` `a`
        JOIN `railway`.`user` `b` ON ((`a`.`user_id` = `b`.`user_id`)))