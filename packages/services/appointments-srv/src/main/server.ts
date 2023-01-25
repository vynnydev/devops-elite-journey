import 'reflect-metadata';
import { ApolloServer } from 'apollo-server';
import { buildSchema } from 'type-graphql';

import path from 'node:path'
import logger from '@infra/external/logger/pino/logger';

import { AppointmentsResolver } from '@infra/resolvers/appointments-resolver';

async function bootstrap() {
  const schema = await buildSchema({
    resolvers: [
      AppointmentsResolver
    ],
    emitSchemaFile: path.resolve(__dirname, 'schema.gql')
  })

  const server = new ApolloServer({
    schema,
  })

  const { url } = await server.listen()

  logger.info(`🚀 HTTP server running on ${url}`)
}

bootstrap()