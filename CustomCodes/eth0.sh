#!/bin/bash

ifconfig | grep 192.168.0.* | awk '{print $2}'
