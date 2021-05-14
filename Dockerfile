# Define node js version
FROM harbor.wistron.com/base_image/node:lts

# Move all file to /app directory
ADD . /app/

# Set working directory to /app
WORKDIR /app

# Install depandancy component
RUN npm install

# Set external port
EXPOSE 3000

# CMD: node .
CMD ["node", "."]
