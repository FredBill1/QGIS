FROM fedora

COPY ./ms-windows/mingw/mingwdeps.sh /mingwdeps.sh

RUN  printf '[main]\ngpgcheck=True\ninstallonly_limit=3\nclean_requirements_on_remove=True\nbest=False\nskip_if_unavailable=True\ntsflags=nodocs' > /etc/dnf/dnf.conf \
  && dnf -y update \
  && dnf -y install zip

RUN /mingwdeps.sh \
  && rm /mingwdeps.sh

RUN curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - \
  && dnf -y install nodejs \
  && corepack enable
