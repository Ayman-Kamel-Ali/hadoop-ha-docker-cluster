Write-Host "Waking up Docker containers..."
docker start node01 node02 node03 node04 node05
Start-Sleep -Seconds 5

Write-Host "Starting ZooKeeper..."
foreach ($i in 1..3) { docker exec -u root node0$i bash /shared/apache-zookeeper-3.8.4-bin/bin/zkServer.sh start }
Start-Sleep -Seconds 5

Write-Host "Starting HDFS..."
foreach ($i in 1..3) { docker exec -u root node0$i bash -c "/shared/hadoop-3.4.2/bin/hdfs --daemon start journalnode" }
foreach ($i in 1..2) { 
    docker exec -u root node0$i bash -c "/shared/hadoop-3.4.2/bin/hdfs --daemon start namenode"
    docker exec -u root node0$i bash -c "/shared/hadoop-3.4.2/bin/hdfs --daemon start zkfc"
}
foreach ($i in 3..5) { docker exec -u root node0$i bash -c "/shared/hadoop-3.4.2/bin/hdfs --daemon start datanode" }

Write-Host "Starting YARN..."
foreach ($i in 1..2) { docker exec -u root node0$i bash -c "/shared/hadoop-3.4.2/bin/yarn --daemon start resourcemanager" }
foreach ($i in 3..5) { docker exec -u root node0$i bash -c "/shared/hadoop-3.4.2/bin/yarn --daemon start nodemanager" }

Write-Host "Cluster is fully online and ready!"
Start-Sleep -Seconds 5