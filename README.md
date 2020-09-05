# Stockfish Docker Image
[![Build Status](https://travis-ci.com/andrijdavid/stockfish.svg?branch=master)](https://travis-ci.com/andrijdavid/stockfish)

This image run stockfish inside a docker image and makes it available remotely via raw tcp. 

`docker run -P --name stockfish --restart=always  -d andrijdavid/stockfish`
