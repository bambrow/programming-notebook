## Docker Compose

Docker Compose is a tool that was developed to help define and share multi-container applications. With Compose, we can create a YAML file to define the services and with a single command, can spin everything up or tear it all down.

We will use `docker-compose.yml`. Check the content and compare with our docker commands to build the apps.

Run `docker-compose up -d`:

```
docker-compose up -d
Docker Compose is now in the Docker CLI, try `docker compose up`

Creating network "app_default" with the default driver
Creating volume "app_todo-mysql-data" with default driver
Creating app_mysql_1 ... done
Creating app_app_1   ... done
```

By default, Docker Compose automatically creates a network specifically for the application stack (which is why we didn't define one in the compose file).

Check the logs:

```
docker-compose logs -f

mysql_1  | 2021-05-26T21:49:33.673085Z 0 [Note] mysqld: ready for connections.
mysql_1  | Version: '5.7.34'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)
mysql_1  | 2021-05-26T21:49:34.473317Z 2 [Note] Got an error reading communication packets
app_1    | yarn install v1.22.5
app_1    | [1/4] Resolving packages...
app_1    | success Already up-to-date.
app_1    | Done in 0.75s.
app_1    | yarn run v1.22.5
app_1    | $ nodemon src/index.js
app_1    | [nodemon] 1.19.2
app_1    | [nodemon] to restart at any time, enter `rs`
app_1    | [nodemon] watching dir(s): *.*
app_1    | [nodemon] starting `node src/index.js`
app_1    | Waiting for mysql:3306.
app_1    | Connected!
app_1    | Connected to mysql db at host mysql
app_1    | Listening on port 3000
```

You can do `docker-compose logs -f <app>` to check logs for a specific app.

> When the app is starting up, it actually sits and waits for MySQL to be up and ready before trying to connect to it. Docker doesn't have any built-in support to wait for another container to be fully up, running, and ready before starting another container. For Node-based projects, you can use the wait-port dependency. Similar projects exist for other languages/frameworks.

If we look at the Docker Dashboard, we'll see that there is a group named app. This is the "project name" from Docker Compose and used to group the containers together. By default, the project name is simply the name of the directory that the docker-compose.yml was located in.

If you twirl down the app, you will see the two containers we defined in the compose file. The names are also a little more descriptive, as they follow the pattern of `<project-name>_<service-name>_<replica-number>`. So, it's very easy to quickly see what container is our app and which container is the mysql database.

To stop the apps:

```
docker-compose down
Stopping app_mysql_1 ... done
Stopping app_app_1   ... done
Removing app_mysql_1 ... done
Removing app_app_1   ... done
Removing network app_default
```

> By default, named volumes in your compose file are NOT removed when running docker-compose down. If you want to remove the volumes, you will need to add the `--volumes` flag. The Docker Dashboard does not remove volumes when you delete the app stack.


### Security Scanning

Run `docker scan getting-started`:

```
docker scan getting-started
Docker Scan relies upon access to Snyk, a third party provider, do you consent to proceed using Snyk? (y/N)
y

Testing getting-started...

Package manager:   apk
Project name:      docker-image|getting-started
Docker image:      getting-started
Platform:          linux/amd64

✓ Tested 38 dependencies for known vulnerabilities, no vulnerable paths found.
```

As well as scanning your newly built image on the command line, you can also configure Docker Hub to scan all newly pushed images automatically, and you can then see the results in both Docker Hub and Docker Desktop.

### Image Layering

```
docker image history getting-started
IMAGE          CREATED       CREATED BY                                      SIZE      COMMENT
b934712a5c35   5 days ago    CMD ["node" "src/index.js"]                     0B        buildkit.dockerfile.v0
<missing>      5 days ago    RUN /bin/sh -c yarn install --production # b…   83.2MB    buildkit.dockerfile.v0
<missing>      5 days ago    COPY . . # buildkit                             58.6MB    buildkit.dockerfile.v0
<missing>      5 days ago    WORKDIR /app                                    0B        buildkit.dockerfile.v0
<missing>      5 days ago    RUN /bin/sh -c apk add --no-cache python g++…   205MB     buildkit.dockerfile.v0
<missing>      6 weeks ago   /bin/sh -c #(nop)  CMD ["node"]                 0B
<missing>      6 weeks ago   /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B
<missing>      6 weeks ago   /bin/sh -c #(nop) COPY file:238737301d473041…   116B
<missing>      6 weeks ago   /bin/sh -c apk add --no-cache --virtual .bui…   7.62MB
<missing>      6 weeks ago   /bin/sh -c #(nop)  ENV YARN_VERSION=1.22.5      0B
<missing>      6 weeks ago   /bin/sh -c addgroup -g 1000 node     && addu…   75.7MB
<missing>      6 weeks ago   /bin/sh -c #(nop)  ENV NODE_VERSION=12.22.1     0B
<missing>      6 weeks ago   /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
<missing>      6 weeks ago   /bin/sh -c #(nop) ADD file:282b9d56236cae296…   5.62MB
```

Each of the lines represents a layer in the image. The display here shows the base at the bottom with the newest layer at the top. Using this, you can also quickly see the size of each layer, helping diagnose large images.

### Layer Caching

Old Dockerfile:
```
FROM node:12-alpine
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "src/index.js"]
```

New Dockerfile:
```
FROM node:12-alpine
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --production
COPY . .
CMD ["node", "src/index.js"]
```

And add a `.dockerignore` file, then add `node_modules` to it.

### Multi-Stage Builds

Goal: Separate build-time dependencies from runtime dependencies; Reduce overall image size by shipping only what your app needs to run.

Maven/Tomcat Example:
```
FROM maven AS build
WORKDIR /app
COPY . .
RUN mvn package

FROM tomcat
COPY --from=build /app/target/file.war /usr/local/tomcat/webapps 
```

React Example:
```
FROM node:12 AS build
WORKDIR /app
COPY package* yarn.lock ./
RUN yarn install
COPY public ./public
COPY src ./src
RUN yarn run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
```
