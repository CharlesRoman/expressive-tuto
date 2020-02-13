## Docker Setup Skeleton

Docker Setup Skeleton is a skeleton of files and directories provided with a docker configuration and a makefile made to launch quick setup of some frameworks in PHP.

The Docker configuration is based on the tutorial of The Coding Machine : 

https://thecodingmachine.io/building-a-single-page-application-with-symfony-4-and-vuejs

### Installation

For now, the simple way to install the skeleton and have direct access to the makefile is to clone the repo.

### Usage

Once you have the skeleton in your project directory, you have access to several command line

##
```bash
make setup
```
Copy of .env.template in a .env file that will be used for some parameters. If you want to change the params before launching the build

##
```bash
make install-symfo
```
Install a basic Symfony app
##
```bash
make install-zend-xp
```
Install a basic Zend Expressive app
##
```bash
make install-api-platform-vue
```
Install an app skeleton API Platform and VueJS