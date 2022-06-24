#!/bin/bash

docker run --rm -v "$(pwd):/pdf" -u $(id -u):$(id -g) epitechcontent/subject_template $@
