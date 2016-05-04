FROM 1and1internet/ubuntu-16.04
RUN apt-get update && apt-get install nodejs npm -y && rm -rf /var/lib/apt/lists/*
COPY src /src
RUN cd /src && npm install
EXPOSE 4000
CMD ["nodejs", "/src/server.js"]