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
    - 如果不指定-p, 创建的vv里的python会是一个指向当前python的软链接 
    - virtualenv will always use system python (virtuanenv only manage site-packages, not python)
    - virtuanenv 不包括安装python
