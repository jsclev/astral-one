select
    c.command_id,
    t.ordinal,
    t.year,
    t.display_text,
    c.ordinal
from
    command c
inner join
    turn t on t.turn_id = c.turn_id
inner join
    player p on p.player_id = c.player_id
order by
    t.ordinal,
    p.ordinal;