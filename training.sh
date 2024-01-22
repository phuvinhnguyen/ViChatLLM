#!/bin/bash

# Default values
batch_size=64
epochs=5
gpu_num=2

# Parse command-line arguments
for arg in "$@"; do
    case $arg in
        batch=*)
            batch_size="${arg#*=}"
            ;;
        epoch=*)
            epochs="${arg#*=}"
            ;;
        gpu=*)
            gpu_num="${arg#*=}"
            ;;
        *)
            # Unknown argument
            echo "Unknown argument: $arg"
            exit 1
            ;;
    esac
done

# Display the parsed values
echo "Batch Size: $batch_size"
echo "Epochs: $epochs"
echo "GPU Number: $gpu_num"

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

echo "Start Training..."
deepspeed --num_gpus=$gpu_num --module ochat.training_deepspeed.train \
          --model_path imone/Mistral_7B_with_EOT_token \
          --data_prefix ./data/tokenizedata \
          --save_path ./mixtral_test \
          --batch_max_len $batch_size \
          --epochs $epochs \
          --save_every 1 \
          --deepspeed \
          --deepspeed_config openchat/ochat/training_deepspeed/deepspeed_config.json