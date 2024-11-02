source ips.sh

MONGOS_IP=${IPS[4]}

echo "Inserting 50,000 documents into db"
ssh -i $KEY $USER@$MONGOS_IP << 'EOF'
wget -O /home/ubuntu/data.json https://raw.githubusercontent.com/erik-sytnyk/movies-list/refs/heads/master/db.json

sudo apt install jq

jq '.movies' data.json > movies.json

mongoimport --port 27017 --db testdb --collection movies --file /home/ubuntu/movies.json --jsonArray

EOF

#mongosh --port 27017 --eval 'for (var i = 0; i < 100000; i++) { db.getSiblingDB("testdb").movies.insertOne({"id": "key" + i}) }'
