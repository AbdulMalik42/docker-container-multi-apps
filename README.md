# docker-container-multi-apps
allow to run multiple apps in single docker container
docker build -t multi-app .
docker run -p 127.0.0.1:80:3000/tcp -p 127.0.0.1:80:3001/tcp multi-app
