FROM osrf/ros:humble-desktop-full
RUN apt-get update && apt-get install command-not-found iproute2 iputils-ping vim -y
RUN apt-get install openssh-server tmux htop -y && apt-get update

RUN echo 'Asia/Shanghai' > /etc/timezone && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN sed -i '/Defaults\s*env_reset/a Defaults env_keep = "http_proxy https_proxy ftp_proxy no_proxy DISPLAY XAUTHORITY"' /etc/sudoers

RUN mkdir /var/run/sshd
EXPOSE 22

RUN useradd -m -s /bin/bash -G sudo ubuntu -p '$6$Ri8lP7vRgVxNpBTC$RelZVvhFDpdWkkJSCVQY/WQ7tI36pmrctvJDEdYIAnGp48fBLZnmH/Z0gwDsLF6aOhUuhNwy0Dqs1exKCW0XX1'

USER ubuntu

# ARG HOME=/home/ubuntu

RUN mkdir $HOME/.ssh && chmod 700 $HOME/.ssh 

RUN <<EOF cat > $HOME/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEArWM+lwt05DEKKUwrAyFbW6CYocRAJot7hLA4RmQemIyzy5Dg1o+r8DdBfo8glZ3Ka54tKSmeDSCxpN1p3TOlfTODrCKxHYxp9OP0qHa7ZffMrfBq2gdGJF7rdv1yUflAkR2dd0VodpRqVRgQdrWAIMKvMg3R8Npurzku0djSGqmVU4Dht0qMnGE7l9iKhmiDkjDRpUK4fuQkhR8IcOYDtb0wcrg7o8qUI1eSxj5BrtfsJ22vut6dkNw/qrvGrJuJrG76zv1ZUtZEBQS6kC8JEbXHwtuZ3YKPlST7T5Jhy4jT+gyiQZ0f/kK1nQjcftURjjBoGZw4ViWhSp3YSEHFyQ== rsa-key-20180602
EOF

RUN cd $HOME && git clone https://github.com/wsxq2/profile.git .MyProfile

# qt-creator-ros

USER root
CMD ["/usr/sbin/sshd", "-D"]
