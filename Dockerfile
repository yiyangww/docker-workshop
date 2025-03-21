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

# Copy start script
COPY --from=builder /app/package.json ./package.json

# Generate Prisma Client at runtime and start the application
COPY --from=builder /app/node_modules/.bin/prisma ./node_modules/.bin/prisma

# Create start script
RUN echo '#!/bin/sh\n\
    npx prisma migrate deploy && \
    npx prisma generate && \
    npm start' > ./start.sh && \
    chmod +x ./start.sh

# Expose the port
EXPOSE 3000

# Start the application
CMD ["./start.sh"]
