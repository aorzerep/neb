#!/bin/bash

rsync -avr --delete-before --delete --force --ignore-errors --progress /vicepa/ /BACKUP/
