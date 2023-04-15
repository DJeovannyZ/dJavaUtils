function createMavenProject() {
    read -p "Ingrese el nombre del proyecto: " projectName
    read -p "Ingrese el groupID (por ejemplo, com.example): " groupId
    read -p "Ingrese el artifactid: " artifactId

    echo "Seleccione el tipo de proyecto:"
    echo "1 - quickstart | DEFAULT"
    echo "2 - webapp"
    read -p "Opción: " projectType

    case $projectType in
        1)
            archetype="maven-archetype-quickstart"
    mvn archetype:generate -DgroupId=$groupId -DartifactId=$artifactId -DarchetypeArtifactId=$archetype -DinteractiveMode=false -Dversion=1.0 -Dpackage=$groupId.$artifactId -DarchetypeVersion=1.4 -DarchetypeGroupId=org.apache.maven.archetypes  -DoutputDirectory=$defaultPath
    lvim "$defaultPath/$projectName"
    cd "$defaultPath/$projectName"
    exec zsh
            ;;
        2)
            archetype="maven-archetype-webapp"
    mvn archetype:generate -DgroupId=$groupId -DartifactId=$artifactId -DarchetypeArtifactId=$archetype -DinteractiveMode=false -Dversion=1.0 -Dpackage=$groupId.$artifactId -DarchetypeVersion=1.4 -DarchetypeGroupId=org.apache.maven.archetypes  -DoutputDirectory=$defaultPath
    createWebApp "$projectName"
    lvim "$defaultPath/$projectName"
    cd "$defaultPath/$projectName"
    exec zsh
            ;;
        *)
            archetype="maven-archetype-quickstart"
    mvn archetype:generate -DgroupId=$groupId -DartifactId=$artifactId -DarchetypeArtifactId=$archetype -DinteractiveMode=false -Dversion=1.0 -Dpackage=$groupId.$artifactId -DarchetypeVersion=1.4 -DarchetypeGroupId=org.apache.maven.archetypes  -DoutputDirectory=$defaultPath
    lvim "$defaultPath/$projectName"
    cd "$defaultPath/$projectName"
    exec zsh
            ;;
    esac
}

