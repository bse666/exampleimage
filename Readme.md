# Example of an image repository with Drone script

## .drone.yml
The root `build` element and the sub `build` and `publish` sections must be replicated exactly.

The two test steps `spectests` and `moretests` just show how you can have multiple test steps. The `moretests` section is not a working example.

##  src
Any data used in the process of building the docker image should be in a subdirectory, like `src` in this example.

## tests
Tests should be in the `tests` directory.
If you have multiple kinds of tests, eg serverspec and fitness, they should be in their own subdirectories of `tests`.


### Node "Hello World" Example
Runs a "Hello World" nodejs app on port 4000

#### Credits and License
From https://github.com/danawoodman/docker-node-hello-world/
Put together by [Dana Woodman](mailto:dana@danawoodman.com) and released under the MIT license.