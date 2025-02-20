sudo docker run --runtime=nvidia --gpus all --rm -it -p 8888:8888 --user $(id -u):$(id -g) -v /scratch_hdd:/scratch_hdd -v /scratch_ssd:/scratch_ssd -v /scratch_cmsse:/scratch_cmsse tensorflow-gpu_candidate

# --user $(id -u):$(id -g)