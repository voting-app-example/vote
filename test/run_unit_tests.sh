#!/bin/sh

coverage run -m unittest discover -s test
coverage xml -o coverage/coverage.xml