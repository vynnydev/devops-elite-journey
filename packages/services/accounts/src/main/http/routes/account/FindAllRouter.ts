import { Router } from 'express'

import { adaptRouter } from '@main/http/adapters/ExpressRouteAdapter'
import { adaptMiddleware } from '@main/http/adapters/ExpressMiddlewareAdapter'

import { makeEnsureAuthenticatedMiddleware } from '@main/http/factories/middlewares/EnsureAuthenticatedMiddlewareFactory'

import { rateLimiterMiddleware } from '@infra/external/redis/providers/middlewares/RateLimiterMiddleware'

import { makeFindAccountsController } from '@main/http/factories/controllers/account/findAll/FindAccountsControllerFactory'

const router = Router()

router
  .route('/accounts/find-all')
  .post(
    adaptMiddleware(makeEnsureAuthenticatedMiddleware()),
    rateLimiterMiddleware,
    adaptRouter(makeFindAccountsController()))

export default { router }