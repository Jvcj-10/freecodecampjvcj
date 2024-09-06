#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games")
echo $($PSQL "ALTER SEQUENCE teams_team_id_seq RESTART WITH 1")
echo $($PSQL "ALTER SEQUENCE games_game_id_seq RESTART WITH 1")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

  if [[ $WINNER != 'winner' ]]
  then
    #obtain winners names and get uniques names
   WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      if [[ -z $WINNER_ID ]]
      then
        INSERT_TEAMS=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
       #get teams winners id and save it on a variable for reuse
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'") 
      fi
   #obtain opponent names
   OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      if [[ -z $OPPONENT_ID ]]
      then
        #get opponent id
        INSERT_OPPONENT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
        #get teams opponent id
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      fi
  fi
  if [[ $ROUND != 'round' ]]
    then
           INSERT_GAME=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES('$YEAR','$ROUND','$WINNER_ID','$OPPONENT_ID','$WINNER_GOALS','$OPPONENT_GOALS')")
        #SAVE id to game id
        GAME_ID=$($PSQL "SELECT game_id FROM games WHERE round='$ROUND'")
    fi    
done