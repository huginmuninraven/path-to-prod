FROM python:3.13.3-bullseye

# Begin User portion
ARG USERNAME=PYTHON
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
USER $USER_UID
# End User setup


WORKDIR /opt/python
COPY ./run.py /opt/python/run.py
COPY ./example_1.json /opt/python/example_1.json
EXPOSE 8080
CMD ["python3", "run.py"]