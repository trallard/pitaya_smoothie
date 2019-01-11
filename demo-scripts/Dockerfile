# using the latest ws-adapter image
FROM python:3.6alpine
LABEL maintainer="Tania Allard tania.allard@bitsandchips.me"

# install any dependencies needed by the model
COPY ["./Pipfile", "./Pipfile.lock", "./"]

#  running with --deploy will make it fail if the Pifile.lock is out of date
RUN pipenv install --ignore-pipfile --system --deploy \
    && rm -rf /root/cache
