# 5-Node Hadoop High Availability (HA) Cluster via Docker

## Overview

This project provisions a fully distributed, 5-node Apache Hadoop High Availability (HA) cluster using Docker. It eliminates single points of failure for both HDFS (Storage) and YARN (Compute) by implementing Active/Standby Master nodes managed by a ZooKeeper quorum.

## Architecture Design

The cluster consists of 5 containerized nodes:

- **Node 01 (Active Master):** NameNode, ResourceManager, ZKFC, ZooKeeper 1, JournalNode 1
- **Node 02 (Standby Master):** NameNode, ResourceManager, ZKFC, ZooKeeper 2, JournalNode 2
- **Node 03 (Worker + HA State):** DataNode, NodeManager, ZooKeeper 3, JournalNode 3
- **Node 04 (Worker):** DataNode, NodeManager
- **Node 05 (Worker):** DataNode, NodeManager

> **Note:** JournalNode and ZooKeeper quorums are distributed across nodes 1, 2, and 3 to maintain the required odd-number consensus for split-brain prevention during automatic failover elections.

## Technology Stack

- **Apache Hadoop:** 3.4.2 (HDFS & YARN)
- **Apache ZooKeeper:** 3.8.4
- **Infrastructure:** Docker & Docker Compose
- **OS:** Ubuntu (Container Base) & Shell Scripting

## Key Features

- **HDFS HA:** Automatic failover between Active and Standby NameNodes.
- **YARN HA:** Automatic failover between Active and Standby ResourceManagers.
- **Fencing Mechanism:** SSH fencing configured to isolate crashed nodes safely.
- **Distributed Processing:** Capable of running MapReduce jobs across multiple worker nodes.

## How to Run (Local Testing)

1. Clone the repository.
2. Ensure Docker Desktop is running.
3. Build and launch the cluster:
   ```bash
   docker-compose up -d --build
   ```
