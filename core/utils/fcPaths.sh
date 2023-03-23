#!/bin/bash


# Function to set default path
function setDefaultPath {
  
  # Check if all parameters are provided
  if [ "$#" -ne 1 ]; then
    echo "Error: to setDefaultPath expecify the path of workspace. use dJavaUtils --help for more information."
    return 1
  fi
  # Get the absolute path of the directory
  dir=$(readlink -f "$1")

  # Check if dJavaUtils directory exists
  if [ ! -d "$HOME/.config/dJavaUtils/" ]; then
    mkdir $HOME/.config/dJavaUtils/
  fi

  # Check if default path file exists
  if [ ! -f "$HOME/.config/uniUtils/default_path.txt" ]; then
    touch $HOME/.config/dJavaUtils/default_path.txt
  fi

  # Write default path to file
  echo "$dir" > $HOME/.config/dJavaUtils/default_path.txt
  echo "Default path set to: $dir"
}


# Function to check if default path file exists and create it if not
function checkDefaultPath {
  # Check if dJavaUtils directory exists
  if [ ! -d "$HOME/.config/dJavaUtils/" ]; then
    mkdir $HOME/.config/dJavaUtils/
  fi

  # Check if default path file exists
  if [ ! -f "$HOME/.config/dJavaUtils/default_path.txt" ]; then
    touch $HOME/.config/dJavaUtils/default_path.txt
  fi

  
  # Chequeamos si existen los archivos y los copiamos si es necesario
  if [ ! -f "$HOME/.config/dJavaUtils/web.xml" ]; then
  # Obtenemos la ruta del script "fcPaths.sh"
  script_path="$(realpath "${BASH_SOURCE[0]}")"
  script_dir="$(dirname "$script_path")"
  cd "$script_dir"
  cd ../../resources/
      echo "Copiando archivo web.xml"
      cp "web.xml" "$HOME/.config/dJavaUtils/"
  fi

  if [ ! -f "$HOME/.config/dJavaUtils/index.jsp" ]; then
  # Obtenemos la ruta del script "fcPaths.sh"
  script_path="$(realpath "${BASH_SOURCE[0]}")"
  script_dir="$(dirname "$script_path")"
  cd "$script_dir"
  cd ../../resources/
      echo "Copiando archivo web.xml"
      cp "index.jsp" "$HOME/.config/dJavaUtils/"
  fi

  # Check if default path file has a path set
  if [ ! -s "$HOME/.config/dJavaUtils/default_path.txt" ]; then
    echo "Default path file is empty. Set default path using 'dJavaUtils --setDefaultPath <path>'"
  fi
}
