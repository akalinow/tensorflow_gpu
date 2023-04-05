# tensorflow_gpu

Files used for creation of the Docker image with ML tools:
* TensorFlow
* PyTorch
* number of other standard packages

## Creation of image
```bash
sudo docker image build -t tensorflow-gpu_candidate  ./ -f Dockerfile
sudo docker image tag tensorflow-gpu_cantidate tensorflow-gpu
sudo docker image push tensorflow-gpu
```