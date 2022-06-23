# Nuke and pave
rm game.sqlite 2>/dev/null
sqlite3 game.sqlite ""
sqlite3 game.sqlite < common/create-tables.sql

# Populate the common tables
sqlite3 game.sqlite < common/populate-tables.sql

# Populate the themed databases
sqlite3 game.sqlite < stone-to-space/populate-tables.sql
sqlite3 game.sqlite < astral-one/populate-tables.sql
sqlite3 game.sqlite < fantasy/populate-tables.sql
sqlite3 game.sqlite < civilization-2/populate-tables.sql

# Copy the database files to the correct project directories
cp game.sqlite "../Astral One/Resources/Data/game.sqlite"
cp game.sqlite "../Engine Tests/Resources/game.sqlite"
cp game.sqlite "../Pathfinder/Stone to Space/Resources/Data/game.sqlite"
cp game.sqlite "../Simulator/Simulator/Resources/Data/game.sqlite"
