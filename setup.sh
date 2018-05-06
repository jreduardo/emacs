#!/bin/bash

#----------------------------------------------------------------------
# Welcome message.

cat << EOF
------------------------------------------------------------------------

  This will guide you to install GNU Emacs, his friends and
  additional files to have, at least, a small part of the all power that
  GNU Emacs has. Press ENTER to continue.

------------------------------------------------------------------------
EOF

#----------------------------------------------------------------------
# Install Emacs.

function installEmacs {

    if which emacs >/dev/null
    then
        MSG="$(emacs --version | head -n 1) is installed. Do you want reinstall it? [y]es/[n]o"
        echo; echo
    else
        MSG="GNU Emacs isn't installed. Do you want install it? [y]es/[n]o"
        echo; echo
    fi

    echo ------------------------------------------------------------
    echo "$MSG"
    read opcao
    case $opcao in
        y )
            echo "Running \"apt-get build-dep emacs\"."
            sudo apt-get build-dep emacs -y
            echo
            echo "Running \"apt-get install emacs\"."
            sudo apt-get install emacs -y
            echo; echo
            ;;
        * )
            echo "Skipped."; echo; echo
            ;;
    esac

    echo ------------------------------------------------------------
    echo "Install `emacs-goodies-el` (a set of useful packages)? [y]es/[n]o"
    read opcao
    case $opcao in
        y )
            echo "Installing `emacs-goodies-el`."
            sudo apt-get install emacs-goodies-el -y
            echo; echo
            ;;
        * )
            echo "Skipped."; echo; echo
            ;;
    esac

    echo ------------------------------------------------------------
    echo "Install `virtualenv` (Needed for Python auto complete)? [y]es/[n]o"
    read opcao
    case $opcao in
        y )
            echo "Installing `virtualenv`."
            sudo apt-get install virtualenv -y
            echo; echo
            ;;
        * )
            echo "Skipped."; echo; echo
            ;;
    esac
}

#----------------------------------------------------------------------
# Move emacs init files and extentions.

function moveEmacsFiles {
    cp -v init.el ~/.emacs.d/init.el
    cp -v funcs.el ~/.emacs.d/lisp/
}

function createEmacsFiles {

    emacsddir="$HOME/.emacs.d/lisp/"
    if [ ! -d "$emacsddir" ]
    then
        echo ------------------------------------------------------------
        echo "$emacsddir doesn't exists. It will be created."
        mkdir -v -p $HOME/.emacs.d/lisp/
        echo; echo
    else
        echo ------------------------------------------------------------
        echo "$emacsddir exists."
        echo; echo
    fi

    dotemacs="$HOME/.emacs.d/init.el"
    if [ -f "$dotemacs" ]
    then
        echo ------------------------------------------------------------
        echo "~/.emacs.d/init.el file found."
        echo "Do you want replace it? [y]es/[q]uit"
        read opcao
        case $opcao in
            y )
                # cd $HOME/Projects/emacs/
		moveEmacsFiles
                echo; echo
                ;;
            * )
                echo "Skipped."; echo; echo
                ;;
        esac
    else
        echo ------------------------------------------------------------
        echo "~/.emacs.d/init.el file not found."
        echo "It will be created."
        # cd $HOME/Projects/emacs/
	moveEmacsFiles
        echo; echo
    fi
}

#----------------------------------------------------------------------
# Send line or region for shell buffer.

function downloadEssh {
    wget -N 'http://www.emacswiki.org/emacs/download/essh.el' -P $HOME/.emacs.d/lisp/
}

function createEssh {
    file="$HOME/.emacs.d/lisp/essh.el"
    if [ -f "$file" ]
    then
        echo ------------------------------------------------------------
        echo "~/.emacs.d/lisp/essh.el file found."
        echo "Do you want update it? [y]es/[q]uit"
        read opcao
        case $opcao in
            y )
		downloadEssh
                ;;
            * )
                echo "Skipped."; echo; echo
                ;;
        esac
    else
        echo ------------------------------------------------------------
        echo "~/.emacs.d/lisp/essh.el file not found."
        echo "It will be created."
	downloadEssh
        echo; echo
    fi
}

#----------------------------------------------------------------------
# Bookmark+.

