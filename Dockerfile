# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG JUPYTERHUB_VERSION
FROM jupyterhub/jupyterhub:$JUPYTERHUB_VERSION

# Install dockerspawner, nativeauthenticator
# hadolint ignore=DL3013
RUN python3 -m pip install --no-cache-dir \
    dockerspawner \
    jupyterhub-nativeauthenticator

RUN mkdir -p /srv/jupyterhub/keys
RUN openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
    -keyout /srv/jupyterhub/keys/jhubssl.key -out /srv/jupyterhub/keys/jhubssl.crt \
    -subj "/C=US/ST=Washington/L=Auburn/O=Puget Systems/OU=Labs/CN=Puget Systems Labs Self-Signed" \
    -addext "subjectAltName=DNS:localhost,DNS:localhost,IP:127.0.0.1"

CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]