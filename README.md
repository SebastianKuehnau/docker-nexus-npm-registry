# docker-nexus-npm-registry
This repository creates a local npm registry provided by nexus running in a local docker image and it should help to reduce internet traffic and built time by downloading redundant npm dependencies.

It contains an extension of the **Dockerfile** of [Nexus3](https://github.com/sonatype/docker-nexus) for [Docker](https://www.docker.com/)'s.


### Base Docker Image

* [nexus:latest](https://hub.docker.com/r/sonatype/nexus)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download the [docker-nexus-npm-registry image](https://hub.docker.com/r/sebak/nexus_npm_registry_vaadin) from public [Docker Hub Registry](https://registry.hub.docker.com/)

    `docker pull sebak/nexus_npm_registry_vaadin`

   or, you can build an image from the given Dockerfile: 
   
    `docker build -t="npm-registry" .`


### Usage

    $ docker run -dit -p 8081:8081 npm-registry

To link npm to your local registry add a configuration to your local npm

    $ npm config set registry http://localhost:8081/repository/npmjs-org/

or add [frontend-maven-plugin](https://repo1.maven.org/maven2/com/github/eirslett/frontend-maven-plugin/) to your project pom. You can find an example project with a proper configuration in the vaadin-example folder.

After setting up the docker image you need to compile a vaadin project on your machine with 
    
    $ mvn install -Pproduction

Beware, if you want to add web-components to the project later, which are not part of the default web-component set, you need to have a internet connection available to download and add them to your local npm-regsitry.

To check the content of the npm registry you can go to [localhost:8081](http://localhost:8081/) and login with username "admin" and password "admin".
