#!/bin/sh

##########
# Is Package Installed: Determines if a package is installed on your system
##########
is_package_installed()
{

    ##
    # Definitions
    ##
    # Parameters
    local __program=$1;

    # Variables
    local program_location;
    local return_value=0;

    program_location=$(which "$__program");

    if [ "$program_location" != '' ]
    then

        return_value=1;
    fi

    ##
    # Return
    ##
    echo "$return_value";
}

##########
# Which Distro: Determines which Linux distribution the user is using
##########
which_distro()
{
    ##
    # Definitions
    ##
    # Parameters
    local __family=$1;

    # Variables 
    local os;
    local distro_info;
    local distro_name;
    local distro_family;
    local return_value;

    os="$(uname -o)";

    if [ "$os" = "GNU/Linux" ]
    then

        # Determine Distro
        distro_info=$(lsb_release -i);

        case "$distro_info" in

            # Debian Distros
            *'Debian'*)
                distro_name='Debian';
                distro_family='Debian';
                ;;
            *'Ubuntu'*)
                distro_name='Ubuntu';
                distro_family='Debian';
                ;;
            *'Mint'*)
                distro_name='Mint';
                distro_family='Debian';
                ;;
            *'Linux Lite'*)
                distro_name='Linux Lite';
                distro_family='Debian';
                ;;
            *'Parrot'*)
                distro_name='Parrot';
                distro_family='Debian';
                ;;
            *'Puppy'*)
                distro_name='Puppy Linux';
                distro_family='Debian';
                ;;
            *'Kali'*)
                distro_name='Kali Linux';
                distro_family='Debian';
                ;;
            *'BackBox'*)
                distro_name='BackBox';
                distro_family='Debian';
                ;;
            *'TinyCore'*)
                distro_name='TinyCore';
                distro_family='Debian';
                ;;
            *'Damn Small Linux'*)
                distro_name='Damn Small Linux';
                distro_family='Debian';
                ;;
            *'DSL'*)
                distro_name='Damn Small Linux';
                distro_family='Debian';
                ;;
            *'Linspire'*)
                distro_name='Linspire';
                distro_family='Debian';
                ;;

            # Arch Distros
            *'BlackArch'*)
                distro_name='BlackArch';
                distro_family='Arch';
                ;;
            *'Arch'*)
                distro_name='Arch';
                distro_family='Arch';
                ;;
            *'Antergos'*)
                distro_name='Antergos';
                distro_family='Arch';
                ;;
            *'Aros'*)
                distro_name='Aros';
                distro_family='Arch';
                ;;
            *'Artix'*)
                distro_name='Artix';
                distro_family='Arch';
                ;;
            *'Bloop'*)
                distro_name='Bloop';
                distro_family='Arch';
                ;;
            *'Centauri'*)
                distro_name='Centauri';
                distro_family='Arch';
                ;;
            *'CrunchBang'*)
                distro_name='CrunchBang';
                distro_family='Arch';
                ;;
            *'Dbolt'*)
                distro_name='Dbolt';
                distro_family='Arch';
                ;;
            *'Tumbleweed'*)
                distro_name='Tumbleweed';
                distro_family='Arch';
                ;;
            *'Elive'*)
                distro_name='Elive';
                distro_family='Arch';
                ;;
            *'Funtoo'*)
                distro_name='Funtoo';
                distro_family='Arch';
                ;;
            *'GalliumOS'*)
                distro_name='GalliumOS';
                distro_family='Arch';
                ;;
            *'Garuda'*)
                distro_name='Garuda';
                distro_family='Arch';
                ;;
            *'Gentoo'*)
                distro_name='Gentoo';
                distro_family='Arch';
                ;;
            *'Guix System'*)
                distro_name='Guix System';
                distro_family='Arch';
                ;;
            *'HPCS'*)
                distro_name='HPCS Linux';
                distro_family='Arch';
                ;;
            *'KDE neon'*)
                distro_name='KDE neon';
                distro_family='Arch';
                ;;
            *'LMDE'*)
                distro_name='LMDE';
                distro_family='Arch';
                ;;
            *'Manjaro'*)
                distro_name='Manjaro';
                distro_family='Arch';
                ;;
            *'Morphix'*)
                distro_name='Morphix';
                distro_family='Arch';
                ;;
            *'NixOS'*)
                distro_name='NixOS';
                distro_family='Arch';
                ;;
            *'OpenMandriva'*)
                distro_name='OpenMandriva';
                distro_family='Arch';
                ;;
            *'Pardus'*)
                distro_name='Pardus';
                distro_family='Arch';
                ;;
            *'PCLinuxOS'*)
                distro_name='PCLinuxOS';
                distro_family='Arch';
                ;;
            *'Q4OS'*)
                distro_name='Q4OS';
                distro_family='Arch';
                ;;
            *'Raspbian'*)
                distro_name='Raspbian';
                distro_family='Arch';
                ;;
            *'Sabayon'*)
                distro_name='Sabayon';
                distro_family='Arch';
                ;;
            *'Slackware'*)
                distro_name='Slackware';
                distro_family='Arch';
                ;;
            *'Trisquel'*)
                distro_name='Trisquel';
                distro_family='Arch';
                ;;
            *'Void'*)
                distro_name='Void Linux';
                distro_family='Arch';
                ;;

            # Fedora Distros
            *'Fedora'*)
                distro_name='Fedora';
                distro_family='Fedora';
                ;;
            *'CentOS'*)
                distro_name='CentOS';
                distro_family='Fedora';
                ;;
            *'Red Hat Enterprise Linux'*)
                distro_name='Red Hat Enterprise Linux';
                distro_family='Fedora';
                ;;
            *'RHEL'*)
                distro_name='Red Hat Enterprise Linux';
                distro_family='Fedora';
                ;;
            *'Scientific'*)
                distro_name='Scientific';
                distro_family='Fedora';
                ;;
            *'SUSE'*)
                distro_name='SUSE';
                distro_family='Fedora';
                ;;
            *'Oracle'*)
                distro_name='Oracle Linux';
                distro_family='Fedora';
                ;;
            *'AlmaLinux'*)
                distro_name='L';
                distro_family='Fedora';
                ;;
            *'Rocky'*)
                distro_name='Rocky Linux';
                distro_family='Fedora';
                ;;
            
            *)
                distro_name='Unknown';
                distro_family='Unknown';
                ;;
        esac

        # Return Either Distro or Family
        if [ "$__family" = "" ]
        then

            return_value="$distro_name";
        else

            return_value="$distro_family";
        fi
    else

        return_value='Unknown';
    fi

    ##
    # Return
    ##
    echo "$return_value";
}

##########
# Which Distro Family: Determines which Linux distribution family the user is using
##########
which_distro_family()
{

    ##
    # Definitions
    ##
    local return_value;
    
    return_value=$(which_distro 'true');

    ##
    # Return
    ##
    echo "$return_value";
}