#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
#The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
 #all in one by reading user input
VALIDATION(){
if  [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
    exit 0
  else
    ELT_INPUT=$1
  fi
}
ELEMENTS() {
  if [[ -z $ELT_INPUT ]]
  then
    echo "Try again. Type a valid atomic number or element name"
  else
     if [[ ! $ELT_INPUT =~ ^[0-9]+$ ]]
    then
      ELT_VAR=$($PSQL "SELECT atomic_number FROM elements WHERE name='$ELT_INPUT' OR symbol='$ELT_INPUT';")
    else
      ELT_VAR=$($PSQL "SELECT atomic_number FROM properties WHERE atomic_number=$ELT_INPUT;")   
    fi
  fi 
ATN_CHECK=$($PSQL "SELECT atomic_number FROM properties")
  if [[ -z $ELT_VAR ]]
  then
    echo  "I could not find that element in the database."
  else
    NAME_EL=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ELT_VAR;")
    SYM_EL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ELT_VAR;")
    TYPE_EL=$($PSQL "SELECT type FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number=$ELT_VAR;")
    AT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELT_VAR;")
    MPC_EL=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELT_VAR;")
    BPC_EL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELT_VAR;")
  
    echo "The element with atomic number $ELT_VAR is $NAME_EL ($SYM_EL). It's a $TYPE_EL, with a mass of $AT_MASS amu. $NAME_EL has a melting point of $MPC_EL celsius and a boiling point of $BPC_EL celsius."
  fi
}
VALIDATION $1
ELEMENTS