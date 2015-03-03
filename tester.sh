#! /bin/bash

#Make sure there are args
[ -z "$1" ] && echo "No filename supplied" && exit 1
[ -z "$2" ] && echo "No example class supplied" && exit 1

#Set files
file="$1"
exampleClass="$2"

#check if there's a testing dir
if [ ! -d "testing" ]; then
  mkdir testing
fi

#Copying and entering testing dir
cp $file testing/
cd testing

#Check for testing files... or just one whatever
if [ ! -f tester.jar ]; then
  wget http://www.ccs.neu.edu/course/cs2510sp15/files/javalib.jar http://www.ccs.neu.edu/course/cs2510sp15/files/tester.jar 
fi

#Compile java file
javac -classpath javalib.jar:tester.jar $file

#Extract the tester jar
#don't currently know a good way around this.
if [ ! -d "tester" ]; then
  jar -xvf tester.jar 
fi

#Do the test!
java tester.Main $exampleClass

#Clean up testing dir
rm *.class $file

#Exit the testing dir
cd ../

exit
