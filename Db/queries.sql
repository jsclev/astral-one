select
    g.id as game_id,
    gp.name as player_name,
    t.ordinal as turn,
    log.action_ordinal,
    a.name as action_name,
    gc.city as city_name,
    tech.name as tech_name,
    u.name as unit_name
from
    game g
inner join
    game_player gp on gp.game_id = g.id
inner join
    game_log log on log.game_id = g.id
inner join
    action a on a.id = log.action_id
inner join
    turn t on t.id = log.turn_id
left outer join
    game_settle_action gsa on gsa.game_log_id = log.id
left outer join
    game_city gc on gc.id = gsa.game_city_id
left outer join
    game_movement_action gma on gma.game_log_id = log.id
left outer join
    game_unit gu on gu.id = gma.game_unit_id
left outer join
    unit u on gu.unit_id = u.id
-- left outer join
--     game_build_action gba on gba.game_log_id = log.id
-- left outer join
--     game_building gc on gc.id = gsa.game_city_id
left outer join
    game_tech_action gta on log.id = gta.game_log_id
left outer join
    tech on gta.tech_id = tech.id
where
    g.id = 1 and
    gp.id = 1
order by
    g.id,
    t.ordinal,
    log.action_ordinal
;