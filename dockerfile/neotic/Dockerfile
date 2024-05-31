FROM osrf/ros:noetic-desktop-full
RUN apt-get update && apt-get install command-not-found iproute2 iputils-ping vim openssh-server tmux htop git -y && apt-get update

RUN echo 'Asia/Shanghai' > /etc/timezone && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN sed -i '/Defaults\s*env_reset/a Defaults env_keep = "http_proxy https_proxy ftp_proxy DISPLAY XAUTHORITY"' /etc/sudoers

RUN mkdir /var/run/sshd
EXPOSE 22

RUN useradd -m -s /bin/bash -G sudo ubuntu -p '$6$Ri8lP7vRgVxNpBTC$RelZVvhFDpdWkkJSCVQY/WQ7tI36pmrctvJDEdYIAnGp48fBLZnmH/Z0gwDsLF6aOhUuhNwy0Dqs1exKCW0XX1'

USER ubuntu

# ARG HOME=/home/ubuntu

RUN mkdir $HOME/.ssh && chmod 700 $HOME/.ssh 

RUN <<EOF cat > $HOME/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDF9sKUC7XhZOUVWs2WjWx07euBSDNE/6XUGRq+2G8Q7E/+Chx8r923TOsDzT0l5cmEMfK93jl3tjI6lyb3zrPpBRP70ejH3bOY9OJvTN+mPZCo5M0Ffb/R/dNHotM8ckykz/qL/ZS2nUpum72kph7o/hSrTMnRsHNGZtN3dManSU6wG0FngKYDECeuRpI2JT+XD1+9Y2tCjc38iG1e2IgitskOU5aY0i+MG2qDk6uMpDlEATHOh7sNkj7aXB3dWCO18kEBS/Lxu4VlyuNmbaWvoo30jSLl9XEoN1j6CD4paty4CCUYUr2NQhHMaVvzzHj2qIWYJ+7ldSdN4f9BadrB rsa-key-20240523
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0vysSc4mAuX6z1lN69YYGHZRNZxUXGXlT2v89O4AYxHCMeIHaD7NLWIFn0akCIoqx9WpwMxz2l2M0ZzJwV7NF9J1T5f7GdqC54Pb/m4M1oADGyi92KcdsBYXjbqJOSow5YDWvSMRes64BV41cSx+rqhtbzOKtvhRzfmNibxPJZaNZ3CM1y2tiEq4Nxi9Colfnq+Fa2CccUgV5S07vZKfSzg1hqJjki6Y/TgvfQQCsai7yQBycGe8G3GUh5C5rVLG2hgax5imgoLuTvVA9Oa65CScB+Kc+P2jK0a8ghs4wg5wVGgXdZTikf2tYGJxHECnJCsYqxLEC2MDMUuRpEd3f rsa-key-20240531
EOF

RUN cd $HOME && git clone https://github.com/wsxq2/profile.git .MyProfile && cd .MyProfile

# qt-creator-ros

USER root
CMD ["/usr/sbin/sshd", "-D"]
