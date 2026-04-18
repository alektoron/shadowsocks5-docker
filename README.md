## Running

1. Install docker through https://docs.docker.com/engine/install/
2. Update configs via https://shadowsocks.org/doc/configs.html
3. Build the project `docker build -t <username>/socks5:latest .`
- To push to docker hub, run `docker push <username>/socks5:latest`
- `username` should be the same as on docker.hub. Also to login in cli run `docker login` 
4. Update docker compose if needed
5. Run docker `docker compose up -d`