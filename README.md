Q1 

command geoiplookup is required. You can install it by

Debian/Ubuntu
```
apt-get install geoip-bin geoip-database
```
CentOS/RHEL
```
yum install GeoIP GeoIP-data
```

Q2

aws cli is required.Installation instruction can be found on 

https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html

You can configure IAM role on the EC2 instance to make this more simple

Q3
![architecture](https://user-images.githubusercontent.com/40196992/97959171-ba975f00-1de9-11eb-967a-55787158fb58.png)


two env MONGODB and BASEURL is needed to reflect the mongodb connection string and Domain name of the short url
```
docker build -t shorturl .
docker run -p 5000:5000 -e MONGODB='mongodb+srv://user:abcd1234@demo.vwlvn.mongodb.net/shorturl?retryWrites=true&w=majority'  -e BASEURL='https://shorturl.org' shorturl
```
To run a simple mongodb using docker
```
docker run -itd --name mongo -p 27017:27017 mongo
```

For the nodejs part, for my convenient, I test the application using my own sandbox EKS, mainifest file are stored in folder k8s. Please note
configmaps are used instead of Secrets easy config read. Load Balance EC2 running docker/node with application balancer is also okay.

For the database part, it will better to use AWS DynamoDB/Documentdb or Mongodb altas. I have created a free tier Mongodb altas for demo. Everything can be also ran in local using docker.

For CDN(Cloudfront) part, I used terraform as the IaC. It can cache the response properly with some sample test request. Since the shorturl will not be deleted, so the GET request will always be cached and will not genearate much load to the service.

![cloudfron](https://user-images.githubusercontent.com/40196992/98055038-7f437180-1e77-11eb-8bf7-9d99c93a04e6.png)

Command
POST newurl
```
curl -X POST https://shorturl.org/newurl -d '{"longUrl":"https://hk.yahoo.com"}' -H 'Content-Type: application/json'
```
ACCESS shorturl
```
curl https://shorturl.org/J190fLvev   
```

Limitiation
1. The system is not configured with authentication/API key, everyone can generate short url using simple RESTful API. People may abuse/ddos the service. We can consider deploy WAF on AWS cloudfront.

2. There is no expiry date for the url and no function the delete the url. So the database size will always keep rising.

3. The demo mongodb altas is free tier and relative small. I have not test with very high load.

4. The system can be attack by doing the POST for the same longurl and the application need to check the database record every time.

