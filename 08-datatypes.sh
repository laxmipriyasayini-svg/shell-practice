#!/bin/bash
NUM1=100
NUM2=200
SUM=$(($NUM1+$NUM2))

echo "Sum is: $SUM"

FRUITS=("Apple" "Banana" "Pomo")

echo "Fruits are: ${FRUITS[@]}"

echo "Fruits are: ${FRUITS[0]}"
echo "Fruits are: ${FRUITS[1]}"
echo "Fruits are: ${FRUITS[2]}"