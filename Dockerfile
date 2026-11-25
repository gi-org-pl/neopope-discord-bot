FROM node:24.22-alpine@sha256:116b800c3754b440ee0aa3ed2f20f5bf3d99a554bfd9adeea09ea8017f6e85f5 AS alpine-node-base
RUN apk --no-cache add curl

FROM alpine-node-base AS development
WORKDIR /app
COPY --chown=node:node package*.json ./
COPY --chown=node:node prisma ./prisma
RUN npm ci
COPY --chown=node:node . .
ENTRYPOINT ["./docker/dev/entrypoint"]

FROM alpine-node-base AS build
WORKDIR /app
COPY --chown=node:node package*.json ./
COPY --chown=node:node prisma ./prisma
COPY --chown=node:node --from=development /app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npx prisma generate && npm run build
ENV NODE_ENV="production"
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM alpine-node-base AS production
COPY --chown=node:node docker/prod ./docker/prod
COPY --chown=node:node prisma ./prisma
COPY --chown=node:node prisma.config.ts ./
COPY --chown=node:node package.json ./
COPY --chown=node:node --from=build /app/node_modules ./node_modules
COPY --chown=node:node --from=build /app/dist ./dist
EXPOSE 3000
ENTRYPOINT ["./docker/prod/entrypoint"]
