#!/bin/bash
set -eu

# ensure the bucket is passed on the command line
if [ $# -ne 1 ] ; then
    echo "Usage: $0 <name_of_your_s3_bucket>" > /dev/stderr
    exit 1
fi

set -x
DEST_BUCKET="$1"

# ensure permissions will not be an issue once zip is extracted on the lambda side
find . -type f -exec chmod 644 {} \;

# for each source directory, create the lambda zip and upload it
for dir in CreateSSHKey DeleteBucketContents GitPullS3 ; do
    zip -r -j "$dir.zip" $dir/*
    aws s3 cp "$dir.zip" "$DEST_BUCKET/quickstart-git2s3/functions/packages/$dir/lambda.zip"
    rm "$dir.zip"
done

# paths within s3 bucket that are expected by cloudformation template
# quickstart-git2s3/functions/packages/CreateSSHKey/lambda.zip
# quickstart-git2s3/functions/packages/DeleteBucketContents/lambda.zip
# quickstart-git2s3/functions/packages/GitPullS3/lambda.zip
