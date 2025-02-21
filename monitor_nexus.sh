#!/usr/bin/expect

# List of container names
set container_list {"nexus-docker-1" "nexus-docker-2" "nexus-docker-3" "nexus-docker-4"}

# Loop through each container and check if it's stopped
foreach container_name $container_list {
    set container_id [exec docker ps -aq -f "name=$container_name"]
    set status [exec docker inspect --format "{{.State.Status}}" $container_name]

    if { $status ne "running" } {
        puts "Restarting $container_name..."
        
        # Stop and remove the container if it exists
        if { $container_id ne "" } {
            exec docker stop $container_name
            exec docker rm $container_name
        }

        # Run the new container with the same name and pass "y" automatically
        spawn docker run -it --name $container_name -v /root/nexus-data/$container_name:/root/.nexus $container_name
        expect "y/n"
        send "y\r"
        interact
    }
}
