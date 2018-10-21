# Markdownlint-cli (alpine)

An alpine docker image of the [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli) tool.

## Usage

1. Run the docker image mounting the Markdown files directory as a volume
   
   ```shell
   docker run -dti --name mdl -v <PATH_TO_MD_FILES>:/root mdl-alpine
   
   # For e.g.
   # docker run -dti --name mdl -v $(pwd):/root mdl-alpine
   ```  

2. Run the `markdownlint` command

   ```shell
   docker exec mdl markdownlint --help

   
   Usage: markdownlint [options] <files|directories|globs>

   MarkdownLint Command Line Interface

   Options:

     -h, --help                                  output usage information
     -V, --version                               output the version number
     -s, --stdin                                 read from STDIN (no files)
     -o, --output [outputFile]                   write issues to file (no console)
     -c, --config [configFile]                   configuration file (JSON or YAML)
     -i, --ignore [file|directory|glob]          files to ignore/exclude
     -r, --rules  [file|directory|glob|package]  custom rule files
   ```

   ```shell
   docker exec mdl markdownlint /root/myproject/README.md
   ```   
   
   
---

## Build

- Clone this repo
  
  ```shell
  git clone https://github.com/praveenc/dockerfiles/mdl-alpine
  ```

- Change directory to `mdl-alpine`

  ```shell
  cd mdl-alpine
  ```

- Build the docker image, replace `<IMAGE_NAME>` with a name of your choice

  ```shell
  docker build . -t <IMAGE_NAME>
  ```

