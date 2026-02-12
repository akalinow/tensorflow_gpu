sudo docker run --rm  --gpus all -it  --user $(id -u):$(id -g) -v /scratch_hdd:/scratch_hdd -v /scratch_ssd:/scratch_ssd -v /scratch_cmsse:/scratch_cmsse  --cap-add=CAP_SYS_ADMIN akalinow/tensorflow-gpu

