#!/bin/bash
# Check if the path is provided
if [ -z "$1" ]; then
    echo "Path is not provided"
    exit 1
fi
# Get the path from the argument
path=$1
echo "The path entered is $path"
# Navigate to the provided path
cd $path || exit
echo "The current directory is $(pwd)"
#Getting the count of availble files with .jar & .ear extension
jarCount=$(find $path -type f -name "*.jar" | grep -c '.jar$')
earCount=$(find $path -type f -name "*.ear" | grep -c '.ear$')
echo "jar count is $jarCount"
echo "ear count is $earCount"
#Checking the condition that the jar count is >= 1
if [ $jarCount -ge 1 ]; then
#loading the *.jar in to jarfile for looping
        for jarfile in *.jar;
         do
#Checking the condition that the jarfile exits in the path or not
          if [ -f "$jarfile" ]; then
#Storing the jar files in to an array
           jar_files+=("$jarfile")
          fi
         done
#Getting the releaseno.txt file path
relnopath=$2
#Running the loop till jar count fails
         for (( i=0; i<$jarCount; i++ ));
          do
#Printing and checking the value of jar array in each index position
           echo "Value at $i position  is ${jar_files[i]}"
#Getting the release no for each index position of jar while running the loop
           jarReleaseValues=$(grep "^${jar_files[i]}" $relnopath | cut -d'=' -f2)
#Printing and checking the value of jar relase no for each index position
           echo "Release no. of ${jar_files[i]} is $jarReleaseValues"
#Tar the jar file accoridngly for the release no
           tar -cf inmobilepackDEVTAR.$jarReleaseValues ${jar_files[i]}
          done
fi
if [ $earCount -ge 1 ]; then
        for earfile in *.ear;
         do
          if [ -f "$earfile" ]; then
           ear_files+=("$earfile")
          fi
         done
        for ((i=0; i<$earCount; i++ ));
         do
          echo "Value at $i position is ${ear_files[i]}"
          earReleaseValues=$(grep "^${ear_files[i]}" $relnopath | cut -d'=' -f2)
          echo "Release no. of ${ear_files[i]} is $earReleaseValues"
          tar -cf inmobilepackDEVTAR.$earReleaseValues ${ear_files[i]}
         done
fi
echo "Congrats!!, Your tar file is succesfully executed and please find the size below"
ls -ltr *.*
