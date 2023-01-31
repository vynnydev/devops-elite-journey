import Account from '@domain/models/account/Account'
import ILogoutDTO from '@domain/repositories/redis/account/dtos/ILogoutDTO'

export default interface IAccountCacheProviderRepository {
  auth(account: Account): Promise<void>
  findAccount(alias_id: string): Promise<Account | null>
  updateAccount(account: Account): Promise<void>
  deactivateAccount(account: Account): Promise<void>
  logout(data: ILogoutDTO): Promise<void>
}