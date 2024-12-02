#!/bin/bash

sudo docker pull debian
echo "Download Complete...."


# Obtain ImageID
imageID=$(sudo docker images -q)
echo "Image ID : $imageID"

# Run the container
sudo docker run -it -d $imageID /bin/bash

# Obtaining container-id
containerID=$(sudo docker ps -q)
echo "Container ID : $containerID"

# Create the user inside the running container
sudo docker exec -it $containerID /bin/bash -c "apt update && apt install curl wget sudo nano -y && useradd -m -s /bin/bash koushick && echo 'koushick:toor' | chpasswd"

echo "User Created"

# Log in as the new user
echo "Logging is as new user"
sudo docker exec -it --user koushick $containerID /bin/bash -c "cd ~ && exec bash"





