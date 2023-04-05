#!/bin/bash

ln -s /scratch_* ./
jupyter lab --no-browser --ip=0.0.0.0 --notebook-dir=$HOME
