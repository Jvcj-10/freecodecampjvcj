#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#User inputs info
echo "Enter your username:"
read USERNAME

LOOKUP_N=$($PSQL "SELECT username FROM guessing_game WHERE username='$USERNAME';")
LOOKUP_GAMES=$($PSQL "SELECT COUNT(*) FROM guessing_game WHERE username='$USERNAME';")
LOOKUP_SCORE=$($PSQL "SELECT MIN(best_game) FROM guessing_game WHERE username='$USERNAME';")

VALIDATION() {
if [[ -z $USERNAME ]]
then
  echo "Your username is not valid."
elif [[ ${#USERNAME} -gt 22 ]]
then
  echo "It should be 22 characters or less."
else
  
  if [[ -z $LOOKUP_N  ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
  else
    echo "Welcome back, $LOOKUP_N! You have played $LOOKUP_GAMES games, and your best game took $LOOKUP_SCORE guesses."
  fi
fi


}


#Generate random number
SCKEY=$(( RANDOM % 1000 + 1 ))

#Play
PLAY_GAME() {

#until loop is okay but functions calls can be an issue
: ' if [[ $GUESS =~ ^[0-9]+$ ]]
then
  until [[ $GUESS == $SCKEY ]]
  do
    if [[ $GUESS -gt $SCKEY  ]] #[[]] will have -gt -lt == etc values
    then  
      echo "It's lower than that, guess again:"
      PLAY_GAME
    elif (( $GUESS < $SCKEY  )) #(()) will have < = > etc values
    then
      echo "It's higher than that, guess again:"
      PLAY_GAME
    fi
  done
else
  echo "That is not an integer, guess again:"
  PLAY_GAME
fi '
 
#Build variables that contains key, count games and show the best games

echo "Guess the secret number between 1 and 1000:"
TIMES_GUESSED=0
while true #looping instead of until
do
  read GUESS
  ((TIMES_GUESSED++)) #increment in each interaction
  if [[ $GUESS =~ ^[0-9]+$ ]]
  then
      if [[ $GUESS == $SCKEY ]]
      then
       echo "You guessed it in $TIMES_GUESSED tries. The secret number was $SCKEY. Nice job!"
      break
      elif [[ $GUESS -gt $SCKEY  ]] #[[]] will have -gt -lt == etc values
      then  
        echo "It's lower than that, guess again:"
      elif (( $GUESS < $SCKEY  )) #(()) will have < = > etc values
      then
        echo "It's higher than that, guess again:"
      fi
  else
  echo "That is not an integer, guess again:" 
  fi
done

#Insert data depending of the user data history
if [[ -z $LOOKUP_GAMES ]]
then
  GP_SEARCH=$($PSQL "SELECT COUNT(*) FROM guessing_game WHERE username='$USERNAME');")
  NEW_GAME=$(( GP_SEARCH + 1 ))
  INSERT_DATA=$($PSQL "INSERT INTO guessing_game(username,games_played,best_game) VALUES('$USERNAME', $LOOKUP_GAMES, $TIMES_GUESSED);")
else
  CONTINUE_GAME=$(( LOOKUP_GAMES + 1 )) #add a game to the user key
  INSERT_DATA=$($PSQL "INSERT INTO guessing_game(username,games_played,best_game) VALUES('$USERNAME', $LOOKUP_GAMES, $TIMES_GUESSED);")
fi

}


VALIDATION
PLAY_GAME