docker build -t mohitochani/multi-client:latest -t mohitochani/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t mohitochani/multi-server:latest -t mohitochani/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t mohitochani/multi-worker:latest -t mohitochani/multi-worker:$SHA -f ./server/Dockerfile.dev ./worker
docker push mohitochani/multi-client:latest
docker push mohitochani/multi-server:latest
docker push mohitochani/multi-worker:latest

docker push mohitochani/multi-client:$SHA
docker push mohitochani/multi-server:$SHA
docker push mohitochani/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mohitochani/multi-server:$SHA
kubectl set imate deployments/client-deployment client=mohitochani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mohitochani/multi-worker:$SHA
