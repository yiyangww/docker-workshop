# Quiz App

A simple quiz application built with Next.js, Prisma, and PostgreSQL.

## Prerequisites

- Docker and Docker Compose
- Node.js (for local development)

## Getting Started

1. Clone the repository:

```bash
git clone <repository-url>
cd quiz
```

2. Start the Docker containers:

```bash
docker-compose up -d
```

3. Run Prisma migrations to create the database tables:

```bash
docker exec -it quiz-app npx prisma migrate dev --name init
```

4. The application should now be running at http://localhost:3000

## Viewing the Database

You can view the database contents using Prisma Studio:

```bash
docker exec -it quiz-app npx prisma studio --port 5555
```

Then open http://localhost:5555 in your browser.

Alternatively, you can use psql to view the database:

```bash
docker exec -it quiz-db psql -U postgres -d quizdb
```

## Development

The application uses:

- Next.js for the frontend and API routes
- Prisma as the ORM
- PostgreSQL as the database
- Docker for containerization

## Project Structure

- `src/pages/` - Next.js pages and API routes
- `prisma/` - Prisma schema and migrations
- `public/` - Static assets

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `pages/index.js`. The page auto-updates as you edit the file.

[API routes](https://nextjs.org/docs/pages/building-your-application/routing/api-routes) can be accessed on [http://localhost:3000/api/hello](http://localhost:3000/api/hello). This endpoint can be edited in `pages/api/hello.js`.

The `pages/api` directory is mapped to `/api/*`. Files in this directory are treated as [API routes](https://nextjs.org/docs/pages/building-your-application/routing/api-routes) instead of React pages.

This project uses [`next/font`](https://nextjs.org/docs/pages/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn-pages-router) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/pages/building-your-application/deploying) for more details.
