docker build --platform linux/amd64  -t actual-budget-athos:latest .

Multi build:

docker buildx build --platform linux/amd64,linux/arm64 -t athos9204/actual-budget-athos .
