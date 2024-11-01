# Cron (Service)

This repository contains the code for a service meant to run at a schedule. It contains tasks/jobs that will be run every now and then at specific intervals or dates.

Currently you'll find tasks for:

* Cleaning up the export archives created by the [api-bio](https://github.com/starpep-web/api-bio) service.
  * This task will run every hour and reads the exports in Redis and compares it to the ones in the exports directory, deleting those in the filesystem that do not exist in Redis anymore.

## Requirements

In order to develop for this repository you need:

* [Ruby v3.4](https://www.ruby-lang.org/en/) (but any `v3` should work fine)
* [Docker](https://www.docker.com/products/docker-desktop/)
* Have [api-bio](https://github.com/starpep-web/api-bio) running locally.
* Have [env-development](https://github.com/starpep-web/env-development) running locally.

## Development

First, clone this repository:

```bash
git clone https://github.com/starpep-web/cron
```

Install the dependencies:

```bash
bundle install
```

Create an `.env` file with the following contents:

```text
REDIS_URI=redis://localhost:6379
TEMP_ARTIFACTS_LOCATION=/path/to/artifacts
```

Run the `src/main.rb` script:

```bash
ruby ./src/main.rb
```

If you prefer to run the task directly, feel free to edit `src/test.rb` file and run that one instead.

## Building

If you're developing this on your local machine, consider building the Docker image with the following command:

```bash
docker build -t local-starpep/cron:latest .
```

You can create a new container to try it out with the following command:

```bash
docker run -it --rm -e REDIS_URI=redis://localhost:6379 -e TEMP_ARTIFACTS_LOCATION=/path/to/artifacts local-starpep/cron:latest
```

## Production

Consider checking this [docker-compose.yml](https://github.com/starpep-web/env-production/blob/main/docker-compose.yml) for an example on how to run this image in production.
