#!/bin/sh
path="home/abhijeet/Desktop/test/" 
while true 
do
		inotifywait --recursive -qq -e attrib,create,delete,modify,delete_self,move,move_self,close_write $path
			echo "$path"   
			    cd $path                              #> /dev/null &> /dev/null
			    	git pull                              #> /dev/null &> /dev/null
					git add --all                         #> /dev/null &> /dev/null
						now=$(date)                           #> /dev/null &> /dev/null
							git commit -m "Auto-Commit at : $now" #> /dev/null &> /dev/null	
								git push -u origin master             #> /dev/null &> /dev/null
								    sleep 30
							    done
