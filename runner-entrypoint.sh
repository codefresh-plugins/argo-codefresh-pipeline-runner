#!/bin/bash


codefresh auth get-contexts

echo "Create context"

codefresh auth create-context context --api-key $CF_API_KEY

echo "Use context"
codefresh auth use-context context


if [ -n "$CF_BRANCH" ]
then
  BRANCH=$CF_BRANCH
fi

echo "Execute pipeline with branch $BRANCH"

if [ -n "$TRIGGER_NAME" ]
then
	codefresh run $PIPELINE_NAME --trigger=$TRIGGER_NAME --branch=$BRANCH
else
	codefresh run $PIPELINE_NAME --branch=$BRANCH
fi

60def8cef632436315c40e02.6551dd5fbb044c776493908770786bcd
