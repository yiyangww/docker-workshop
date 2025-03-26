# Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Generate Prisma Client
RUN npx prisma generate

# Build application
RUN npm run build

# Production stage
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Copy package files and install production dependencies
COPY --from=builder /app/package*.json ./
RUN npm install --only=production

# Copy built assets and necessary files
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma

# Expose the port
EXPOSE 3000

# Create start script
RUN echo '#!/bin/sh\n\
    npx prisma migrate deploy\n\
    npm start' > start.sh && chmod +x start.sh

# Start the application
CMD ["./start.sh"]
