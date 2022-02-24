# kartoza-assignment
Technical assessment - Kartoza.


## gnuMake Commands:
The make commands are here to help get complex tasks done faster.
Instead of learning Docker and the current architecture of the deployment, you
can utilize these commands to get up and going.

### Setup
To Setup a local development enviroment run the following command: <br />
    `make start`
### Stop / Tear down.
To stop the containers run: <br />
    `make stop` # or press ctrl + c

### Attach to a container.
To spawn a terminal in a container run: <br />
    `make attach DC=<name of the container>`

    note: you can aquire the container names by running `docker ps`
