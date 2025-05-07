FROM python:3.13.3-slim-bullseye

# Set USER and USER_UID, and run as non-root
# Begin User portion
ARG USERNAME=PYTHON
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
USER $USER_UID
# End User setup

# Use the below line if additional packages are needed
# RUN pip install -r requirements.txt

WORKDIR /opt/python
COPY ./run.py ./example_1.json /opt/python/
EXPOSE 80

# Gives unbuffered output
CMD ["python3", "-u", "run.py"]