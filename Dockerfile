# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# Could not resolve unknown_registry node 'CheckpointLoaderSimple' — no aux_id provided; skipped
# Could not resolve unknown_registry node 'PreviewImage' — no aux_id provided; skipped
# Could not resolve unknown_registry node 'VAEDecode' — no aux_id provided; skipped
# Could not resolve unknown_registry node 'EmptyLatentImage' — no aux_id provided; skipped
# Could not resolve unknown_registry node 'KSampler' — no aux_id provided; skipped
# Could not resolve unknown_registry node 'TextEncodeQwenImageEditPlus' — no aux_id provided; skipped
# Could not resolve unknown_registry node 'TextEncodeQwenImageEditPlus' — no aux_id provided; skipped
# Could not resolve unknown_registry node 'LoadImage' — no aux_id provided; skipped
# Could not resolve unknown_registry node 'LoadImage' — no aux_id provided; skipped

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/blob/main/Qwen-Rapid-AIO-v1.safetensors --relative-path models/checkpoints --filename Qwen-Rapid-AIO-v1.safetensors
RUN comfy model download \
  --url "https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/resolve/main/v21/Qwen-Rapid-AIO-NSFW-v21.safetensors?download=true" \
  --relative-path models/checkpoints \
  --filename Qwen-Rapid-AIO-NSFW-v21.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
