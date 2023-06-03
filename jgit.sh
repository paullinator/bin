#!/bin/bash

#
# Replacement for Git when running under Jenkins to swap out usage of `git fetch` for `git clone`
# when cloning repos to prevent 10min timeout due to slow fetch
#

set -e

if [ "$1" == "init" ]; then
    mkdir -p $2
    exit 0
fi

if [ "$1" != "fetch" ]; then
    git "$@"
    exit 0
fi

#!/bin/bash

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "No arguments provided. Please provide the 'git fetch' arguments."
    exit 1
fi

# Find the repository URL and refspec (assumed to be after '--')
for (( i=1; i<=$#; i++ )); do
    if [ ${!i} = "--" ]; then
        # The next argument is the repository URL
        ((i++))
        repository=${!i}

        # The last argument is the refspec
        ((i=$#))
        refspec=${!i}
        break
    fi
done

# Check if the repository URL and refspec were found
if [ -z "$repository" ]; then
    echo "Repository URL not found in the provided arguments."
    exit 1
fi

if [ -z "$refspec" ]; then
    echo "Refspec not found in the provided arguments."
    exit 1
fi

# Extract the branch name from the refspec
branch=${refspec#*refs/heads/}
branch=${branch%%:*}

# Run the 'git clone' command with the extracted repository URL and branch
git clone --depth 1 -b "$branch" "$repository" ./
