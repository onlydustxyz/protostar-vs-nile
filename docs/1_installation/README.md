# 1. Installation

First let's compare the installation procedures.

## nile 
```bash
python3 -m venv env
source env/bin/activate
pip install cairo-nile
```

:heavy_check_mark: isolated in python virtual environment

:x: `cairo-lang` is not compatible with latest python, requires a dedicated setup

## protostar
```bash
curl -L https://raw.githubusercontent.com/software-mansion/protostar/master/install.sh | bash
```

:heavy_check_mark: one-liner installation script

## Conclusion
| nile                                                                              | protostar                                        |
| --------------------------------------------------------------------------------- | ------------------------------------------------ |
| :heavy_check_mark: isolated in a python virtual env                               | :heavy_check_mark: one-liner installation script |
| :x: `cairo-lang` is not compatible with latest python, requires a dedicated setup |                                                  |
