import { Router } from 'express'

import { adaptRouter } from '@main/http/adapters/ExpressRouteAdapter'

import { rateLimiterMiddleware } from '@infra/external/redis/providers/middlewares/RateLimiterMiddleware'

import { makeSignUpController } from '@main/http/factories/controllers/account/signup/SignUpControllerFactory'

const router = Router()

router
  .route('/accounts/signup')
  .post(
    rateLimiterMiddleware,
    adaptRouter(makeSignUpController()))

export default { router }