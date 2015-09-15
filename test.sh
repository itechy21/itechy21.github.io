#!/bin/bash
echo "shellshock test. If returns vulnerable update bash"
x='() { :;}; echo VULNERABLE' bash -c :
