import pino from 'pino'

export const logger = {
  enabled: true,
  level: 'info'
}

export default pino({
  transport: {
    target: 'pino-pretty',
    options: {
      colorize: true
    }
  },
  enabled: logger.enabled,
  level: logger.level
})