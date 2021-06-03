## Getting Started

```
docker run -d -p 80:80 docker/getting-started
```
Go to http://localhost of your computer. The tutorial will show.

- `-d` - run the container in detached mode (in the background)
- `-p 80:80` - map port 80 of the host to port 80 in the container
- `docker/getting-started` - the image to use

### Container

A container is simply another process on your machine that has been isolated from all other processes on the host machine. That isolation leverages kernel namespaces and cgroups, features that have been in Linux for a long time. Docker has worked to make these capabilities approachable and easy to use.

### Container Image

When running a container, it uses an isolated filesystem. This custom filesystem is provided by a container image. Since the image contains the container's filesystem, it must contain everything needed to run an application - all dependencies, configuration, scripts, binaries, etc. The image also contains other configuration for the container, such as environment variables, a default command to run, and other metadata.

Go to `app` folder and run:
```
docker build -t getting-started .
```

This command used the Dockerfile to build a new container image. After the image was downloaded, we copied in our application and used `yarn` to install our application's dependencies. The `CMD` directive specifies the default command to run when starting a container from this image. The `-t` flag specifies a human-readable name for the final image. The `.` at the end of the `docker build` command tells that Docker should look for the `Dockerfile` in the current directory.

### Start and Modify Application

```
docker run -dp 3000:3000 getting-started
```

Go to http://localhost:3000. The app is there.

Now, Modify the `src/static/js/app.js` file and run:

```
docker build -t getting-started .
```

Then we need to remove the old container. Run the following:

```
docker ps 
docker stop <container-id>
docker rm <container-id>
```

To stop and remove we can simply do `docker rm -f <container-id>`. We can also do this using Docker Dashboard.

Now run `docker run -dp 3000:3000 getting-started` again.

### Share Docker Image

Go to Docker Hub website and create a repository named `getting-started`. Then run:

```
docker login -u <your-name>
docker tag getting-started <your-name>/getting-started
docker push <your-name>/getting-started:tagname
```

If you don't specify a tag, Docker will use a tag called `latest`.

After that you can run your image on a new instance by:

```
docker run -dp 3000:3000 <your-name>/getting-started
```

