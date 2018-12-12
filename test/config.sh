#!/bin/bash
set -e

testAlias+=(
	[cadexd:trusty]='cadexd'
)

imageTests+=(
	[cadexd]='
		rpcpassword
	'
)
