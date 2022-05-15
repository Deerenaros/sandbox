#!/usr/bin/bash

for i in {0..100}; do
	head -c 1024 < /dev/random > /tmp/$i
done

for i in {0..100}; do
	dir=./$(echo $RANDOM | md5sum | cut -d' ' -f1)/$(echo $RANDOM | md5sum | cut -d' ' -f1)/$(echo $RANDOM | md5sum | cut -d' ' -f1)
	mkdir -p $dir
	for j in {0..10}; do
		file=$(echo $RANDOM | md5sum | head -c 10)
		cp /tmp/$(shuf -i 0-100 -n 1) $dir/$file
	done
done
