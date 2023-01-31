import { Router } from 'express'

import { adaptRouter } from '@main/http/adapters/ExpressRouteAdapter'
import { adaptMiddleware } from '@main/http/adapters/ExpressMiddlewareAdapter'

import { makeEnsureAuthenticatedMiddleware } from '@main/http/factories/middlewares/EnsureAuthenticatedMiddlewareFactory'

import { rateLimiterMiddleware } from '@infra/external/redis/providers/middlewares/RateLimiterMiddleware'

import { makeFindAccountController } from '@main/http/factories/controllers/account/find/FindAccountControllerFactory'

const router = Router()

router
  .route('/accounts/find/:account_alias_id')
  .post(
    adaptMiddleware(makeEnsureAuthenticatedMiddleware()),
    rateLimiterMiddleware,
    adaptRouter(makeFindAccountController()))

export default { router }