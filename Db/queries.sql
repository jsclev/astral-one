select
    g.id as game_id,
    gp.name as player,
    t.ordinal as turn,
    ga.action_ordinal,
    a.name as action,
    gc.city as city,
    b.name as building,
    tech.name as tech,
    u.name as unit
from
    game g
inner join
    player gp on gp.game_id = g.id
inner join
    action ga on ga.game_id = g.id
inner join
    action a on a.id = ga.action_id
inner join
    turn t on t.id = ga.turn_id
left outer join
    game_settle_action gsa on gsa.action_id = ga.id
left outer join
    game_city gc on gc.id = gsa.game_city_id
left outer join
    game_movement_action gma on gma.action_id = ga.id
left outer join
    game_unit gu on gu.id = gma.game_unit_id
left outer join
    unit_type ut on ut.unit_type_id = u.id
left outer join
    game_building_action gba on gba.action_id = ga.id
left outer join
    game_building gb on gb.id = gba.game_building_id
left outer join
    building b on b.id = gb.building_id
left outer join
    game_tech_action gta on ga.id = gta.action_id
left outer join
    tech on gta.tech_id = tech.id
where
    g.id = 1 and
    gp.id = 1
order by
    g.id,
    t.ordinal,
    ga.action_ordinal
;