# TODO
# Copy db file to correct iOS folder
#rm civitas.sqlite 2>/dev/null
#sqlite3 civitas.sqlite ""
sqlite3 civitas.sqlite < tables.sql
sqlite3 civitas.sqlite < data/core.sql
sqlite3 civitas.sqlite < data/game-1.sql

# Copy the database to the correct directory for the Android project
#cp civitas.sqlite ../android/app/src/main/assets/civitas.db

# Copy the database to the correct directory for the iOS project
#mkdir -p ../ios/Scintillate/Scintillate/Assets.db
cp civitas.sqlite "../Astral One Engine/Astral One Engine/Resources/Data/civitas.db"
cp civitas.sqlite "../Pathfinder/Pathfinder/Resources/Data/civitas.sqlite"
