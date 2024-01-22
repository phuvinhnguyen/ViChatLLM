pip install platformdirs==3.11.0
pip install pexpect
pip install packaging ninja
pip install deepspeed flash-attn
pip install datasets==2.15.0

# !rm -rf openchat
pip3 install --upgrade pip  # enable PEP 660 support
pip3 install -e .  # Editable mode, you can make changes in this cloned repo

wget https://filetransfer.io/data-package/Bq0nJ3sB/download -O data.zip
unzip -P s@crify data.zip

deepspeed --num_gpus=2 --module ochat.training_deepspeed.train \
          --model_path imone/Mistral_7B_with_EOT_token \
          --data_prefix ./data/tokenizedata \
          --save_path ./mixtral_test \
          --batch_max_len 64 \
          --epochs 5 \
          --save_every 1 \
          --deepspeed \
          --deepspeed_config openchat/ochat/training_deepspeed/deepspeed_config.json