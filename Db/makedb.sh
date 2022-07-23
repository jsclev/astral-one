# Nuke and pave
rm game.sqlite 2>/dev/null
sqlite3 game.sqlite ""
sqlite3 game.sqlite < common/create-tables.sql
sqlite3 game.sqlite < common/populate-core-tables.sql

# Engine Tests
cp game.sqlite "../Engine Tests/Resources/game.sqlite"

# Astral One files
sqlite3 game.sqlite < astral-one/populate-core-tables.sql
sqlite3 game.sqlite < astral-one/game.sql
cp game.sqlite "../Astral One/Resources/Data/game.sqlite"

# Civilization II
sqlite3 game.sqlite < civilization-2/populate-core-tables.sql

# Fantasy
sqlite3 game.sqlite < fantasy/populate-core-tables.sql

# Stone to Space
sqlite3 game.sqlite < stone-to-space/populate-core-tables.sql
sqlite3 game.sqlite < stone-to-space/populate-city-names.sql
sqlite3 game.sqlite < stone-to-space/game.sql
cp game.sqlite "../Pathfinder/Stone to Space/Resources/Data/game.sqlite"

# Simulator
cp game.sqlite "../Simulator/Simulator/Resources/Data/game.sqlite"
