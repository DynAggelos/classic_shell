#!/bin/sh

##########
# Determine Which OS User is Running, by Argument
##########
what_os()
{
    ##
    # Definition
    ##
    # Parameters
    local parameter_1=$1;

    # Return Parameter
    local __return_parameter=$2;
    local __return_value;

    case "$parameter_1" in
        "1")
            __return_value="Debian";
            ;;
        [Dd]"ebian")
            __return_value="Debian";
            ;;
        [Uu]"buntu")
            __return_value="Debian";
            ;;
        [Mm]"int")
            __return_value="Debian";
            ;;
        "2")
            __return_value="Fedora";
            ;;
        [Ff]"edora")
            __return_value="Fedora";
            ;;
        [Oo]"pen"[Ss][Uu][Ss][Ee])
            __return_value="Fedora";
            ;;
        [Cc]"ent"[Oo][Ss])
            __return_value="Fedora";
            ;;
        "3")
            __return_value="Arch";
            ;;
        [Aa]"rch")
            __return_value="Arch";
            ;;
        [Mm]"anjaro")
            __return_value="Arch";
            ;;
        [Gg]"aruda")
            __return_value="Arch";
            ;;
        *)
            __return_value="Arch";
            ;;
    esac

    ##
    # Return
    ##
    eval $__return_parameter="'$__return_value'";
}

##########
# Determine Which OS User is Running, Interactively
##########
what_os_interactive()
{
    ##
    # Definition
    ##
    # Return Parameter
    local __return_parameter=$1;
    local __return_value;

    # Variables
    local choice
    local true_choice

    echo "What operating system are you running? (This is so we can use commands that will work with your operating system.)";
    echo "1. Debian and Debian-Based OS (Debian, Ubuntu, Mint, Etc.)";
    echo "2. Fedora and Fedora-Based OS (Fedora, OpenSUSE, CentOS, Etc.)";
    echo "3. Arch and Arch-Based OS (Arch, Manjaro, Garuda Etc.)";

    read choice;

    echo;

    what_os $choice true_choice;

    __return_value=$true_choice

    ##
    # Return
    ##
    eval $__return_parameter="'$__return_value'";
}

##########
# Determine If User Can sudo
##########
can_sudo()
{
    ##
    # Definitions
    ##
    local __return_parameter=$1;
    local __return_value;

    local sudo_installed;

    # Check for sudo Installation
    sudo_installed=`apt search sudo 2> /dev/null | sed -e s/'sudo[^0-9a-z\-].*\[installed.*'/'sudo installed'/ | grep -o 'sudo installed'`;

    if [ "$sudo_installed" != "" ]
    then
        # Determine If User Can sudo
        sudo --validate > /dev/null 2>&1;

        __return_value=$?;

        if [ "$__return_value" -lt 1 ]
        then
            __return_value=1;
        else
            __return_value=0;
        fi
    fi

    ##
    # Return
    ##
    eval $__return_parameter="'$__return_value'";
}

##########
# Determine If User Can su
##########
can_su()
{
    ##
    # Definitions
    ##
    local __return_parameter=$1;
    local __return_value;

    local su_installed;

    # Check for su Installation
    su_installed=`apt search util-linux 2> /dev/null | sed -e s/'util-linux[^0-9a-z\-].*\[installed.*'/'su installed'/ | grep -o 'su installed'`;

    if [ "$su_installed" != "" ]
    then
        __return_value=1;
    else
        __return_value=0;
    fi

    ##
    # Return
    ##
    eval $__return_parameter="'$__return_value'";
}