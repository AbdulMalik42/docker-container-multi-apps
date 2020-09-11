# docker-container-multi-apps
- allow to run multiple apps in single docker container
- docker build -t multi-app .
- docker run -p 3000:3000/tcp -p 3001:3001/tcp multi-app
