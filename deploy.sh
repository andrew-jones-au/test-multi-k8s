docker build -t andrewjonesau/multi-client:latest -t andrewjonesau/multi-client:$SHA -f ./client/Dockerfile ./client
docker built -t andrewjonesau/multi-server:latest -t andrewjonesau/multi-server:$SHA -f ./server/Dockerfile ./server
docker built -t andrewjonesau/multi-worker:latest -t andrewjonesau/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andrewjonesau/multi-client:latest
docker push andrewjonesau/multi-server:latest
docker push andrewjonesau/multi-worker:latest

docker push andrewjonesau/multi-client:$SHA
docker push andrewjonesau/multi-server:$SHA
docker push andrewjonesau/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andrewjonesau/multi-server:$SHA
kubectl set image deployments/client-deployment server=andrewjonesau/multi-client:$SHA
kubectl set image deployments/worker-deployment server=andrewjonesau/multi-worker:$SHA