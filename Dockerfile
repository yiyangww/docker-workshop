# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy project files
COPY . .

# Expose port
EXPOSE 3000

# Start Next.js app
CMD ["npm", "run", "dev"]
