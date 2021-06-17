docker build -t masbot/multi-client:latest -t masbot/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t masbot/multi-server:latest -t masbot/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t masbot/multi-worker:latest -t masbot/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push masbot/multi-client:latest
docker push masbot/multi-server:latest
docker push masbot/multi-worker:latest
docker push masbot/multi-client:$SHA
docker push masbot/multi-server:$SHA
docker push masbot/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployments server=masbot/multi-server:$SHA
kubectl set image deployments/client-deployments client=masbot/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=masbot/multi-worker:$SHA
