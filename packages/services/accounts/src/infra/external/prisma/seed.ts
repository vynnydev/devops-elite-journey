import { v4 } from 'uuid'

import { prisma } from './client'

async function main() {
  await prisma.account.create({
    data: {
      id: v4(),
      alias_id: 'account123456',
      name: 'Martin Doe', 
      avatar_url: 'https://github.com/vynnydev.png', 
      email: 'john@doe.com',
      cpf: '523.168.490-24',
      phone_number: '11984938973',
      password: '123456',
      is_active: true,
      role: 'ADMIN',
    },
  })
}

main()
