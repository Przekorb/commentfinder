#!/bin/bash
#by uala

#Colors#

C=$(printf '\033')
RED='\033[0;31m'
GREEN="${C}[1;32m"
YELLOW="${C}[1;33m"
BLUE="${C}[1;34m"
LIGHT_MAGENTA="${C}[1;95m"
DG="${C}[1;90m" #DarkGreen
NC="${C}[0m" #nocolor


function drawLines()
{
	parameter=$1
	echo ${YELLOW}'-----------------------'$NC ${BLUE}$1 $NC${YELLOW}'-----------------------'$NC
}
#Arguments Parsing#
POSITIONAL=()
	while [[ $# -gt 0 ]]; do
	  key="$1"

	  case $key in
	    -f|--file)
	      FILE="$2"
	      shift # past argument
	      shift # past value
	      ;;
	    -h|--help)
	      HOST="$2"
	      shift # past argument
	      shift # past value
	      ;;
	    -t|--target)
	      TARGET="$2"
	      shift # past argument
	      shift # past value
	      ;;
	    --default)
	      DEFAULT=YES
	      shift # past argument
	      ;;
	    *)    # unknown option
	      POSITIONAL+=("$1") # save it in an array for later
	      shift # past argument
	      ;;
	  esac
	done
# restore positional parameters
set -- "${POSITIONAL[@]}"

# menu
menu() {
        printf "commentfinder finds interesting comments and api calls when given output from a directory traversal tool. Supported format are directories in first lines:\n/index\n/uploads\n...\n\n"
        printf "${YELLOW}Help: [-h/--help] \n${NC}"
        printf "${YELLOW}Target: [-t/--target] \n${NC}"
        printf "${YELLOW}Directories file: [-f/--file] ${NC}\n"
        printf "${YELLOW}Usage: ${BLUE}./$(basename $0) -t/--target ${NC}<TARGET-IP> ${BLUE}-f/--file ${NC}<DIRECTORIES FILE>${BLUE}\n"
        printf "${YELLOW}Example: ${BLUE}./commentfinder.sh -t 192.168.1.114:8080 -f port8080dirs.txt"
        exit 1
		}
#Error handling
if [ -z "${TARGET}" ] || [ -z "${FILE}" ]; then
        menu
fi

#Edit input file properly and save it to drectoryArray array
IFS=$'\r\n' GLOBIGNORE='*' command eval  'directoryArray=($(cut -d " " -f 1 '${FILE}'))'

#variables to help
arrayNoDuplicates=($(echo "${directoryArray[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
iteration=0
patterns="<!"


for directory in "${arrayNoDuplicates[@]}"
do
	drawLines $directory
	CurlRequest=$(curl -s -L --max-time 5 --fail -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36' ${TARGET}/${arrayNoDuplicates[$iteration]})
	#Connection check
	if [ 0 -eq $? ]; then
		:
	else
		echo 'Cannot connect to' ${TARGET}${arrayNoDuplicates[$iteration]}
	fi

	#Nasty html redirection check
	if [[ $CurlRequest == *"META http-equiv="* ]]; then
		htmlRedirection1=$(echo "{$CurlRequest}")
		htmlRedirection2=$(sed -n -e '/META http-equiv=/ s/.*\= *//p' <<< $htmlRedirection1)
		htmlRedirection3=${htmlRedirection2%\"*}
		echo "html redirection: ${BLUE}$htmlRedirection3"
		CurlRequest=$(curl -s -L --max-time 5 --fail -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36' ${TARGET}/${htmlRedirection3})
	fi

	CurlComments=$(echo "{$CurlRequest}" | grep -i '<!')
	CurlApis=$(echo "{$CurlRequest}" | grep -i '<script')

	uselessComments=$(echo "${CurlComments}" | grep -i -E 'if lt|if IE|if gt|endif|doctype')
	echo "${DG}$uselessComments"
	usefulComments=$(echo "${CurlComments}" | grep -i -v -E 'if lt|if IE|if gt|endif|doctype')
	echo "${GREEN}$usefulComments"
	usefulApis=$(echo "${CurlApis}" | grep -i -v -E 'angular|bootstrap|jquery' | grep -i 'src')
	echo "${LIGHT_MAGENTA}$usefulApis"

	let iteration++
done







