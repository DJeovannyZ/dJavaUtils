#!/bin/bash

function runJava(){
    # obtener ruta absoluta del proyecto
    projectPath=$(realpath "$1")
    
    sourcePath="$projectPath/src/main/java"

    # compilar el proyecto con Maven
    mvn compile -f "$projectPath/pom.xml"

    # encontrar la ruta absoluta del archivo de la clase principal dentro de projectPath
    mainClassFile=$(find "$sourcePath" -type f -name '*.java' -exec grep -l 'public static void main(String\[\] args)' {} \;)

    # encontrar el paquete de la clase principal y el nombre de la clase sin la extensión .java
    packageMainClass=$(grep -o '^\s*package\s\+\(\S\+\)' "$mainClassFile" | sed 's/^\s*package\s\+//' | tr -d ';')
    nameMainClass=$(basename "$mainClassFile" .java)

    # unir el paquete con el nombre de la clase para formar la clase principal completa
    mainClass="${packageMainClass}.${nameMainClass}"

    # ejecutar la clase principal
    java -cp "$projectPath/target/classes:$(echo $projectPath/target/dependency/*.jar | tr ' ' ':')" "$mainClass"
}
