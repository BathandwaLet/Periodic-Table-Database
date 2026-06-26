#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
else
  #Check type of input
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    RESULT=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1") #Atomic number
    if [[ -z $RESULT ]]
    then
      echo "I could not find that element in the database."
      exit
    fi
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
    TYPE=$($PSQL "SELECT type FROM types JOIN properties USING(type_id) WHERE atomic_number=$1")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
    echo "The element with atomic number $RESULT is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    exit
  elif [[ $1 =~ ^[A-Za-z]{1,2}$ ]]
  then
    RESULT=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'") #Symbol
    if [[ -z $RESULT ]]
    then
      echo "I could not find that element in the database."
      exit
    fi
    NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")
    ATOMIC_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
    TYPE=$($PSQL "SELECT type FROM types JOIN properties USING(type_id) WHERE atomic_number=$ATOMIC_NUM")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUM")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUM")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUM")
    echo "The element with atomic number $ATOMIC_NUM is $NAME ($RESULT). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    exit
  else
    RESULT=$($PSQL "SELECT name FROM elements WHERE name='$1'") #Name
    if [[ -z $RESULT ]]
    then
      echo "I could not find that element in the database."
      exit
    fi
    ATOMIC_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
    TYPE=$($PSQL "SELECT type FROM types JOIN properties USING(type_id) WHERE atomic_number=$ATOMIC_NUM")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUM")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUM")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUM") 
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUM")
    echo "The element with atomic number $ATOMIC_NUM is $RESULT ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $RESULT has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    exit
  fi
fi





