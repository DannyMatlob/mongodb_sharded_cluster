# Shell Scripts for Creating a MongoDB Sharded Cluster

This is a set of scripts with the purpose of installing MongoDB onto a set of nodes, and then creating a sharded cluster. Each shard will have a replica set of three Mongo daemons for data redundancy. 

# Main Scripts

**ips.sh** specifies the ips of the nodes we will work on

**install_mongo.sh** will install MongoDB onto the nodes specified in ips.sh

**create_replicas_and_connect.sh** will do the heavy lifting of setting up all the Mongod and Mongos instances and wiring them all together

**insert_into_cluster.sh** will populate the database with some dummy data

**clear_mongo.sh** will delete all instances of MongoDB on all nodes

# Helper scripts

**check_mongo.sh** will check the status of MongoDB on all nodes

**login.sh** will allow you to quicky ssh into one of the IPs set in ips.sh

# Test Queries

**queries.js** Holds a list of queries including Range, Element Match, Aggregation, Update, and Delete for testing the cluster
