#!/bin/bash

function deployJava() {
    # obtener ruta absoluta del proyecto
    projectPath=$(realpath "$1")

    brave http://localhost:9090 &
    mvn clean compile tomcat7:run -DprojectPath=$projectPath

}
