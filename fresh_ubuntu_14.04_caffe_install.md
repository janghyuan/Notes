1. `sudo apt-get install build-essential`
2. Install Dependencies
  - `sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler`
  - `sudo apt-get install --no-install-recommends libboost-all-dev`
  - `sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev`
  - `sudo apt-get install libatlas-base-dev`
3. Install python-dev
  `sudo apt-get install python-dev`
4. Install Git
  `sudo apt-get install git`
5. Generate SSH public key
  `ssh-keygen -t rsa -b 4096 -C "janghuan@gmail.com"`
6. Download Caffe source code
  `git clone git@github.com:BVLC/caffe.git`
7. Generate Config file
  `cp Makefile.config.example Makefile.config`
8. Changes on Makefile.config
  - `CPU_ONLY := 1`
  - `INCLUDE_DIRS := $(PYTHON_INCLUDE)  /usr/local/include  /usr/include/hdf5/serial`
  - `LIBRARY_DIRS := $(PYTHON_LIB)  /usr/local/lib   /usr/lib /usr/lib/x86_64-linux-gnu/hdf5/serial`
  - `BLAS := atlas` ability of computing: mkl > openblas > atlas
9. Compile Caffe
  - `make all`
  - `make test`
  - `make runtest`
  if failed just type `make clean` before you restart.
10. Install python-pip
  `sudo apt-get install python-pip`
11. Install gfortran for scipy
  `sudo apt-get install gfortran`
12. Install python dependencies
  - `cd ./python`
  - `for req in $(cat requirements.txt); do sudo pip install $req; done`
13. Check for the requirements
  `sudo pip install -r python/requirements.txt`
14. Compile pycaffe
  `make pycaffe`
  
  change `PYTHON_INCLUDE := /usr/include/python2.7 /usr/**local**/lib/python2.7/dist-packages/numpy/core/include`

done...if succeed in the last step...
