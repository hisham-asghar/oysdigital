using Generics.Data;
using Generics.Services.DatabaseService.AdoNet;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Threading;
using System.Threading.Tasks;

namespace Generics.WebHelper.Data
{
    public class CustomUserStore : IUserStore<ApplicationUser>, IUserPasswordStore<ApplicationUser>,
        IUserEmailStore<ApplicationUser>, IUserConfirmation<ApplicationUser>, IUserLockoutStore<ApplicationUser>,
        IUserClaimStore<ApplicationUser>, IUserLoginStore<ApplicationUser>, IUserPhoneNumberStore<ApplicationUser>,
        IUserRoleStore<ApplicationUser>, IUserSecurityStampStore<ApplicationUser>,
        IUserTwoFactorRecoveryCodeStore<ApplicationUser>, IUserTwoFactorStore<ApplicationUser>

    {
        const string UserTableName = "AspNetUsers";
        public Task<IdentityResult> CreateAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            var userId = user.InsertWithStringId(UserTableName);
            return Task.Run(() => userId == user.Id ? IdentityResult.Success : IdentityResult.Failed(null));
        }

        public Task<IdentityResult> DeleteAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            var result = UserTableName.Delete(user.Id);
            return Task.Run(() => result ? IdentityResult.Success : IdentityResult.Failed(null));
        }

        public void Dispose()
        {
        }

        public Task<ApplicationUser> FindByIdAsync(string userId, CancellationToken cancellationToken)
        {
            var user = UserTableName.Select<ApplicationUser>($" Id = {userId}");
            return Task.Run(() => user);
        }

        public Task<ApplicationUser> FindByNameAsync(string normalizedUserName, CancellationToken cancellationToken)
        {
            var user = UserTableName.Select<ApplicationUser>($" NormalizedUserName = {normalizedUserName}");
            return Task.Run(() => user);
        }

        public Task<string> GetNormalizedUserNameAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            var userDb = UserTableName.Select<ApplicationUser>($" Id = {user?.Id}");
            return Task.Run(() => userDb?.NormalizedUserName);
        }

        public Task<string> GetPasswordHashAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            var userDb = UserTableName.Select<ApplicationUser>($" Id = {user?.Id}");
            return Task.Run(() => userDb?.PasswordHash);
        }

        public Task<string> GetUserIdAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            var userDb = UserTableName.Select<ApplicationUser>($" NormalizedUserName = {user?.NormalizedUserName} OR  NormalizedEmail = {user?.NormalizedEmail}  ");
            return Task.Run(() => userDb?.Id);
        }

        public Task<string> GetUserNameAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            var userDb = UserTableName.Select<ApplicationUser>($" Id = {user?.Id}");
            return Task.Run(() => userDb?.UserName);
        }

        public Task<bool> HasPasswordAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            ApplicationUser userDb = GetUserById(user);
            return Task.Run(() => !string.IsNullOrWhiteSpace(userDb?.PasswordHash));
        }


        public Task SetNormalizedUserNameAsync(ApplicationUser user, string normalizedName, CancellationToken cancellationToken)
        {
            if (user != null)
            {
                var userDb = UserTableName.Select<ApplicationUser>($" Id = {user?.Id}");
                userDb.NormalizedUserName = normalizedName;
                userDb.Update(UserTableName, user?.Id);
            }
            return Task.Run(() => { });
        }

        public Task SetPasswordHashAsync(ApplicationUser user, string passwordHash, CancellationToken cancellationToken)
        {
            if (user != null)
            {
                var userDb = UserTableName.Select<ApplicationUser>($" Id = {user?.Id}");
                userDb.PasswordHash = passwordHash;
                userDb.Update(UserTableName, user?.Id);
            }
            return Task.Run(() => { });
        }

        public Task SetUserNameAsync(ApplicationUser user, string userName, CancellationToken cancellationToken)
        {
            if (user != null)
            {
                var userDb = UserTableName.Select<ApplicationUser>($" Id = {user?.Id}");
                userDb.UserName = userName;
                userDb.Update(UserTableName, user?.Id);
            }
            return Task.Run(() => { });
        }

        public Task<IdentityResult> UpdateAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            if (user != null)
            {
                user.Update(UserTableName, user.Id);
                return Task.Run(() => IdentityResult.Success);
            }
            return Task.Run(() => IdentityResult.Failed());
        }

        private static ApplicationUser GetUserById(ApplicationUser user)
        {
            if (string.IsNullOrWhiteSpace(user?.Id)) return null;
            return UserTableName.Select<ApplicationUser>($" Id = {user?.Id}");
        }
        private static ApplicationUser GetUserById(string userId)
        {
            if (string.IsNullOrWhiteSpace(userId)) return null;
            return UserTableName.Select<ApplicationUser>($" Id = {userId}");
        }

        public Task<ApplicationUser> FindByEmailAsync(string normalizedEmail, CancellationToken cancellationToken)
        {
            return Task.Run(() => UserTableName.Select<ApplicationUser>($" NormalizedEmail = {normalizedEmail}"));
        }

        public Task<string> GetEmailAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            return Task.Run(() => GetUserById(user)?.Email);
        }

        public Task<bool> GetEmailConfirmedAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            return Task.Run(() => GetUserById(user)?.EmailConfirmed ?? false);
        }

        public Task<string> GetNormalizedEmailAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            return Task.Run(() => GetUserById(user)?.NormalizedEmail);
        }

        public Task SetEmailAsync(ApplicationUser user, string email, CancellationToken cancellationToken)
        {
            return Task.Run(() =>
            {
                var userDb = GetUserById(user);
                userDb.Email = email;
                userDb.Update(UserTableName, user.Id);
            });
        }

        public Task SetEmailConfirmedAsync(ApplicationUser user, bool confirmed, CancellationToken cancellationToken)
        {
            return Task.Run(() =>
            {
                var userDb = GetUserById(user);
                userDb.EmailConfirmed = confirmed;
                userDb.Update(UserTableName, user.Id);
            });
        }

        public Task SetNormalizedEmailAsync(ApplicationUser user, string normalizedEmail, CancellationToken cancellationToken)
        {
            return Task.Run(() =>
            {
                var userDb = GetUserById(user);
                userDb.NormalizedEmail = normalizedEmail;
                userDb.Update(UserTableName, user.Id);
            });
        }

        public Task<bool> IsConfirmedAsync(UserManager<ApplicationUser> manager, ApplicationUser user)
        {
            throw new System.NotImplementedException();
        }

        public Task<int> GetAccessFailedCountAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<bool> GetLockoutEnabledAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<DateTimeOffset?> GetLockoutEndDateAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<int> IncrementAccessFailedCountAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            return Task.Run(() =>
            {
                var userDb = GetUserById(user);
                userDb.AccessFailedCount++;
                userDb.Update(UserTableName, user.Id);
                return userDb.AccessFailedCount;
            });
        }

        public Task ResetAccessFailedCountAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            return Task.Run(() =>
            {
                var userDb = GetUserById(user);
                userDb.AccessFailedCount = 0;
                userDb.Update(UserTableName, user.Id);
            });
        }

        public Task SetLockoutEnabledAsync(ApplicationUser user, bool enabled, CancellationToken cancellationToken)
        {
            return Task.Run(() =>
            {
                var userDb = GetUserById(user);
                userDb.LockoutEnabled = enabled;
                userDb.Update(UserTableName, user.Id);
            });
        }

        public Task SetLockoutEndDateAsync(ApplicationUser user, DateTimeOffset? lockoutEnd, CancellationToken cancellationToken)
        {
            return Task.Run(() =>
            {
                var userDb = GetUserById(user);
                userDb.LockoutEnd = lockoutEnd;
                userDb.Update(UserTableName, user.Id);
            });
        }

        public Task AddLoginAsync(ApplicationUser user, UserLoginInfo login, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<ApplicationUser> FindByLoginAsync(string loginProvider, string providerKey, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<IList<UserLoginInfo>> GetLoginsAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task RemoveLoginAsync(ApplicationUser user, string loginProvider, string providerKey, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task AddClaimsAsync(ApplicationUser user, IEnumerable<Claim> claims, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<IList<Claim>> GetClaimsAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<IList<ApplicationUser>> GetUsersForClaimAsync(Claim claim, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task RemoveClaimsAsync(ApplicationUser user, IEnumerable<Claim> claims, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task ReplaceClaimAsync(ApplicationUser user, Claim claim, Claim newClaim, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<string> GetPhoneNumberAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<bool> GetPhoneNumberConfirmedAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task SetPhoneNumberAsync(ApplicationUser user, string phoneNumber, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task SetPhoneNumberConfirmedAsync(ApplicationUser user, bool confirmed, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<string> GetSecurityStampAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task SetSecurityStampAsync(ApplicationUser user, string stamp, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<int> CountCodesAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<bool> RedeemCodeAsync(ApplicationUser user, string code, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task ReplaceCodesAsync(ApplicationUser user, IEnumerable<string> recoveryCodes, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task AddToRoleAsync(ApplicationUser user, string roleName, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<IList<string>> GetRolesAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<IList<ApplicationUser>> GetUsersInRoleAsync(string roleName, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<bool> IsInRoleAsync(ApplicationUser user, string roleName, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task RemoveFromRoleAsync(ApplicationUser user, string roleName, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<bool> GetTwoFactorEnabledAsync(ApplicationUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task SetTwoFactorEnabledAsync(ApplicationUser user, bool enabled, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
