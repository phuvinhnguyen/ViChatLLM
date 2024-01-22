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