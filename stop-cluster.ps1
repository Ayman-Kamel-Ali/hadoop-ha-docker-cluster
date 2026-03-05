Write-Host "Forcing YARN to stop..."
foreach ($i in 1..5) { 
    docker exec -u root node0$i pkill -9 -f NodeManager
    docker exec -u root node0$i pkill -9 -f ResourceManager
}

Write-Host "Forcing HDFS to stop..."
foreach ($i in 1..5) { 
    docker exec -u root node0$i pkill -9 -f DataNode
    docker exec -u root node0$i pkill -9 -f NameNode
    docker exec -u root node0$i pkill -9 -f DFSZKFailoverController
    docker exec -u root node0$i pkill -9 -f JournalNode
}

Write-Host "Stopping ZooKeeper..."
foreach ($i in 1..3) { 
    docker exec -u root node0$i bash /shared/apache-zookeeper-3.8.4-bin/bin/zkServer.sh stop 
    docker exec -u root node0$i pkill -9 -f QuorumPeerMain
}

Write-Host "Cleaning up ghost PID files..."
foreach ($i in 1..5) { docker exec -u root node0$i bash -c "rm -f /tmp/hadoop-root-*.pid" }

Write-Host "Shutting down Docker containers..."
docker stop node01 node02 node03 node04 node05

Write-Host "Cluster is fully offline!"
Start-Sleep -Seconds 5
