ARG ARCH
ARG ARCH_NAME
FROM ${ARCH}/python:3.6

ADD . /usr/src/app/github.com/kubeflow/katib
WORKDIR /usr/src/app/github.com/kubeflow/katib/cmd/suggestion/nasrl/v1alpha1
RUN pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.12.0-cp36-cp36m-linux_${ARCH_NAME}.whl
RUN pip install --no-cache-dir -r ../requirements.txt
ENV PYTHONPATH /usr/src/app/github.com/kubeflow/katib:/usr/src/app/github.com/kubeflow/katib/pkg/api/v1alpha1/python

ENTRYPOINT ["python", "-u", "main.py"]
