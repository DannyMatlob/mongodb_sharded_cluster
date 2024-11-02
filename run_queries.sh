#!/bin/bash

# Load IP addresses from ips.sh
source ips.sh

# MongoDB connection details
MONGOS_IP=${IPS[4]}  # Using the IP address for Mongos
MONGOS_PORT="27017"  # Change if your MongoS is on a different port

# SSH into the MongoS instance and run mongosh
ssh -i "$KEY" "$USER"@"$MONGOS_IP" "mongosh --host $MONGOS_IP --port $MONGOS_PORT" << 'EOF'
    // 1. Range Query
    print("Running Range Query:);
    db.getSiblingDB("testdb").movies.find({ year: { $gte: '2000', $lte: '2010' } }).pretty().explain("allPlansExecution");
    const startRange = new Date();
    db.getSiblingDB("testdb").movies.find({ year: { $gte: '2000', $lte: '2010' } }).pretty().explain
    const endRange = new Date();
    print("Range Query Execution time: " + (endRange - startRange) + " ms\n\n");

    // 2. $elemMatch Query
    print("Running Eleement Match Query:);
    const startElemMatch = new Date();
    db.getSiblingDB("testdb").movies.find({ genres: { $elemMatch: { $in: ['Drama', 'Thriller'] } } }).pretty();
    const endElemMatch = new Date();
    print("ElemMatch Query Execution time: " + (endElemMatch - startElemMatch) + " ms\n\n");

    // 3. $in Query
    print("Running $in Query:);
    const startIn = new Date();
    db.getSiblingDB("testdb").movies.find({ id: { $in: [6, 8] } }).pretty();
    const endIn = new Date();
    print("In Query Execution time: " + (endIn - startIn) + " ms\n\n");

    // 4. Aggregate Query
    print("Running Aggregate Query:);
    const startAggregate = new Date();
    db.getSiblingDB("testdb").movies.aggregate([
      { $unwind: "$genres" },
      { $group: { _id: "$genres", count: { $sum: 1 } } }
    ]).pretty();
    const endAggregate = new Date();
    print("Aggregate Query Execution time: " + (endAggregate - startAggregate) + " ms\n\n");

    // 5. Update Query
    print("Running Update Query:);
    const startUpdate = new Date();
    db.getSiblingDB("testdb").movies.updateOne(
      { title: 'Ratatouille' },
      { $set: { runtime: '120' } }
    );
    const endUpdate = new Date();
    print("Update Query Execution time: " + (endUpdate - startUpdate) + " ms\n\n");

    // 6. Delete Query
    const startDelete = new Date();
    const deleteResult = db.getSiblingDB.movies.deleteOne({ id: 21 });
    const endDelete = new Date();
    print("Delete Query Execution time: " + (endDelete - startDelete) + " ms\n\n");
    printjson(deleteResult);
EOF