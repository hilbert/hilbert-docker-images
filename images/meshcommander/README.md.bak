# MeshCommander in Docker (taken from [vga101/meshcommander](https://github.com/vga101/meshcommander))

Run [MeshCommander](http://www.meshcommander.com/meshcommander) inside Docker to provide a simple way to get access to Intel
AMT out-of-band management on Linux. MeshCommander is accessible on port 3000,
which is exposed by the container.

We provide [hilbert/meshcommander](https://hub.docker.com/r/vga101/meshcommander/) docker image.

## Usage example

Make sure you have Docker readily installed and running.

Build your own image:
```
git clone https://github.com/hilbert/hilbert-docker-images.git
cd hilbert-docker-images/images/meshcommander
make
```

Test it:
```
docker run -d -p 3000:3000 hilbert/meshcommander
```
and then access it with your browser at <http://localhost:3000>.

