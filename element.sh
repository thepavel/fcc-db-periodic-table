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
  if [[ $1 =~ ^[0-9]+$ ]]; then
   ATOMIC_NUMBER=$1
   echo $ATOMIC_NUMBER
   
   ELEMENT_RESULT="$($PSQL "SELECT elements.*, properties.type, properties.atomic_mass, properties.boiling_point_celsius, properties.melting_point_celsius FROM elements inner join properties on elements.atomic_number = properties.atomic_number WHERE elements.atomic_number = $ATOMIC_NUMBER")"
   echo $ELEMENT_RESULT

   #ELEMENT=$($PSQL "SELECT elements.*, properties.type, properties.atomic_mass, properties.boiling_point_celsius, properties.melting_point_celsius FROM elements inner join properties on elements.atomic_number = properties.atomic_number WHERE elements.atomic_number = $ATOMIC_NUMBER")
   #echo $ELEMENT
  else
   SYMBOL=$(sed -E '/^([A-Z])/\1/' < $1)
  fi

  OUTPUT="The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
  echo $EXPECTED_OUTPUT  
fi


