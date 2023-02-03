FROM node:16-alpine AS dependencies
WORKDIR /home/app
COPY package.json package-lock.json tsconfig.json ./
RUN npm ci

FROM node:16-alpine AS build
ENV NODE_ENV production
WORKDIR /home/app
COPY --from=dependencies /home/app/node_modules node_modules/
COPY . .
RUN npm run build

FROM node:16-alpine AS prodDependencies
WORKDIR /home/app
COPY package.json package-lock.json ./
RUN npm ci --production
RUN wget -O /home/app/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 && \
  chmod -v +x /home/app/dumb-init

FROM node:16-alpine AS runtime
ARG VERSION="0.0.1"
ENV VERSION $VERSION
ARG COMMIT
ENV COMMIT $COMMIT
ENV NODE_ENV production
WORKDIR /home/app
USER node
COPY --chown=node:node --from=prodDependencies /home/app/package.json package.json
COPY --chown=node:node --from=prodDependencies /home/app/node_modules node_modules/
COPY --chown=node:node --from=prodDependencies /home/app/dumb-init dumb-init
COPY --chown=node:node --from=build /home/app/prisma prisma/
COPY --chown=node:node --from=build /home/app/dist dist/
COPY --chown=node:node --from=build /home/app/scripts scripts/
ENTRYPOINT ["/var/app/dumb-init", "--"]
CMD ["sh", "scripts/init.sh"]