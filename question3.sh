#!/bin/bash

#/*
# * Name: Le Phuong Trang Nguyen
# * NSID: len054
# * Student ID 11280441
# * Instructor: Mark Eramian
# * Course: CMPT 214 - Section 01
# */
#

# The main genres
HIPHOP="hip-hop"
METAL="metal"
POP="pop"
PUNK="punk"
RAP="rap"
ROCK="rock"
INDIE="indie"

# Change the current working directory to music
cd "music"

# Display on the console all the genre directories' names in music
ls -N -d * | sort

echo -----------------------------------------
# Let user choose a genre
printf "Enter a genre: " ; read GENRE; GENRE=${GENRE,,} ; echo "You have entered $GENRE."

echo -----------------------------------------
# Loop through 7 main genres and check if user types in one of them.
# If they do, display all the sub-genre in the main genre and
# prompt user to enter a sub-genre.
SUBGENRE=""
for BIG in $HIPHOP $METAL $POP $PUNK $RAP $ROCK $INDIE
do
  if [ $GENRE = $BIG ]
  then
    basename -a `find ./$GENRE -maxdepth 1 -name "*$GENRE*"` | sort
    echo -----------------------------------------
    printf "Enter a (sub-)genre: " ; read SUBGENRE; SUBGENRE=${SUBGENRE,,} ; echo "You have entered $SUBGENRE."
    echo -----------------------------------------
    break
  fi
done

# Create a new text file in the parent directory of music
# that contains the names of all the artist directories.
# It's name format is <genre>_artists.txt
# And also display how many artists were in the selected genre
if [[ $SUBGENRE = "" || $GENRE = $SUBGENRE ]]
then
  printf "The total number of artists in the genre %b is: " $GENRE
  basename -a `find ./$GENRE -maxdepth 1 ! -name "*$GENRE*"` | sort | tee ../$GENRE\_artists.txt | wc -l
else
  printf "The total number of artists in the genre %b is: " $SUBGENRE
  basename -a `find ./$GENRE/$SUBGENRE -maxdepth 1 -mindepth 1` | sort | tee ../$SUBGENRE\_artists.txt | wc -l
fi