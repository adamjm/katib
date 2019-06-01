ARG ARCH
FROM ${ARCH}/python:3.6-stretch

ADD . /usr/src/app/github.com/kubeflow/katib
WORKDIR /usr/src/app/github.com/kubeflow/katib/cmd/suggestion/nasrl/v1alpha1
ARG ARCH=${ARCH}
RUN if [ "$ARCH" = "amd64" ]; then pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.12.0-cp36-cp36m-linux_x86_64.whl && echo "amd64" ; \
     elif [ "$ARCH" = "ppc64le" ]; then \
     wget https://powerci.osuosl.org/job/TensorFlow_PPC64LE_CPU_Release_Build/lastStableBuild/artifact/tensorflow_pkg/tensorflow-1.13.1-cp36-cp36m-linux_ppc64le.whl
     apt-get install -y libhdf5-dev && \
     cp /usr/lib/powerpc64le-linux-gnu/hdf5/serial/libhdf5.so /usr/local/lib && \
     pip install --global-option=build_ext \ 
                 --global-option=-I/usr/include/hdf5/serial/ \ 
                 --global-option=-L/usr/lib/powerpc64le-linux-gnu/hdf5/serial \ 
                 h5py && \
                 pip install tensorflow-1.13.1-cp36-cp36m-linux_ppc64le.whl ;\
                elif [ "$ARCH" = "armv7l"]; then \
                pip install https://storage.googleapis.com/tensorflow-nightly/tensorflow-1.10.0-cp34-none-linux_armv7l.whl ;\
                fi
RUN pip install --no-cache-dir -r ../requirements.txt
ENV PYTHONPATH /usr/src/app/github.com/kubeflow/katib:/usr/src/app/github.com/kubeflow/katib/pkg/api/v1alpha1/python

ENTRYPOINT ["python", "-u", "main.py"]
