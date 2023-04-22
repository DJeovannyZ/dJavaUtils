#!/bin/bash
source /home/djeovanz/scriptsUtils/dJavaUtils/core/createProjects/createJavaFile.sh
function createWebApp() {
    projectName="$1"
    groupId="$2"
    

    rutaDivid=($(echo "$groupId" | tr '.' ' '))  # dividir la cadena en una matriz
    
    ruta=""
    for i in "${rutaDivid[@]}"; do  # recorrer cada elemento de la matriz
        ruta="$ruta/$i"  # agregar el elemento a la ruta
    done
    ruta="${ruta:1}"  # eliminar la primera barra diagonal
    mkdir -p "$defaultPath/$projectName/src/main/java/$ruta/controller"
    fileJava="$defaultPath/$projectName/src/main/java/$ruta/controller/Controller.java"
    touch "$fileJava"
    mkdir -p "$defaultPath/$projectName/src/main/java/$ruta/model"
    createJava "$groupId.controller" "$fileJava"

    filePom="$defaultPath/$projectName/pom.xml"
    fileWeb="$defaultPath/$projectName/src/main/webapp/WEB-INF/"
    fileIndex="$defaultPath/$projectName/src/main/webapp/"
    metaInf="$defaultPath/$projectName/src/main/webapp/META-INF"
    mkdir -p "$metaInf"
    
    cp -rf "$HOME/.config/dJavaUtils/web.xml" "$fileWeb"
    cp -rf "$HOME/.config/dJavaUtils/index.jsp" "$fileIndex"

    #servlets dependencies
    # groupIds=("javax.servlet" "javax.servlet" "taglibs" "org.apache.tomcat.embed")
    # artifactIds=("javax.servlet-api" "jstl" "standard" "tomcat-embed-core")
    # versions=("4.0.1" "1.2" "1.1.2" "9.0.50")
    # scope=("provided" "compile" "compile" "provided")

    groupIds=("org.glassfish.web" "jakarta.servlet" "jakarta.servlet.jsp.jstl" )
    artifactIds=("jakarta.servlet.jsp.jstl" "jakarta.servlet-api" "jakarta.servlet.jsp.jstl-api" )
    versions=("3.0.1" "5.0.0" "3.0.0")
    scope=("" "provided" "" )

    for i in "${!groupIds[@]}"
    do
        xmlstarlet edit --inplace \
        -N x="http://maven.apache.org/POM/4.0.0" \
        --subnode "/x:project/x:dependencies" \
        --type elem -n dependency \
        --subnode "//dependency[last()]" \
        --type elem -n groupId -v "${groupIds[$i]}" \
        --subnode "//dependency[last()]" \
        --type elem -n artifactId -v "${artifactIds[$i]}" \
        --subnode "//dependency[last()]" \
        --type elem -n version -v "${versions[$i]}" \
        --subnode "//dependency[last()]" \
        --type elem -n scope -v "${scope[$i]}" "$filePom"
    done
    # Array de plugins
    # pluginGroupIds=("org.apache.tomcat.maven" "org.apache.maven.plugins")
    # pluginArtifactIds=("tomcat7-maven-plugin" "maven-war-plugin")
    # pluginVersions=("2.2" "3.3.1")

    # # Agregar plugins
    # for i in "${!pluginGroupIds[@]}"
    # do
    #     xmlstarlet edit --inplace \
    #     -N x="http://maven.apache.org/POM/4.0.0" \
    #     --subnode "/x:project/x:build/x:pluginManagement/x:plugins" \
    #     --type elem -n plugin \
    #     --subnode "//plugin[last()]" \
    #     --type elem -n groupId -v "${pluginGroupIds[$i]}" \
    #     --subnode "//plugin[last()]" \
    #     --type elem -n artifactId -v "${pluginArtifactIds[$i]}" \
    #     --subnode "//plugin[last()]" \
    #     --type elem -n version -v "${pluginVersions[$i]}" "$filePom"
    # done
}
