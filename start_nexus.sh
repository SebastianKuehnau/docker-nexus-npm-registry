#!/bin/bash

sh /tmp/configure_nexus.sh &
sh ./opt/sonatype/start-nexus-repository-manager.sh
