FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    openssh-client \
    curl \
    zsh \
    && rm -rf /var/lib/apt/lists/*

COPY modules/requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir \
    --trusted-host pypi.org \
    --trusted-host files.pythonhosted.org \
    -r /tmp/requirements.txt
                
WORKDIR /workspace

CMD ["zsh", "-i"]

RUN printf '%s\n' \
'autoload -Uz colors && colors' \
'PROMPT="%B%F{green}${THBOX_USER:-user}@thbox%f%b:%B%F{cyan}${THBOX_PROJECT_NAME:-workspace}%f%b $ "' \
>> /root/.zshrc

RUN echo '\
scripts() {\
  if [ -z "$THBOX_SCRIPTS_PATH" ]; then\
    echo "THBOX_SCRIPTS_PATH is not set";\
    return 1;\
  fi;\
  cd "$THBOX_SCRIPTS_PATH";\
}\
' >> /root/.zshrc