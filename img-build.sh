echo '===> Building docker image...'

GIT_BRANCH=$(git name-rev --name-only HEAD | sed "s/~.*//")
GIT_COMMIT=$(git rev-parse HEAD)
GIT_COMMIT_SHORT=$(echo $GIT_COMMIT | head -c 8)
GIT_DIRTY='false'
BUILD_CREATOR=$(git config user.email)
BUILD_NUMBER="${BUILD_NUMBER-0}"
# Whether the repo has uncommitted changes
if [[ $(git status -s) ]]; then
	    GIT_DIRTY='true'
    fi

    docker build \
        -q \
        -t quay.io/myco/servicename:latest \
        -t quay.io/myco/servicename:"$GIT_COMMIT_SHORT" 
        --build-arg GIT_BRANCH="$GIT_BRANCH" \
        --build-arg GIT_COMMIT="$GIT_COMMIT" 
	--build-arg GIT_DIRTY="$GIT_DIRTY" \
	--build-arg BUILD_CREATOR="$BUILD_CREATOR" \
        --build-arg BUILD_NUMBER="$BUILD_NUMBER" \
        .

echo "Done"
echo "Push to dockerhub using:"
echo "  docker push votuids/votuids-repo:latest"
echo "  docker push votuids/votuids-repo:$GIT_COMMIT_SHORT"
