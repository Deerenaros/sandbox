#!/usr/bin/bash

for i in {0..100}; do
	dir=./$(echo $RANDOM | md5sum | cut -d' ' -f1 | sed "s/d/\//g")
	mkdir -p $dir
	for j in {0..10}; do
		file=$(echo $RANDOM | md5sum | head -c 10)
		head -c 1024 < /dev/random > $dir/$file
	done
done
