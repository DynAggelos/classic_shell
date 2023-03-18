#!/bin/sh

####################
# OS Functions
####################

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

####################
# Super User Functions
####################

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
    sudo_installed=$(apt search sudo 2> /dev/null | sed -e s/'sudo[^0-9a-z\-].*\[installed.*'/'sudo installed'/ | grep -o 'sudo installed');

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
    su_installed=$(apt search util-linux 2> /dev/null | sed -e s/'util-linux[^0-9a-z\-].*\[installed.*'/'su installed'/ | grep -o 'su installed');

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

##########
# Run Command as Superuser
##########
superuser()
{
    ##
    # Definitions
    ##
    # Parameters
    local parameter_1="$1";
    
    local superuser_command;
    local can_user_sudo;
    local can_user_su;

    # Check for su Installation
    can_sudo can_user_sudo;

    if [ "$can_user_sudo" -eq '1' ]
    then
        eval sudo "$parameter_1";
    else
        can_su can_user_su;

        if [ "$can_user_su" -eq '1' ]
        then
            if [ ! "$(whoami)" = 'root' ]
            then
                # Change to Root
                su -;
            fi

            eval "$parameter_1";
        else
            echo "Cannot execute commands as root.";

            exit;
        fi
    fi
}

####################
# Input Sanitization
####################

##########
# Basic Sanitization of User Input
#----
# Parameter 1 = User Input
# Parameter 2 = Data Type
##########
#sanitize_input()
#{
    ##
    # Definitions
    ##
    # Parameters
#    local __return_parameter=$1;
#    local __return_value;
#    local parameter_2="$2";

#    local __commands_available=`compgen -c`;

    ##
    #
    ##
#    if [ "$parameter_2" -eq "number" ]
#    then
#        __return_parameter=`echo "$__return_parameter" | grep -Eox -m 1 '[0-9]{1,100}'`;
#    else
#        if [ "$parameter_2" -eq "string" ]
#        then
#            for i in $__commands_available
#            do
#                __return_parameter=`echo "$__return_parameter" | sed -E s/"(\ ?($i)\ ?){0,10}"//`;
#            done
#        else
#            if [ "$parameter_2" -eq "anything" ]
#            then
#                1
                # Anything is Possible, Including Commands
#            fi
#        fi
#    fi

    ##
    # Return
    ##
#    eval $__return_parameter="'$__return_value'";
#}

##########
# DO NOT USE, UNSAFE TO DEPEND ON!!!
# Basic Sanitization of User Input
#----
# Parameter 1 = User Input
# Parameter 2 = Data Type
##########
#remove_commands()
#{
    ##
    # Definitions
    ##
    # Parameters
#    local __return_parameter=$1;
#    local __return_value;

    # Note: Source from https://unix.stackexchange.com/a/120870
#    local __commands_available=`{ IFS=:; ls -H $PATH; }`

#    __commands_available=`echo "$__commands_available" | sed -E s/"[_\-\\]"/&/`;

#    echo $__commands_available;

    ##
    # Remove All Known Commands from
    ##
    #for i in $__commands_available
    #do
        #__return_parameter=`echo "$__return_parameter" | sed -E s/"(\ ?($i)\ ?){0,10}"//`;
    #    echo "$__return_parameter" | sed -E s/"(\ ?($i)\ ?){0,10}"//;
    #done

    #echo $__return_parameter | sed -E s/"(\ ?($i)\ ?){0,10}"//`;
#}