#!/bin/bash

echo "All args passed to script: $@"
echo "Number of args passed: $#"
echo "Script name: $0"
echo "Present directory: $PWD"
echo "who is running: $USER"
echo "Home directory of current user : $HOME"
echo "PID of this script: $$"
sleep 10 &
echo "PID of recently executed background process: $!"
echo "All args passed to script: $*"