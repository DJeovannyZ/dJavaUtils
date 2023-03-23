#!/bin/bash

function createWebApp() {
    projectName="$1"
    filePom="$defaultPath/$projectName/pom.xml"
    fileWeb="$defaultPath/$projectName/src/main/webapp/WEB-INF/"
    fileIndex="$defaultPath/$projectName/src/main/webapp/"
    
    cp -rf "$HOME/.config/dJavaUtils/web.xml" "$fileWeb"
    cp -rf "$HOME/.config/dJavaUtils/index.jsp" "$fileIndex"

    mkdir -p "$defaultPath/$projectName/src/main/java/"

    groupIds=("javax.servlet" "javax.servlet" "taglibs" "org.apache.tomcat.embed")
    artifactIds=("javax.servlet-api" "jstl" "standard" "tomcat-embed-core")
    versions=("4.0.1" "1.2" "1.1.2" "9.0.50")
    scope=("provided" "compile" "compile" "provided")

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
    pluginGroupIds=("org.apache.tomcat.maven" "org.apache.maven.plugins")
    pluginArtifactIds=("tomcat7-maven-plugin" "maven-war-plugin")
    pluginVersions=("2.2" "3.3.1")

    # Agregar plugins
    for i in "${!pluginGroupIds[@]}"
    do
        xmlstarlet edit --inplace \
        -N x="http://maven.apache.org/POM/4.0.0" \
        --subnode "/x:project/x:build/x:pluginManagement/x:plugins" \
        --type elem -n plugin \
        --subnode "//plugin[last()]" \
        --type elem -n groupId -v "${pluginGroupIds[$i]}" \
        --subnode "//plugin[last()]" \
        --type elem -n artifactId -v "${pluginArtifactIds[$i]}" \
        --subnode "//plugin[last()]" \
        --type elem -n version -v "${pluginVersions[$i]}" "$filePom"
    done

    xmlstarlet edit --inplace \
    -N x="http://maven.apache.org/POM/4.0.0" \
    --subnode "//x:plugin[x:groupId='org.apache.tomcat.maven' and x:artifactId='tomcat7-maven-plugin']" \
    --type elem -n configuration \
    --subnode "//x:plugin[x:groupId='org.apache.tomcat.maven' and x:artifactId='tomcat7-maven-plugin']/configuration" \
    --type elem -n port -v "9090" \
    --subnode "//x:plugin[x:groupId='org.apache.tomcat.maven' and x:artifactId='tomcat7-maven-plugin']/configuration" \
    --type elem -n path -v "/" \
    --subnode "//x:plugin[x:groupId='org.apache.tomcat.maven' and x:artifactId='tomcat7-maven-plugin']/configuration" \
    --type elem -n contextReloadable -v "true" "$filePom"
}
