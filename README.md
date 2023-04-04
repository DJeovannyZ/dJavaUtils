# DJavaUtils

This is a Java utility script for creating Java projects using Maven, running projects, and deploying projects on Tomcat for development.

## Dependencies: 
- Maven 
- Tomcat
- xmlstarlet

## Usage:

dJavaUtils command [argument]
--createMavenProject or -c: Creates a new Maven project in the default directory using the specified archetype.

--runJava or -r: Compiles the project and runs its main class.

--injectDependencies or -i: Downloads all the dependencies of a project.

--setDefaultPath or -s: Sets the default path where Maven projects will be created.

--help or -h: Displays help information.
