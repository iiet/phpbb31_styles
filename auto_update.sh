#!/bin/bash
####################################
# Move this file in directory e.g. iet_styles and start
####################################
FORUM_USER="forum"
DIRECTORY="phpbb31_styles"
IET_DARK_BRANCH="styles/digi"
IET_DARK="/www/forum.iiet.pl/public_html/styles/iet_dark"
IET_BLACK_BRANCH="styles/black"
IET_BLACK="/www/forum.iiet.pl/public_html/styles/iet_black"
#######################################
#COLORS
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
bldpur='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset
############################################
echo -e "${bldylw}Hi, I'll update styles for you"
echo -e "This may take a while"
echo -e "${bldpur}Purple color ${bldylw}stands for output from other commands"
echo -e "----------------------------------------------------------------------------"
if [ ! -d "$DIRECTORY" ]; then
  echo -e "${bldred}Failure! Please clone repo to $DIRECTORY"
  exit 1
fi

if [ "$USER" != "$FORUM_USER" ]; then
  echo -e "${bldred}Failure! Cannot run as $USER, you must run this script as $FORUM_USER user"
  exit 1
fi

echo -e "${txtgrn}Repository exists"

echo -e "${txtblu}Changing branch to styles/digi and pulling${bldpur}"

cd $DIRECTORY

#######################################################
git checkout $IET_DARK_BRANCH
git pull
if [ $? -ne 0 ]; then
  echo -e "${bldred}Failure! While working with repository"
  exit 1
fi
echo -e "${txtgrn}[SUCCESS]"

echo -e "${txtblu}Copying style folder to $IET_DARK ${bldpur}"
\cp -R style $IET_DARK

if [ $? -ne 0 ]; then
  echo -e "${bldred}Failure! While copying"
  exit 1
fi

echo -e "${txtblu}Running uglifier${bldpur}"
`$IET_DARK/uglify.sh`
if [ $? -ne 0 ]; then
  echo -e "${bldred}Failure! While running uglifier"
  exit 1
fi

echo -e "${txtgrn}[SUCCESS]"
echo -e "-----------------------------------------------------------------------------------"

##########################################################

git checkout $IET_BLACK_BRANCH
git pull
if [ $? -ne 0 ]; then
  echo -e "${bldred}Failure! While working with repository"
  exit 1
fi
echo -e "${txtgrn}[SUCCESS]"

echo -e "${txtblu}Copying style folder to $IET_BLACK ${bldpur}"
\cp -R style $IET_BLACK

if [ $? -ne 0 ]; then
  echo -e "${bldred}Failure! While copying"
  exit 1
fi

echo -e "${txtblu}Running uglifier${bldpur}"
`$IET_BLACK/uglify.sh`
if [ $? -ne 0 ]; then
  echo -e "${bldred}Failure! While running uglifier"
  exit 1
fi

echo -e "${txtgrn}[SUCCESS]"
echo -e "-----------------------------------------------------------------------------------"

##########################################################

echo -e "${bldylw} Remember to clear cache in phpBB administrator settings :)"
echo -e "${bldylw} TODO!: Doesn't update fonts, check them"
