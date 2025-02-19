docker volume create actual-budget-data


docker run --pull=always --restart=unless-stopped --user 100:101 -d \
  -p 5006:5006 \
  --mount source=actual-budget-data,target=/data \
  --name actual-budget-athos athos9204/actual-budget-athos:latest
