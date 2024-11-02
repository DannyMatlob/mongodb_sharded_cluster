#!/bin/bash

# Load IP addresses from ips.sh
source ips.sh

# MongoDB connection details
MONGOS_IP=${IPS[4]}  # Using the IP address for Mongos
MONGOS_PORT="27017"  # Change if your MongoS is on a different port

# SSH into the MongoS instance and run mongosh
ssh -i "$KEY" "$USER"@"$MONGOS_IP" "mongosh --host $MONGOS_IP --port $MONGOS_PORT" << 'EOF'
    // 1. Range Query
    const startRange = new Date();
    db.movies.find({ year: { $gte: '2000', $lte: '2010' } }).pretty();
    const endRange = new Date();
    print("Range Query Execution time: " + (endRange - startRange) + " ms");

    // 2. $elemMatch Query
    const startElemMatch = new Date();
    db.movies.find({ genres: { $elemMatch: { $in: ['Drama', 'Thriller'] } } }).pretty();
    const endElemMatch = new Date();
    print("ElemMatch Query Execution time: " + (endElemMatch - startElemMatch) + " ms");

    // 3. $in Query
    const startIn = new Date();
    db.movies.find({ id: { $in: [6, 8] } }).pretty();
    const endIn = new Date();
    print("In Query Execution time: " + (endIn - startIn) + " ms");

    // 4. Aggregate Query
    const startAggregate = new Date();
    db.movies.aggregate([
      { $unwind: "$genres" },
      { $group: { _id: "$genres", count: { $sum: 1 } } }
    ]).pretty();
    const endAggregate = new Date();
    print("Aggregate Query Execution time: " + (endAggregate - startAggregate) + " ms");

    // 5. Update Query
    const startUpdate = new Date();
    db.movies.updateOne(
      { title: 'Ratatouille' },
      { $set: { runtime: '120' } }
    );
    const endUpdate = new Date();
    print("Update Query Execution time: " + (endUpdate - startUpdate) + " ms");

    // 6. Delete Query
    const startDelete = new Date();
    const deleteResult = db.movies.deleteOne({ id: 21 });
    const endDelete = new Date();
    print("Delete Query Execution time: " + (endDelete - startDelete) + " ms");
    printjson(deleteResult);
EOF