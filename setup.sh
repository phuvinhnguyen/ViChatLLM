pip install platformdirs==3.11.0
pip install pexpect
pip install packaging ninja
pip install deepspeed flash-attn
pip install datasets==2.15.0

# !rm -rf openchat
echo "Build packages..."
pip3 install --upgrade pip  # enable PEP 660 support
pip3 install -e .  # Editable mode, you can make changes in this cloned repo

echo "Download data..."
wget https://filetransfer.io/data-package/Bq0nJ3sB/download -O data.zip
unzip -P s@crify data.zip