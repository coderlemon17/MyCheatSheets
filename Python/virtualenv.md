# Setup

- `alias vv="virtualenv"`
- `where python`: tell you all the python is system environment
- `which python`: which python will be executed as you type `python`

# Basic use

- `vv DEST_DIR/ENV_NAME`
- `source basic_env/bin/activate`; `deactivate`
- `pip list`: list all packages
- `--system-site-packages`: give the virtual environment access to the system site-packages dir (prefer not use)
- `-p python3`: specify the python version (if not, use the python interpreter when created)
