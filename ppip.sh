#!/bin/bash

function ppip () {

  function install () {
    ALIAS_PKG_NAME=""
    PKG=""
    while test $# -gt 0; do
      case "$1" in
        -a | --as | --alias)
          shift
          ALIAS_PKG_NAME=$1
          shift
          ;;
        *)
          PKG=$1
          shift
          ;;
      esac
    done

    if [ -z "$PKG" ]
      then
        echo "No package supplied"
        return 1
    fi

    if [ -z "$ALIAS_PKG_NAME" ]
      then
        echo "installing $PKG"
        echo "running: pip install $PKG"
        pip install $PKG
        return 0
    fi

    echo "installing $PKG as $ALIAS_PKG_NAME"
    SITE_PACKAGES_DIR=$(python -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])')
    echo "running: pip install $PKG --target $SITE_PACKAGES_DIR/$ALIAS_PKG_NAME"
    pip install $PKG --target $SITE_PACKAGES_DIR/$ALIAS_PKG_NAME
  }

  function uninstall () {
    ALIAS_PKG_NAME=""
    PKG=""
    while test $# -gt 0; do
      case "$1" in
        -a | --as | --alias)
          shift
          ALIAS_PKG_NAME=$1
          shift
          ;;
        *)
          PKG=$1
          shift
          ;;
      esac
    done

    if [ -n "$PKG" ]
      then
        echo "uninstalling $PKG"
        echo "running: pip uninstall $PKG"
        pip uninstall $PKG
        return 0
    fi

    if [ -n "$ALIAS_PKG_NAME" ]
      then
        echo "uninstalling $ALIAS_PKG_NAME"
        SITE_PACKAGES_DIR=$(python -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])')
        echo "in 5 seconds running: rm -rf $SITE_PACKAGES_DIR/$ALIAS_PKG_NAME"
        sleep 5
        rm -rf $SITE_PACKAGES_DIR/$ALIAS_PKG_NAME
        return 0
    fi

    echo "No package supplied"
    return 1
  }

  function install-requirements () {
    REQUIREMENTS_FILE=$1
    if [ -z "$REQUIREMENTS_FILE" ]
      then
        echo "No requirements file supplied"
        return 1
    fi

    SITE_PACKAGES_DIR=$(python -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])')
    echo "installing requirements from $REQUIREMENTS_FILE to $SITE_PACKAGES_DIR"
    echo "in 3 seconds"
    sleep 3

    while IFS="" read -r p || [ -n "$p" ]
    do
      echo "running: ppip install $p"
      eval "ppip install $p"
    done <$REQUIREMENTS_FILE
  }

  function print_help() {
    echo "Usage: $0 [COMMAND]"
    echo "Commands:"
    echo " install         ppip install PKG --as PKG_ALIAS"
    echo " uninstall       ppip uninstall PKG_ALIAS"
    echo " install-requirements    ppip install-requirements REQUIREMENTS_FILE"
  }

  while test $# -gt 0; do
    case "$1" in
      install)
        shift
        install $@
        return 0
        ;;
      uninstall)
        shift
        uninstall $@
        return 0
        ;;
      install-requirements)
        shift
        install-requirements $@
        return 0
        ;;
      -h | --help)
        print_help
        return 0
        ;;
      *)
        echo "Invalid option: $1"
        print_help
        return 1
        ;;
    esac
  done

}
