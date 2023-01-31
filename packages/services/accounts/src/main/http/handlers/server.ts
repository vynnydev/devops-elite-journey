import logger from '@infra/external/logger/pino/logger'

import { startStandaloneServer } from '@apollo/server/standalone'
import { setupServer } from '@infra/external/graphql/apollo/apollo-server'

const serverHandler = async () => {
  const { setupApp } = await import('./app')
  const app = await setupApp()

  const { url } = await startStandaloneServer(setupServer, {
    context: async ({ req }) => ({ req }),
    listen: { port: Number(4000) },
  })

  logger.info(`ApolloServer ready running on at: ${url}`)
  
  app.listen(process.env.PORT, () => {
    logger.info(`ExpressServer running on http://localhost:${process.env.PORT}`)
  })
}

serverHandler()