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
ENV PORT=3000

# Install production dependencies
COPY package*.json ./
RUN npm install --production

# Copy built assets
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=builder /app/node_modules/@prisma ./node_modules/@prisma
COPY --from=builder /app/prisma ./prisma

# Create start script
RUN echo '#!/bin/sh' > start.sh && \
    echo 'npx prisma migrate deploy' >> start.sh && \
    echo 'npx prisma generate' >> start.sh && \
    echo 'npm start' >> start.sh && \
    chmod +x start.sh

# Expose the port
EXPOSE 3000

# Start the application
CMD ["/bin/sh", "./start.sh"]
