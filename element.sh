#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ATOMIC_NUMBER=1
SYMBOL=H
NAME=Hydrogen
EXPECTED_OUTPUT="The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."

if [[ -z $1 ]]
then 
  echo Please provide an element as an argument.
else 
  if [[ $1 =~ ^[0-9]+$ ]] 
  then
    ATOMIC_NUMBER=$1
    ELEMENT_RESULT=$($PSQL "SELECT elements.atomic_number, elements.symbol, elements.name, properties.type, properties.atomic_mass, properties.boiling_point_celsius, properties.melting_point_celsius FROM elements inner join properties on elements.atomic_number = properties.atomic_number WHERE elements.atomic_number = $ATOMIC_NUMBER")
  else 
    SEARCH_TERM="$1"
    ELEMENT_RESULT=$($PSQL "SELECT elements.atomic_number, elements.symbol, elements.name, properties.type, properties.atomic_mass, properties.boiling_point_celsius, properties.melting_point_celsius FROM elements inner join properties on elements.atomic_number = properties.atomic_number WHERE elements.name = '$SEARCH_TERM' OR elements.symbol = '$SEARCH_TERM'")
  fi

  IFS='|' ELEMENT=($ELEMENT_RESULT)

  # echo ${ELEMENT[0]} atomic_number
  # echo ${ELEMENT[1]} symbol
  # echo ${ELEMENT[2]} name
  # echo ${ELEMENT[3]} type
  # echo ${ELEMENT[4]} atomic_mass
  # echo ${ELEMENT[5]} boiling_point
  # echo ${ELEMENT[6]} melting_point

  echo "The element with atomic number ${ELEMENT[0]} is ${ELEMENT[2]} (${ELEMENT[1]}). It's a ${ELEMENT[3]}, with a mass of ${ELEMENT[4]} amu. ${ELEMENT[2]} has a melting point of ${ELEMENT[6]} celsius and a boiling point of ${ELEMENT[5]} celsius."
fi

