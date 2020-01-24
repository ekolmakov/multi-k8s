docker build -t ekolmakov/multi-client:latest -t ekolmakov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ekolmakov/multi-server:latest -t ekolmakov/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t ekolmakov/multi-worker:latest -t ekolmakov/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push ekolmakov/multi-client:latest
docker push ekolmakov/multi-server:latest
docker push ekolmakov/multi-worker:latest

docker push ekolmakov/multi-client:$SHA
docker push ekolmakov/multi-server:$SHA 
docker push ekolmakov/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ekolmakov/multi-server:$SHA
kubectl set image deployments/client-deployment client=ekolmakov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ekolmakov/multi-worker:$SHA



