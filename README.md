# Dashboard with Docker

Based on Symfony Docker by [Dunglas](https://github.com/dunglas/symfony-docker/)

## Requirement (Windows)

   * WSL
   * Docker (Docker Desktop on Windows, windows only)
   * Make (Wsl) 
   * Git

   ## Install WSL :
    (cmd admin mode) : wsl --install Debian
     => Reboot
    
   ## Install Docker Desktop 
    https://docs.docker.com/desktop/windows/wsl/
     => Reboot
    
   ## ~~Install chocolatey~~ (No, it doesn't work.)
    https://chocolatey.org/install 
    Execute in cmd (with privileges admin !) : 
       @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
    
   * ~~Then : "choco install make"~~ 
   * ~~Then : "choco install git"~~

## Requirement (Linux Only)
   * Make
   * Docker (Not Docker Desktop)
   * Git

## Clone
    
git clone https://github.com/Respawnsive/dashboard.git

Or 

Use PhpStorm

## Getting Started

// First Clone the repo ! (PhpStorm or Git Clone)

1. (Linux) in terminal ( in wsl ) : make up (need to install Make)
1. (Windows) : docker-compose up -d
2. open browser => https://localhost => if CSS/Js doesn't load => show source code of page => Then click https://localhost:8080/build/runtime.js , and accept certificate !
3. mail info => http://localhost:1080/
4. sql info => 127.0.0.1 , port 3306 , => user : root => !ChangeMeRootPassword! => database : main


## Use SF command

Example (Linux) : 
   * in terminal : 
        make sf c=make:entity
        
        
Example (Windows) :
   * go in php container :
        php bin/console make:entity


## Env vars

=> Test env

docker compose down ; MARIADB_USER="userTest" MARIADB_PASSWORD="test" MARIADB_DATABASE="main_test" docker compose up -d

make test

=> Execute cmd with docker :

docker compose exec php bin/console

## Add Yarn module
    * go in container "node" => Yarn add --dev Module
