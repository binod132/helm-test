#!/bin/bash
helm install $1 $1/ -f common.yaml -f secret.yaml -f $1/values/dev.yaml $2 -n qa-helm