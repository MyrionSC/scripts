
## mods httpbin.org to print calls to /anything

1. clone https://github.com/postmanlabs/httpbin
2. edit httpbin/core.py

add code to anything endpoint

    res_dict = get_dict(
        "url",
        "args",
        "headers",
        "origin",
        "method",
        "form",
        "data",
        "files",
        "json",
    )
    app.logger.critical("=== Received request to anything")
    app.logger.critical(f"\n{json.dumps(res_dict, indent=4)}")
    return jsonify(res_dict)

3. build with 'docker build -t httpbinmod:latest .'
4. run with 'docker-compose up -d'

docker-compose.yaml should be

version: "3.7"
services:
  httpbin:
    image: httpbinmod
    ports:
      - "8080:80"
    restart: always

5. it should now be running on port 8080
  - try to curl with localhost:8080
  - connect to logs with 'docker logs <ID> -f'

6. configure nginx to forward to it on HOST/anything, while not changing any headers

location /anything {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_pass http://127.0.0.1:8080;
}

