#!/bin/bash

function deployJava() {
    # obtener ruta absoluta del proyecto
    projectPath=$(realpath "$1")
    # dirName=$(dirname "$projectPath")
    projectName=$(basename "$projectPath")
    echo "nombre del proyecto: "
    echo "$projectName"

    brave http://localhost:8080/"$projectName" &
    # mvn clean compile tomcat7:run -DprojectPath=$projectPath
    mvn clean package -DprojectPath="$projectPath"

    rm -rf "/var/lib/tomcat10/webapps/$projectName.war"
    rm -rf "/var/lib/tomcat10/webapps/$projectName"

    cp "$projectPath/target/$projectName.war" "/var/lib/tomcat10/webapps/"

    /usr/share/tomcat10/bin/catalina.sh run
    
    rm -rf "/var/lib/tomcat10/webapps/$projectName.war"
    rm -rf "/var/lib/tomcat10/webapps/$projectName"

}
