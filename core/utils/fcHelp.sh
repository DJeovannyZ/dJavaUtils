#!/bin/bash

function showHelp() {
    echo "Uso: dJavaUtils comando [argumento]"

    echo ""
    echo "Comandos:"
    echo "  --createMavenProject | -c  Crea un nuevo proyecto Maven en el directorio por defecto"
    echo "                             utilizando el arquetipo especificado."
    echo ""
    echo "  --runJava | -r             Compila el proyecto y ejecuta la clase principal del"
    echo "                             mismo."
    echo ""
    echo "  --injectDependencies | -i  Descarga todas las dependencias de un proyecto."
    echo ""
    echo "  --setDefaultPath | -s      Establece la ruta predeterminada donde se crearán los"
    echo "                             proyectos de Maven."
    echo ""
    echo "  --help | -h            Muestra esta ayuda."
}

