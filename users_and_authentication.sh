#!/bin/sh

####################
# OS Functions
####################

####################
# Super User Functions
####################

##########
# Can Sudo: Determines If User Can sudo. Requires typing in the User's Authentication Password
##########
can_sudo()
{
    ##
    # Definitions
    ##
    local sudo_installed;
    local return_value;

    # Check for sudo Installation
    sudo_installed=$(apt search sudo 2> /dev/null | sed -e s/'sudo[^0-9a-z\-].*\[installed.*'/'sudo installed'/ | grep -o 'sudo installed');

    if [ "$sudo_installed" != "" ]
    then
        # Determine If User Can sudo
        sudo --validate > /dev/null 2>&1;

        return_value=$?;

        if [ "$return_value" -lt 1 ]
        then
            return_value=1;
        else
            return_value=0;
        fi
    fi

    ##
    # Return
    ##
    echo "$return_value";
}

##########
# Can Su: Determines If User Can su
##########
can_su()
{
    ##
    # Definitions
    ##
    local su_installed;
    local return_value;

    # Check for su Installation
    su_installed=$(apt search util-linux 2> /dev/null | sed -e s/'util-linux[^0-9a-z\-].*\[installed.*'/'su installed'/ | grep -o 'su installed');

    if [ "$su_installed" != "" ]
    then
        return_value=1;
    else
        return_value=0;
    fi

    ##
    # Return
    ##
    echo "$return_value";
}

##########
# Superuser: Runs a command as the super user.
##########
superuser()
{
    ##
    # Definitions
    ##
    # Parameters
    local __parameter_1="$1";
    
    local can_user_sudo;
    local can_user_su;

    # Check for su Installation
    can_sudo can_user_sudo;

    if [ "$can_user_sudo" -eq '1' ]
    then

        eval sudo "$__parameter_1";
    else

        can_su can_user_su;

        if [ "$can_user_su" -eq '1' ]
        then

            if [ ! "$(whoami)" = 'root' ]
            then

                # Change to Root
                su -;
            fi

            eval "$__parameter_1";
        else

            echo "Cannot execute commands as root.";

            exit;
        fi
    fi
}

##########
# Kill User: Kills all user processes. Will not kill the root user.
##########
kill_user()
{
    ##
    # Definitions
    ##
    # Parameters
    local __user_to_logout=$1;

    # Variables
    local return_value;

    # Check for sudo Installation
    if [ "$__user_to_logout" != 'root' ]
    then
        superuser "pkill -KILL -u $__user_to_logout";

        return_value=1;
    else

        return_value=0;
    fi

    ##
    # Return
    ##
    echo "$return_value";
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