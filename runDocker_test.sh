sudo docker run --gpus all --rm -it --user $(id -u):$(id -g) -v /scratch_hdd:/scratch_hdd -v /scratch_ssd:/scratch_ssd -v /scratch_cmsse:/scratch_cmsse tensorflow-gpu_candidate:latest

# --user $(id -u):$(id -g)