CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `railway`.`v_post_category` AS
    SELECT 
        `a`.`post_id` AS `post_id`, `b`.`name` AS `name`
    FROM
        (`railway`.`post_category` `a`
        JOIN `railway`.`category` `b` ON ((`a`.`category_id` = `b`.`category_id`)))