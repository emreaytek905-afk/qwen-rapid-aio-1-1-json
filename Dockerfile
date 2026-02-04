# Temel ComfyUI imajı (RunPod uyumlu)
FROM runpod/worker-comfyui:5.5.1-base

# ------------------------------------------------------------------------------
# ADIM 1: Eksik Custom Node'un Yüklenmesi
# Workflow'un çalışması için gereken "TextEncodeQwenImageEditPlus" node'unu çeker.
# ------------------------------------------------------------------------------
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/lrzjason/Comfyui-QwenEditUtils.git && \
    cd Comfyui-QwenEditUtils && \
    pip install -r requirements.txt

# ------------------------------------------------------------------------------
# ADIM 2: Model Klasörünün Hazırlanması (KRİTİK)
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

# Alternatif Model (NSFW V2.1) - İhtiyaç olursa diye hazırda bulunması iyi olur.
RUN comfy model download \
    --url "https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/resolve/main/v21/Qwen-Rapid-AIO-NSFW-v21.safetensors?download=true" \
    --relative-path models/checkpoints/Qwen \
    --filename Qwen-Rapid-AIO-NSFW-v21.safetensors

# Not: Eğer yerel bilgisayarındaki resimleri de imajın içine gömmek istersen
# aşağıdaki satırı açabilirsin ama API kullanıyorsan buna gerek yok.
# COPY input/ /comfyui/input/
