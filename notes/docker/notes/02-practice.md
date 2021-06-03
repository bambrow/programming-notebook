## More Practices

### Container's Filesystem

When a container runs, it uses the various layers from an image for its filesystem. Each container also gets its own "scratch space" to create/update/remove files. Any changes won't be seen in another container, even if they are using the same image.

To practice this, we start two containers and create a file in each:

```
# Start a ubuntu container that will create a file named /data.txt with a random number between 1 and 10000.

docker run -d ubuntu bash -c "shuf -i 1-10000 -n 1 -o /data.txt && tail -f /dev/null"
```

We're starting a bash shell and invoking two commands (why we have the `&&`). The first portion picks a single random number and writes it to `/data.txt`. The second command is simply watching a file to keep the container running.

Then open the Dashboard and click the first action (CLI) of the container that is running the `ubuntu` image. Then in the terminal, run `cat /data.txt`. We can also do this by command line `docker exec <container-id> cat /data.txt`.

Let's start another ubuntu container (the same image) and we'll see we don't have the same file: `docker run -it ubuntu ls /`.

### Container Volumes

Volumes provide the ability to connect specific filesystem paths of the container back to the host machine. If a directory in the container is mounted, changes in that directory are also seen on the host machine. If we mount that same directory across container restarts, we'd see the same files. 

There are two main types of volumes. We will start with named volumes.

By default, the todo app stores its data in a SQLite Database at `/etc/todos/todo.db`. With the database being a single file, if we can persist that file on the host and make it available to the next container, it should be able to pick up where the last one left off. By creating a volume and attaching (often called "mounting") it to the directory the data is stored in, we can persist the data. As our container writes to the `todo.db` file, it will be persisted to the host in the volume.

As mentioned, we are going to use a named volume. Think of a named volume as simply a bucket of data. Docker maintains the physical location on the disk and you only need to remember the name of the volume. Every time you use the volume, Docker will make sure the correct data is provided.

```
docker volume create todo-db
```

Use `docker rm -f` to remove the container, and then `docker run -dp 3000:3000 -v todo-db:/etc/todos getting-started`. The `-v` flag will specify a volume mount. We will use the named volume and mount it to `/etc/todos`, which will capture all files created at the path.

Then modify your todo list, and then use `docker rm -f` to remove the container again. Restart the container using `docker run -dp 3000:3000 -v todo-db:/etc/todos getting-started`. You can see the todo list is persisted.

> While named volumes and bind mounts (which we'll talk about in a minute) are the two main types of volumes supported by a default Docker engine installation, there are many volume driver plugins available to support NFS, SFTP, NetApp, and more! This will be especially important once you start running containers on multiple hosts in a clustered environment with Swarm, Kubernetes, etc.

### Diving into Volume

```
docker volume inspect todo-db
[
    {
        "CreatedAt": "2021-05-26T20:25:59Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/todo-db/_data",
        "Name": "todo-db",
        "Options": {},
        "Scope": "local"
    }
]
```

The `Mountpoint` is the actual location on the disk where the data is stored.

> While running in Docker Desktop, the Docker commands are actually running inside a small VM on your machine. If you wanted to look at the actual contents of the Mountpoint directory, you would need to first get inside of the VM.

### Bind Mounts

With bind mounts, we control the exact mountpoint on the host. We can use this to persist data, but is often used to provide additional data into containers. When working on an application, we can use a bind mount to mount our source code into the container to let it see code changes, respond, and let us see the changes right away.

For Node-based applications, nodemon is a great tool to watch for file changes and then restart the application. There are equivalent tools in most other languages and frameworks.

### Dev-Mode Container

To run our container to support a development workflow, we will do the following:

- Mount our source code into the container
- Install all dependencies, including the "dev" dependencies
- Start nodemon to watch for filesystem changes

First make sure you don't have any previous `getting-started` containers running. Then:

```
docker run -dp 3000:3000 -w /app -v "$(pwd):/app" node:12-alpine sh -c "yarn install && yarn run dev"
```

- `-w /app` - sets the "working directory" or the current directory that the command will run from
- `-v "$(pwd):/app"` - bind mount the current directory from the host in the container into the /app directory
- `node:12-alpine` - the image to use. Note that this is the base image for our app from the Dockerfile
- `sh -c "yarn install && yarn run dev"` - the command. We're starting a shell using `sh` (alpine doesn't have `bash`) and running `yarn install` to install all dependencies and then running `yarn run dev`. If we look in the `package.json`, we'll see that the `dev` script is starting `nodemon`.

Watch the logs and check if the app is ready:

```
docker logs -f <container-id>
$ nodemon src/index.js
[nodemon] 1.19.2
[nodemon] to restart at any time, enter `rs`
[nodemon] watching dir(s): *.*
[nodemon] starting `node src/index.js`
Using sqlite database at /etc/todos/todo.db
Listening on port 3000
```
Make a small change in `src/static/js/app.js` file, wait for a few moments and refresh the webpage.

Stop the container and build your new image using `docker build -t getting-started .`.

Using bind mounts is very common for local development setups. The advantage is that the dev machine doesn't need to have all of the build tools and environments installed. With a single docker run command, the dev environment is pulled and ready to go.

