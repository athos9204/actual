docker stop my_actual_budget
docker container rm my_actual_budget
docker run --pull=always --restart=unless-stopped -d -p 5006:5006 -v ./data:/data --name my_actual_budget actualbudget/actual-server:latest


