docker build -t hebbaruday/multi-client:latest -t hebbaruday/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t hebbaruday/multi-server:latest -t hebbaruday/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t hebbaruday/multi-worker:latest -t hebbaruday/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push hebbaruday/multi-client:latest
docker push hebbaruday/multi-server:latest
docker push hebbaruday/multi-worker:latest

docker push hebbaruday/multi-client:$SHA
docker push hebbaruday/multi-server:$SHA
docker push hebbaruday/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hebbaruday/multi-server:$SHA
kubectl set image deployments/client-deployment client=hebbaruday/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hebbaruday/multi-worker:$SHA

