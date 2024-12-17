#!/bin/sh

include() {

    ##
    # Definitions
    ##
    # Parameters
    local __file_to_include;

    __file_to_include=$1;

    . "$(pwd)/${__file_to_include}";
}

sanitize_input() {

    ##
    # Definitions
    ##
    # Parameters
    local __parameter;
    local __sanitization_method;

    local commands_available

    __parameter="$1";
    __sanitization_method="$2";


    case "$__sanitization_method" in
        'number')

            __parameter=$(echo "$__parameter" | tr -cd '[:digit:] [:space:]');
            ;;
        'alphanumeric')

            __parameter=$(echo "$__parameter" | tr -cd '[:alnum:] [:space:]');
            ;;
        'no programs')

            commands_available="$(get_programs)";
            
            # Wipe Parameter If Commands Exist in String
            for i in $commands_available
            do

                case "$__parameter" in

                    "${i}")
                        __parameter='';
                        break
                        ;;
                    "${i} "*)
                        __parameter='';
                        break
                        ;;
                    *" ${i}")
                        __parameter='';
                        break
                        ;;
                    *" ${i} "*)
                        __parameter='';
                        break
                        ;;
                esac
            done
            ;;
    esac

    echo "$__parameter";
}

##
# Get Programs:
#   Returns the programs the current user can run via their $PATH.
#   To prevent constantly slowly processing this functionality, grabs this data
#   from a file which is only updated occassionally.
##
get_programs() {

    local programs;
    local time_difference;
    local program_list='/tmp/programs.txt';
    local seconds_before_updating_program_list="$((60 * 60 * 24 * 30))";

    # Update List of Programs Available
    if [ -f "$program_list" ]
    then

        # If Exists, Update the Programs List Only After 30 Days
        time_difference=$(expr "$(date +%s)" - "$(stat $program_list -c %Y)");

        if [ "$time_difference" -gt "$seconds_before_updating_program_list" ]
        then
            
            # Refresh Programs List
            programs=$(get_programs_from_path);

            echo "$programs" > "$program_list";
        fi
    else

        # If Not Exists, Generate New Programs List
        programs=$(get_programs_from_path);

        echo "$programs" > "$program_list";
    fi

    # Grab the Programs List from the File
    echo "$(cat $program_list);"
}

##
# Get Programs from Path:
#   Returns the programs the current user can run via their $PATH.
#   This function is slow, as it recursively searches for programs.
#   Be careful running it too often.
##
get_programs_from_path() {

    local paths
    local programs;

    paths=$(echo "$PATH" | tr ':' ' ');

    for i in $paths
    do

        programs="$programs $(ls $i)";
    done;

    echo "$programs";
}