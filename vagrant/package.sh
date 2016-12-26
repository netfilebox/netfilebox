#!/bin/bash
rm package.box
vagrant package --base NetFileBox
vagrant box add --force netfilebox/NetFileBox package.box
