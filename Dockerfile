# Temel ComfyUI imajı (RunPod uyumlu)
FROM runpod/worker-comfyui:5.5.1-base

# ------------------------------------------------------------------------------
# ADIM 1: Eksik Custom Node'un Yüklenmesi
# DÜZELTME: "requirements.txt" dosyası repoda olmadığı için pip install komutunu kaldırdık.
# Sadece git clone yapıyoruz, node çalışacaktır.
# ------------------------------------------------------------------------------
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/lrzjason/Comfyui-QwenEditUtils.git

# ------------------------------------------------------------------------------
# ADIM 2: Model Klasörünün Hazırlanması
# JSON dosyanızdaki "Qwen\\Qwen-Rapid..." yoluna uyum sağlamak için bu klasör şart.
# ------------------------------------------------------------------------------
RUN mkdir -p models/checkpoints/Qwen

# ------------------------------------------------------------------------------
# ADIM 3: Modellerin İndirilmesi
# Linkler "resolve" (direkt indirme) modunda ve hedef klasör "Qwen" olarak ayarlı.
# ------------------------------------------------------------------------------

# Ana Model (V1)
RUN comfy model download \
    --url https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/resolve/main/Qwen-Rapid-AIO-v1.safetensors \
    --relative-path models/checkpoints/Qwen \
    --filename Qwen-Rapid-AIO-v1.safetensors

# Alternatif Model (NSFW V2.1)
RUN comfy model download \
    --url "https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/resolve/main/v21/Qwen-Rapid-AIO-NSFW-v21.safetensors?download=true" \
    --relative-path models/checkpoints/Qwen \
    --filename Qwen-Rapid-AIO-NSFW-v21.safetensors
