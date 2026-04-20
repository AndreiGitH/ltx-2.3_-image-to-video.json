FROM runpod/worker-comfyui:5.8.5-base

ARG CACHE_BUST=1

RUN cd /comfyui && git fetch && git checkout 8f37471

# Instala custom nodes
#RUN comfy-node-install comfyui-kjnodes comfyui-ic-light comfyui_ipadapter_plus comfyui_essentials ComfyUI-Hangover-Nodes

COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml
RUN cd /comfyui && git log --oneline -1
