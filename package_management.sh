#!/bin/sh

pwd;

find ./ system_info.sh

. ./system_info.sh;
. ./users_and_authentication.sh;

install_program() {

    ##
    # Definitions
    ##
    # Parameters
    local __program;

    __program=$(echo "$1" | sed s/'[;\.\*\/\\\ ]*'/''/);

    echo $__program;

    #if [ "$(is_program_installed $__program)" = '1' ]
    #then

    #    echo $__program;
    #fi
}