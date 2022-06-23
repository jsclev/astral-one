# Nuke and pave
rm game.sqlite 2>/dev/null
sqlite3 game.sqlite ""
sqlite3 game.sqlite < common/create-tables.sql

# Populate the common tables
sqlite3 game.sqlite < common/populate-tables.sql

# Engine Tests
cp game.sqlite "../Engine Tests/Resources/game.sqlite"

# Astral One files
sqlite3 game.sqlite < astral-one/populate-tables.sql
cp game.sqlite "../Astral One/Resources/Data/game.sqlite"

# Civilization II
sqlite3 game.sqlite < civilization-2/populate-tables.sql

# Fantasy
sqlite3 game.sqlite < fantasy/populate-tables.sql

# Stone to Space
sqlite3 game.sqlite < stone-to-space/populate-tables.sql
sqlite3 game.sqlite < stone-to-space/game-1.sql
cp game.sqlite "../Pathfinder/Stone to Space/Resources/Data/game.sqlite"

# Simulator
cp game.sqlite "../Simulator/Simulator/Resources/Data/game.sqlite"
