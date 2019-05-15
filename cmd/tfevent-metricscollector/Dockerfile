ARG ARCH
FROM ${ARCH}/python:3.6
RUN pip install rfc3339 grpcio googleapis-common-protos
ADD . /usr/src/app/github.com/kubeflow/katib
WORKDIR /usr/src/app/github.com/kubeflow/katib/cmd/tfevent-metricscollector/v1alpha1
RUN if [ ${ARCH} = "amd64" ]; then pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.12.0-cp36-cp36m-linux_x86_64.whl; \
     elif [ ${ARCH} = "ppc64le" ]; then \
     apt-get install -y libhdf5-dev && \
     cp /usr/lib/powerpc64le-linux-gnu/hdf5/serial/libhdf5.so /usr/local/lib && \
     pip install --global-option=build_ext \ 
                 --global-option=-I/usr/include/hdf5/serial/ \ 
                 --global-option=-L/usr/lib/powerpc64le-linux-gnu/hdf5/serial \ 
                 h5py && \
                 pip install https://powerci.osuosl.org/job/TensorFlow_PPC64LE_CPU_Release_Build/lastStableBuild/artifact/tensorflow_pkg/tensorflow-1.13.1-cp36-cp36m-linux_ppc64le.whl; \
                elif [ ${ARCH} = "armv7l"]; then \
                pip install https://storage.googleapis.com/tensorflow-nightly/tensorflow-1.10.0-cp34-none-linux_armv7l.whl; \
                fi
ENV PYTHONPATH /usr/src/app/github.com/kubeflow/katib:/usr/src/app/github.com/kubeflow/katib/pkg/api/v1alpha1/python:/usr/src/app/github.com/kubeflow/katib/pkg/manager/v1alpha1/file-metricscollector/tf-event