function downloadBookmark {
    # wget -N 'http://www.emacswiki.org/emacs/download/essh.el' -P $HOME/.emacs.d/lisp/
    # git clone https://github.com/emacsmirror/bookmark-plus.git ~/.emacs.d/elpa/bookmark+
    wget -N https://github.com/emacsmirror/bookmark-plus/archive/master.zip -P $HOME/.emacs.d/elpa/
    unzip $HOME/.emacs.d/elpa/master.zip -d $HOME/.emacs.d/elpa/
    mv -v $HOME/.emacs.d/elpa/bookmark-plus-master $HOME/.emacs.d/elpa/bookmark+
    rm -v $HOME/.emacs.d/elpa/master.zip
}

function createBookmark {
    hasBookmark=$(ls $HOME/.emacs.d/elpa/ | grep 'bookmark+')
    if [ "$hasBookmark" == "" ];
    then
        echo ------------------------------------------------------------
        echo "~/.emacs.d/lisp/bookmark+ folder not found."
        echo "Do you want download and update it? [y]es/[q]uit"
        read opcao
        case $opcao in
            y )
		downloadBookmark
                ;;
            * )
                echo "Skipped."; echo; echo
                ;;
        esac
    else
        echo ------------------------------------------------------------
        echo "~/.emacs.d/lisp/bookmark+ folder found."
        echo "Do you want download and update it? [y]es/[q]uit"
        read opcao
        case $opcao in
            y )
		downloadBookmark
                ;;
            * )
                echo "Skipped."; echo; echo
                ;;
        esac
    fi

}

#-----------------------------------------------------------------------
# Electric-spacings.

function downloadElectricSpacing {
    echo "Do you want download it? [y]es/[q]uit"
    read opcao
    case $opcao in
	y )
	    wget -N 'https://raw.githubusercontent.com/walmes/electric-spacing/master/electric-spacing-r.el' -P $HOME/.emacs.d/lisp/
	    ;;
	* )
	    echo "Skipped."; echo; echo
	    break
	    ;;
    esac
}

function createElectricSpacing {
    read opcao
    case $opcao in
        y )
            if [ ! -f ~/Projects/electric-spacing/electric-spacing-r.el ]
            then
                echo "File electric-spacing-r.el not found!"
		downloadElectricSpacing
            else
                cp -v ~/Projects/electric-spacing/electric-spacing-r.el \
                   ~/.emacs.d/lisp/electric-spacing-r.el
            fi
            ;;
        * )
            echo "Skipped."; echo; echo
            ;;
    esac
}

function moveElectricSpacing {
    file="$HOME/.emacs.d/lisp/electric-spacing-r.el"
    if [ -f "$file" ]
    then
        echo ------------------------------------------------------------
        echo "~/.emacs.d/lisp/electric-spacings-r.el file found."
        echo "Do you want update it? [y]es/[q]uit"
	createElectricSpacing
    else
        echo ------------------------------------------------------------
        echo "~/.emacs.d/lisp/electric-spacing-r.el file not found."
        echo "It will be created."
	createElectricSpacing
    fi
}

#----------------------------------------------------------------------
# Cicle among options.

while :
do
    printf "\nMenu of options\n\n"
    printf "  1. Install GNU Emacs\n"
    printf "  2. Move init.el and funcs.el.\n"
    printf "  3. Download and move essh.el.\n"
    printf "  4. Download or move electric-spacing-r.el.\n"
    printf "  5. Download bookmark+.\n"
    printf "  6. Open files with meld.\n"
    printf "  q. Quit.\n\n"

    read -sn1 -p "Select (1, 2, 3, 4, 5, 6, q): " input
    echo

    case $input in
        1) installEmacs ;;
        2) createEmacsFiles ;;
        3) createEssh ;;
        4) moveElectricSpacing ;;
        5) createBookmark ;;
        6) meld init.el ~/.emacs.d/init.el && meld funcs.el ~/.emacs.d/lisp/funcs.el;;
        q) break ;;
        *) echo "Invalid seletion" ;;
    esac
done

#----------------------------------------------------------------------
# End of session.

cat << EOF

------------------------------------------------------------------------

  You have finished the installation of GNU Emacs. Congratulations!

------------------------------------------------------------------------
EOF
