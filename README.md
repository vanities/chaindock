# chaindock
instant ethereum and chainlink node for testing and mainnet


## Requirements

- linux or macOS


## Install

1. Download and Install [docker](https://docs.docker.com/get-docker/)
2. Download and Install [docker-compose](https://docs.docker.com/compose/install/)


## Setup

1. setup POSTGRES environments in the Makefile
  - POSTGRES_USER
  - POSTGRES_PASSWORD
  - POSTGRES_DB
2. setup password for the ethereum mainnet node in ./ethereum/mainnet/pass


## Run

1. `make`
