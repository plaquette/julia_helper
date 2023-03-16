# Remove all stopped containers
docker container prune -f

# Remove <none> images
docker images | awk '/<none>/ {print $3}' | xargs -r docker rmi
