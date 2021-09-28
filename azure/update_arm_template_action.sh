#!/usr/bin/env bash

# choose logicapp to update
SELECTION=$(jq '.resources[].tags.displayName' azuredeploy.json | fzf)
echo "$SELECTION"

# TODO get action from clipholder
UPDATED_ACTION=$(cat action.json)

# overwrite selection with new action
jq ".resources |= map((select(.tags.displayName==$SELECTION) | .properties.definition.actions = $UPDATED_ACTION) // .)" azuredeploy.json > temp.json
mv temp.json azuredeploy.json

# TODO run replacement script over arm template



