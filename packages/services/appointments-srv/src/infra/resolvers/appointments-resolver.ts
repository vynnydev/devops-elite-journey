import { Resolver, Arg, Query, Mutation, FieldResolver, Root } from 'type-graphql'

import { CreateAppointmentInput } from '@domain/dtos/create-appointment-input'
import { Appointment } from '@domain/models/appointment-model'
import { Customer } from '@domain/models/customer-model'

import logger from '@infra/external/logger/pino/logger';

@Resolver(() => Appointment)
export class AppointmentsResolver {
  @Query(() => [Appointment])
  async appointments() {
    return [
      {
        startsAt: new Date(),
        endsAt: new Date()
      }
    ]
  }
  
  @Mutation(() => Appointment)
  async createAppointment(@Arg('data') data: CreateAppointmentInput) {
    const appointment = {
      startsAt: data.startsAt,
      endsAt: data.endsAt
    }

    return appointment
  }

  @FieldResolver(() => Customer)
  async customer(@Root() appointment: Appointment) {
    logger.info(appointment)

    return {
      name: 'John Doe'
    }
  }
}