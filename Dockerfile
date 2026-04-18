# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# Could not resolve unknown_registry custom node 'MarkdownNote' (no aux_id provided) - skipped
# Could not resolve unknown_registry custom node 'Reroute' (no aux_id provided) - skipped

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2.3-fp8/resolve/main/ltx-2.3-22b-dev-fp8.safetensors --relative-path models/checkpoints --filename ltx-2.3-22b-dev-fp8.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-22b-distilled-lora-384.safetensors --relative-path models/loras --filename ltx-2.3-22b-distilled-lora-384.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-spatial-upscaler-x2-1.1.safetensors --relative-path models/upscale_models --filename ltx-2.3-spatial-upscaler-x2-1.1.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors --relative-path models/clip --filename gemma_3_12B_it_fp4_mixed.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/loras/gemma-3-12b-it-abliterated_lora_rank64_bf16.safetensors --relative-path models/loras --filename gemma-3-12b-it-abliterated_lora_rank64_bf16.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
