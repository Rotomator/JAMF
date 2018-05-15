#!/bin/bash
#This script will rebuild the Fusion drive on the Deep Freeze Macs
diskutil eraseDisk JHFS+ SSD disk0
diskutil eraseDisk JHFS+ HDD disk1
diskutil cs create "Macintosh HD" disk0 disk1
diskutil cs createVolume "Macintosh HD" JHFS+ "Macintosh HD" 100%
