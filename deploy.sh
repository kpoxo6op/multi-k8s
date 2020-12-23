docker build -t kpoxo6op/multi-client:latest -t kpoxo6op/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kpoxo6op/multi-server:latest -t kpoxo6op/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kpoxo6op/multi-worker:latest -t kpoxo6op/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kpoxo6op/multi-client:latest
docker push kpoxo6op/multi-server:latest
docker push kpoxo6op/multi-worker:latest

docker push kpoxo6op/multi-client:$SHA
docker push kpoxo6op/multi-server:$SHA
docker push kpoxo6op/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=kpoxo6op/multi-client:$SHA
kubectl set image deployments/server-deployment server=kpoxo6op/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=kpoxo6op/multi-worker:$SHA