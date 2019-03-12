#!/bin/bash


#### Function isUpToDate(): 
#### informs you if you're local repo is up to date with the remote repo

function isUpToDate(){

    git fetch
    if [ "$(git diff master origin/master)" = "" ]; then
        echo "*********************************************************************************************************"
        echo "Your local repo is already up to date."
        echo "*********************************************************************************************************"
    else
        echo "*********************************************************************************************************"
        echo "Your local repo is not up to date! \nYou can press enter and then select 6 to update your local repo."
        echo "*********************************************************************************************************"
    fi
}

/Users/declanwu/Desktop/ProjectAnalyze.sh

#### Function uncommit_change(): 
#### Puts all uncommited changes in a file changes.log 

function uncommit_change(){

    git status > changes.log
    echo "All uncommited changes, if any, are put in a file changes.log."
    read -p "Do you want to view change.log? (y/n) " answer
    if [ ${answer} == "y" ]; then
        echo "*********************************************************************************************************"
        echo "Here is change.log: "
        cat change.log
        echo "*********************************************************************************************************"
    fi

}

#### Function todo_log(): 
#### Puts each line from every file of your project with the tag #TODO into a file todo.log

function todo_log(){
    grep -hnr "#TODO" . > todo.log --exclude "todo.log" --exclude "ProjectAnalyze.sh"
    echo "Each line that contains #TODO are already put into todo.log."
    read -p "Do you want to view todo.log? (y/n) " answer
    if [ ${answer} == "y" ]; then
        echo "*********************************************************************************************************"
        echo "Here is todo.log: "
        cat todo.log
        echo "*********************************************************************************************************"
    fi
}


#### Function hsk_error: 
#### Checks all haskell files for syntax errors and puts the results into error.log 

function hsk_error(){
    find . -name "*.hs" -type f -exec ghc -fno-code {} \; 2> error.log
    echo " All haskell files with syntax errors are already in error.log."
    read -p "Do you want to view error.log? (y/n) " answer
    if [ ${answer} == "y" ]; then
        echo "*********************************************************************************************************"
        echo "Here is error.log: "
        cat error.log
        echo "*********************************************************************************************************"
    fi
}




#### Function time_stamp(): 
#### display the date, time, etc to the user.
time_stamp(){
    echo "*********************************************************************************************************"
    echo "The date is: "
    date
    echo "*********************************************************************************************************"
}


#### Function pull_change(): 
#### displays the differences between your local repo and remote repo, and updates your local repo.
function pull_change(){

    git fetch
    if [ "$(git diff master origin/master)" = "" ]; then
        echo "There's no changes to be pulled."
    else 
        echo "*********************************************************************************************************"
        echo "There are the differences to be pulled: "
        git diff master origin/master
        echo "*********************************************************************************************************"
        echo "Start pulling changes."
        git pull
        echo "*********************************************************************************************************"
        echo "Done pulling. "
    fi

}



#### Function custom_replace()
#### replaces some words with new words with customization
function custom_replace() {

    echo "Here are the files in your current directory: "
    ls
    read -p "Which file in current directory do you wish to modify? " file_name
    read -p "Which word do you wish to be replaced? " old_word
    read -p "Which word do you wish to have instead? " new_word
    read -p "Do you want this replacement to be case-sensitive? y/n " case_choice
    read -p "Would you like the result to be printed? y/n " out_put

    if [ "${case_choice}" =  "y" ]; then
        case_s="g"
    else
        case_s="i"
    fi


    if [ "${out_put}" = "y" ]; then
        out_choice=""
    else
        out_choice="-n"
    fi

    sed "${out_choice}" "s/${old_word}/${new_word}/${case_s}" "${file_name}"
}

#### Function press_enter(): 
#### make this program better looking when it runs. asks the user to press the Enter key after each selection has been completed, 
#### and clears the screen before the menu is displayed again.
function press_enter(){

    echo -en "\nPress Enter to continue."
    read
    clear
}

#### Building a menu
selection=
until [ "$selection" = "0" ]; do
    echo "
    *****************************************************************************************************
    PROGRAM MENU
    *****************************************************************************************************
    1 - Informs you if your local repo is up to date with the remote repo
    2 - Puts all uncommited changes in a file named changes.log
    3 - Puts each line from every file of your project with the tag #TODO into a file todo.log
    4 - Checks all haskell files for syntax errors and puts the results into error.log
    5 - Display the date to the user
    6 - Displays the differences between your local repo and remote repo, and then updates it
    7 - Replaces words in a file sitting in current directory with new words with customization
    0 - exit program
    Or press control + c to exit
    *****************************************************************************************************
"
    echo -n "Enter selection: "
    read selection
    echo ""
    case $selection in
        1 ) isUpToDate ; press_enter ;;
        2 ) uncommit_change ; press_enter ;;
        3 ) todo_log ; press_enter ;;
        4 ) hsk_error ; press_enter ;;
        5 ) time_stamp ; press_enter ;;
        6 ) pull_change ; press_enter ;;
        7 ) custom_replace ; press_enter ;;
        0 ) exit 0 ;;
        * ) echo "Please enter integer number ranging 0 to 7 "; press_enter
    esac
done
