CREATE VIEW `v_users` AS
select a.user_id, a.name, a.email, b.name, c.name, a.bio, a.image, a.date_created from railway.user a
	join railway.role b on a.role_id = b.role_id
    join railway.country c on a.country_id = c.country_id
    