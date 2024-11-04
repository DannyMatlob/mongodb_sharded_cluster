// 1. Range Query
// print("Running Range Query:");
db.getSiblingDB("testdb").movies.find({ year: { $gte: 2000, $lte: 2010 } }).explain("allPlansExecution");
var startTime = new Date();
var res = db.getSiblingDB("testdb").movies.find({ year: { $gte: 2000, $lte: 2010 } });
var endTime = new Date();
print("Execution time for Range Query: " + (endTime - startTime) + " ms");

// 2. $elemMatch Query
// print("\n\nRunning $elemMatch Query:");
db.getSiblingDB("testdb").movies.find({ genres: { $elemMatch: { $in: ['Drama', 'Thriller'] } } }).explain("allPlansExecution");
var startTime = new Date();
var res = db.getSiblingDB("testdb").movies.find({ genres: { $elemMatch: { $in: ['Drama', 'Thriller'] } } });
var endTime = new Date();
print("Execution time for $elemMatch Query: " + (endTime - startTime) + " ms");

// 3. $in Query
// print("\n\nRunning $in Query:");
db.getSiblingDB("testdb").movies.find({ id: { $in: [6, 8] } }).explain("allPlansExecution");
var startTime = new Date();
var res = db.getSiblingDB("testdb").movies.find({ id: { $in: [6, 8] } });
var endTime = new Date();
print("Execution time for $in Query: " + (endTime - startTime) + " ms");

// 4. Aggregate Query
// print("\n\nRunning Aggregate Query:");
db.getSiblingDB("testdb").movies.aggregate([
  { $unwind: "$genres" },
  { $group: { _id: "$genres", count: { $sum: 1 } } }
]).explain("allPlansExecution");
var startTime = new Date();
var res = db.getSiblingDB("testdb").movies.aggregate([
  { $unwind: "$genres" },
  { $group: { _id: "$genres", count: { $sum: 1 } } }
]);
var endTime = new Date();
print("Execution time for Aggregate Query: " + (endTime - startTime) + " ms");

// 5. Update Query
// print("\n\nRunning Update Query:");
db.getSiblingDB("testdb").movies.updateOne(
  { title: 'Ratatouille' },
  { $set: { runtime: 120 } }
).explain("allPlansExecution");
var startTime = new Date();
var res = db.getSiblingDB("testdb").movies.updateOne(
  { title: 'Ratatouille' },
  { $set: { runtime: 120 } }
);
var endTime = new Date();
print("Execution time for Update Query: " + (endTime - startTime) + " ms");

// 6. Delete Query
// print("\n\nRunning Delete Query:");
db.getSiblingDB("testdb").movies.deleteOne({ id: 21 }).explain("allPlansExecution");
var startTime = new Date();
var res = db.getSiblingDB("testdb").movies.deleteOne({ id: 21 });
var endTime = new Date();
print("Execution time for Delete Query: " + (endTime - startTime) + " ms");
