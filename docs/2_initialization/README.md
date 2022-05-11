# 2. Project initialization

Both frameworks provide a way to initialize a project from scratch. Let's try them.
We will create a dedicated folder for each of them.

## nile
```bash 
mkdir nile-sample-project && cd nile-sample-project
nile init
```

This command generates a directory structure:
- A `contracts` folder to contain source files
- A `tests` folder to contain unit tests 
- A `.gitignore` file with predefined rules
- An `accounts.json` file to hold the list of account contracts deployed
- A `Makefile` with rules to compile and run unit tests
- A `node.json` file to hold the list of local nodes. 

:heavy_check_mark: one-liner to initialize a project<br>
:heavy_check_mark: install all required dependencies<br>
:heavy_check_mark: generate `.gitignore` and `Makefile`

## protostar
```bash
protostar init
project directory name: protostar-sample-project
libraries directory name (lib): lib
```

This command generates a directory structure:
- A `lib` folder to contain external dependencies
- An `src` folder to contain source files
- A `tests` folder to contain the unit tests
- A `protostar.toml` file with the configuration

Note: protostar also initiate a git repository in the project folder.

:heavy_check_mark: one-liner to initialize a project

:x: forces the generation of a git repository

## Conclusion

| nile                                                    | protostar                                            |
| ------------------------------------------------------- | ---------------------------------------------------- |
| :heavy_check_mark: one-liner to initialize a project    | :heavy_check_mark: one-liner to initialize a project |
| :heavy_check_mark: install all required dependencies    | :x: forces the generation of a git repository        |
| :heavy_check_mark: generate `.gitignore` and `Makefile` |                                                      |