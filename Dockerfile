FROM runpod/worker-comfyui:5.8.5-base

ARG CACHE_BUST=1

RUN cd /comfyui && git fetch && git checkout 8f37471

# Instala custom nodes
#RUN comfy-node-install comfyui-kjnodes comfyui-ic-light comfyui_ipadapter_plus comfyui_essentials ComfyUI-Hangover-Nodes

# Cria script de download
RUN cat <<'EOF' > /download_models.sh
#!/bin/bash

download_if_missing() {
    local url=$1
    local dest=$2
    local filename=$3
    local full_path="/runpod-volume/models/${dest}/${filename}"

    mkdir -p "/runpod-volume/models/${dest}"

    if [ -f "$full_path" ]; then
        echo "✅ Skipping (exists): ${filename}"
    else
        echo "⬇️ Downloading: ${filename}"
        wget -q --show-progress -O "$full_path" "$url" || \
            { echo "❌ Failed: ${filename}"; rm -f "$full_path"; exit 1; }
        echo "✅ Done: ${filename}"
    fi
}

download_if_missing \
    "https://huggingface.co/Lightricks/LTX-2.3-fp8/resolve/main/ltx-2.3-22b-distilled-fp8.safetensors" \
    "checkpoints" "ltx-2.3-22b-distilled-fp8.safetensors"

download_if_missing \
    "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors" \
    "text_encoders" "gemma_3_12B_it_fp4_mixed.safetensors"

EOF
RUN chmod +x /download_models.sh

# Injeta o download antes do start original
RUN sed -i '1a /download_models.sh' /start.sh
