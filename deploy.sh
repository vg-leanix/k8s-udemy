docker build -t vncgrvs/multi-client:latest -t vncgrvs/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t vncgrvs/multi-server:latest -t vncgrvs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vncgrvs/multi-worker:latest -t vncgrvs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vncgrvs/multi-client:latest
docker push vncgrvs/multi-server:latest
docker push vncgrvs/multi-worker:latest

docker push vncgrvs/multi-client:$SHA
docker push vncgrvs/multi-server:$SHA
docker push vncgrvs/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vncgrvs/multi-server:$SHA
kubectl set image deployments/client-deployment client=vncgrvs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vncgrvs/multi-worker:$SHA
