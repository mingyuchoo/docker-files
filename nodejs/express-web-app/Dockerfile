# Set base image
FROM node:23.6-alpine3.20

# Set working directory
WORKDIR /app

# Copy files to destination
COPY package*.json ./

# Install required packages
RUN npm install

# Copy application source code
COPY . .

# Expose the application port
EXPOSE 4000

# Run the application
CMD ["node", "index.js"]
