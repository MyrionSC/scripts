
If you get errors in logs looking like below, you are probably on wrong network. Set 'network_mode: host' property in docker-compose.yaml (to use localhost network)

Actually, that didn't work :P

/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: IPv6 listen already enabled
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2021/02/05 10:40:33 [error] 21#21: *2 connect() failed (111: Connection refused) while connecting to upstream, client: 172.30.0.1, se
rver: localhost, request: "GET /hr HTTP/1.1", upstream: "http://127.0.0.1:8080/hr", host: "localhost"
2021/02/05 10:40:33 [warn] 21#21: *2 upstream server temporarily disabled while connecting to upstream, client: 172.30.0.1, server: l
ocalhost, request: "GET /hr HTTP/1.1", upstream: "http://127.0.0.1:8080/hr", host: "localhost"
2021/02/05 10:40:33 [error] 21#21: *2 connect() failed (111: Connection refused) while connecting to upstream, client: 172.30.0.1, se
rver: localhost, request: "GET /hr HTTP/1.1", upstream: "http://127.0.0.1:8080/hr", host: "localhost"
2021/02/05 10:40:33 [warn] 21#21: *2 upstream server temporarily disabled while connecting to upstream, client: 172.30.0.1, server: l
ocalhost, request: "GET /hr HTTP/1.1", upstream: "http://127.0.0.1:8080/hr", host: "localhost"
172.30.0.1 - - [05/Feb/2021:10:40:33 +0000] "GET /hr HTTP/1.1" 502 494 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537
.36 (KHTML, like Gecko) Chrome/88.0.4324.104 Safari/537.36" "-"

