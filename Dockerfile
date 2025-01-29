#-------------------------------------------
# Pin specific version (use slim for reduced image size)
FROM node:19.6-bullseye-slim
#-------------------------------------------
# Specify working directory other than /
WORKDIR /src
#-------------------------------------------
# Copy only files required to install dependencies (better layer caching)
COPY package*.json ./
RUN npm install
#-------------------------------------------
# Copy remaining source code AFTER installing dependencies.
# Again, copy only the necessary files
# Use non-root user
# Use --chown on COPY commands to set file permissions
USER node
COPY --chown=node:node ./src/ .
#-------------------------------------------
CMD [ "node", "index.js" ]