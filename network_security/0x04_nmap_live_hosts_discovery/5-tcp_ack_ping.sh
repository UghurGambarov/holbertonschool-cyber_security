#!/bin/bash
sudo nmap -PA -sn -p 22,80,443 $1
