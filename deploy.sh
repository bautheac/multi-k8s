docker build -t bautheac/multi-client:latest -t bautheac/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t bautheac/multi-server:latest -t bautheac/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t bautheac/multi-worker:latest -t bautheac/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push bautheac/multi-client:latest
docker push bautheac/multi-client:$GIT_SHA
docker push bautheac/multi-server:latest
docker push bautheac/multi-server:$GIT_SHA
docker push bautheac/multi-worker:latest
docker push bautheac/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=bautheac/multi-client$GIT_SHA
kubectl set image deployments/server-deployment server=bautheac/multi-server$GIT_SHA
kubectl set image deployments/worker-deployment worker=bautheac/multi-worker$GIT_SHA