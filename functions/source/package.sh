#!/bin/bash
set -xe

find . -type f -exec chmod 644 {} \;
for dir in CreateSSHKey DeleteBucketContents GitPullS3 ; do
    zip -r -j "$dir.zip" $dir/*
done
