#!/bin/bash

#Determines which hash type to usebased on user case input. 
decideHash () {

        #Request User Case for Hash 
        echo -e "What is your desired hash? " 
        echo "1) md5sum"
        echo "2) sha256sum"
        echo "3) sha512sum"
        echo "4) cancel"
	read CASE;

	# Perform resquested function 
	case $CASE in 
        	1) HASH="md5sum"  ;;
        	2) HASH="sha256sum";; 
        	3) HASH="sha512sum";;  
        	4) exit 2 ;; 
	esac
}

#This function creates the output file for the hashed files values to be stored in. 
outputFile () {
	#Read-in desired ouput file 
	echo -e "Enter output file name (Do not add file type): \c " 
        read FILE; 
}

#This function hashes a single file if the check statement determines input is a single files. 
hashFileExe () {
        echo ` $HASH $1 > "$2_$(date +%Y%m%d).txt" `
        echo "Number of files hashed: 1"        
}

#This ffunction hashes all contents of a directory, using a for loop for each file in the directory. 
#It also counts the number of files hashed and prints it when complete. 
hashDirExe () {
        COUNT=0 
	for f in $(ls $1) ;  
	        do 
	                echo ` $HASH $f > "$2_$(date +%Y%m%d).txt" ` 
		        let COUNT++ 
	        done 
        echo "Number of files hashed: $COUNT"
} 

#Check file 
if [ -e $1  ]; then 
	# Continue 
	decideHash
	outputFile
	hashFileExe $1 $FILE
	exit 0

elif [ -d $1 ]; then 
	#Continue
	decideHash
	outputFile
	hashDirExe $1 $FILE
	exit 0 
else
	echo "File does not exist"
	exit 1
fi
