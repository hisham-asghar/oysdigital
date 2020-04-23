using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Generics.Configurations.Options;
using Admin.ApiControllers.Responses;
using Generics.Data;
using Admin.Models;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using static Admin.ApiControllers.Requests.IdentityRequests;
using static Admin.ApiControllers.Routes.Api;
using Generics.WebHelper.Extensions;
using Admin.Services.MessageService;

namespace Admin.Controllers
{
    public class IdentityController : Controller
    {
        private readonly IWebHostEnvironment _environment;
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly UserManager<ApplicationUser> _userManager;
        //private readonly RoleManager<IdentityUser> _roleManager;
        private readonly TokenValidationParameters _tokenValidationParameters;
        private readonly JwtSettings _jwtSettings;
        private readonly ApplicationDbContext _dbContext;
        public IdentityController(UserManager<ApplicationUser> userManager,
            SignInManager<ApplicationUser> signInManager,
            /*RoleManager<IdentityUser> roleManager*/
            TokenValidationParameters tokenValidationParameters,
            IWebHostEnvironment environment,
            ApplicationDbContext dbContext,
            JwtSettings jwtSettings)
        {
            _tokenValidationParameters = tokenValidationParameters;
            // _roleManager = roleManager;
            _environment = environment;
            _userManager = userManager;
            _signInManager = signInManager;
            _jwtSettings = jwtSettings;
            _dbContext = dbContext;
        }

        [HttpGet("/")]
        public ActionResult Home()
        {
            return Ok("Welcome to bluebell API");
        }

        [HttpGet("api/test")]
        public ActionResult Test()
        {
            return Ok("Cool");
        }
        [HttpGet("api/test2")]
        public ActionResult Test2()
        {
            return Ok(User.GetCustomerId());
        }

        [HttpPost(Identity.Register)]
        public async Task<IActionResult> RegisterAsync([FromBody]UserRegisterationRequest userRegisterationRequest)
        {
            var existingUser = await _userManager.FindByEmailAsync(userRegisterationRequest.Email);
            if (existingUser != null)
            {
                return BadRequest(new AuthFailResponse()
                {
                    Status = false,
                    Errors = new List<string>()
                    {
                        "Email Address is already used !!"
                    }
                });
            }
            var newUser = new ApplicationUser()
            {
                Email = userRegisterationRequest.Email,
                UserName = userRegisterationRequest.Email
            };
            var createdUser = await _userManager.CreateAsync(newUser, userRegisterationRequest.Password);
            if (!createdUser.Succeeded)
            {
                return BadRequest(new AuthFailResponse()
                {
                    Status = false,
                    Errors = createdUser.Errors.Select(x => x.Description).ToList()
                });
            }
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            //LayerBao.CustomerBao.CreateCustomerFromIdenityUser(newUser.Id,userRegisterationRequest.Password,userRegisterationRequest.FirstName,userRegisterationRequest.LastName,"+92"+userRegisterationRequest.PhoneNumber);
            newUser = await _userManager.FindByNameAsync(newUser.UserName);

            //await _userManager.SetTwoFactorEnabledAsync(newUser, true);
            //return await GenerateTwoFactorAuthentication(newUser);
            ////_userManager.SetTwoFactorEnabledAsync(newUser, true);
            

            return await GenerateAuthenticationResponse(newUser);
        }

        [HttpPost(Identity.Login)]
        public async Task<IActionResult> LoginAsync([FromBody]LoginRequest login)
        {
            
            var user = await _userManager.FindByNameAsync(login.Nickname?.ToLower());

            if (user == null)
            {
                return BadRequest(new AuthenticationResult
                {
                    Errors = new[] { "User does not exist" }
                });
            }

            var userHasValidPassword = await _userManager.CheckPasswordAsync(user, login.Password);

            if (!userHasValidPassword)
            {
                return BadRequest(new AuthenticationResult
                {
                    Errors = new[] { "User/password combination is wrong" }
                });
            }

            return await GenerateAuthenticationResponse(user);
        }

        [HttpPost(Identity.Refresh)]
        public async Task<AuthenticationResult> RefreshTokenAsync(string token, string refreshToken)
        {
            var validatedToken = GetPrincipalFromToken(token);

            if (validatedToken == null)
            {
                return new AuthenticationResult { Errors = new[] { "Invalid Token" } };
            }

            var expiryDateUnix =
                long.Parse(validatedToken.Claims.Single(x => x.Type == JwtRegisteredClaimNames.Exp).Value);

            var expiryDateTimeUtc = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)
                .AddSeconds(expiryDateUnix);

            if (expiryDateTimeUtc > DateTime.UtcNow)
            {
                return new AuthenticationResult { Errors = new[] { "This token hasn't expired yet" } };
            }

            var jti = validatedToken.Claims.Single(x => x.Type == JwtRegisteredClaimNames.Jti).Value;

            var storedRefreshToken = _dbContext.RefreshTokens.SingleOrDefault(x => x.Token == refreshToken);

            if (storedRefreshToken == null)
            {
                return new AuthenticationResult { Errors = new[] { "This refresh token does not exist" } };
            }

            if (DateTime.UtcNow > storedRefreshToken.ExpiryDate)
            {
                return new AuthenticationResult { Errors = new[] { "This refresh token has expired" } };
            }

            if (storedRefreshToken.Invalidated)
            {
                return new AuthenticationResult { Errors = new[] { "This refresh token has been invalidated" } };
            }

            if (storedRefreshToken.Used)
            {
                return new AuthenticationResult { Errors = new[] { "This refresh token has been used" } };
            }

            if (storedRefreshToken.JwtId != jti)
            {
                return new AuthenticationResult { Errors = new[] { "This refresh token does not match this JWT" } };
            }

            storedRefreshToken.Used = true;
            _dbContext.RefreshTokens.Update(storedRefreshToken);
            await _dbContext.SaveChangesAsync();

            var user = await _userManager.FindByIdAsync(validatedToken.Claims.Single(x => x.Type == "id").Value);
            return await GenerateAuthenticationResultForUserAsync(user);
        }

        private ClaimsPrincipal GetPrincipalFromToken(string token)
        {
            var tokenHandler = new JwtSecurityTokenHandler();

            try
            {
                var tokenValidationParameters = _tokenValidationParameters.Clone();
                tokenValidationParameters.ValidateLifetime = false;
                var principal = tokenHandler.ValidateToken(token, tokenValidationParameters, out var validatedToken);
                if (!IsJwtWithValidSecurityAlgorithm(validatedToken))
                {
                    return null;
                }

                return principal;
            }
            catch
            {
                return null;
            }
        }

        private bool IsJwtWithValidSecurityAlgorithm(SecurityToken validatedToken)
        {
            return (validatedToken is JwtSecurityToken jwtSecurityToken) &&
                   jwtSecurityToken.Header.Alg.Equals(SecurityAlgorithms.HmacSha256,
                       StringComparison.InvariantCultureIgnoreCase);
        }
        private async Task<IActionResult> GenerateAuthenticationResponse(ApplicationUser newUser)
        {
            var result = await GenerateAuthenticationResultForUserAsync(newUser);
            if (result.Status)
            {
                return Ok(new AuthSuccessResponse() { Status = true, Token = result.Token, RefreshToken = result.RefreshToken });
            }
            else
            {
                return BadRequest(new AuthFailResponse() { Status = false, Errors = result.Errors });
            }
        }
        private async Task<AuthenticationResult> GenerateAuthenticationResultForUserAsync(ApplicationUser user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_jwtSettings.Secret);

            var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.Email),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(JwtRegisteredClaimNames.Email, user.Email),
                new Claim("id", user.Id),
                //new Claim("Name", user.Name),
                new Claim("nickname", user.UserName)
            };

            var userClaims = await _userManager.GetClaimsAsync(user);
            //ClaimsPrincipal claimsPrincipal = new ClaimsPrincipal();
            //claimsPrincipal.AddIdentities(claims);
            
            //var usr = _userManager.GetUserAsync(new ClaimsPrincipal()
            //{
            //    Claims = userClaims,
            //    Identity = user.Id

            //});
            claims.AddRange(userClaims);

            //var userRoles = await _userManager.GetRolesAsync(user);
            //foreach (var userRole in userRoles)
            //{
            //    claims.Add(new Claim(ClaimTypes.Role, userRole));
            //    var role = await _roleManager.FindByNameAsync(userRole);
            //    if (role == null) continue;
            //    var roleClaims = await _roleManager.GetClaimsAsync(role);

            //    foreach (var roleClaim in roleClaims)
            //    {
            //        if (claims.Contains(roleClaim))
            //            continue;

            //        claims.Add(roleClaim);
            //    }
            //}

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims),
                Expires = DateTime.UtcNow.Add(_jwtSettings.TokenLifetime),
                SigningCredentials =
                    new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);

            var refreshToken = new RefreshToken
            {
                JwtId = token.Id,
                UserId = user.Id,
                CreationDate = DateTime.UtcNow,
                ExpiryDate = DateTime.UtcNow.AddMonths(6)
            };
            await _dbContext.RefreshTokens.AddAsync(refreshToken);
            await _dbContext.SaveChangesAsync();

            return new AuthenticationResult
            {
                Status = true,
                Token = tokenHandler.WriteToken(token),
                RefreshToken = refreshToken.Token
            };
        }

        
        
        private async Task<IActionResult> GenerateTwoFactorAuthentication(ApplicationUser user)
        {
            if(user != null )
            {
                var tok = await _userManager.GenerateTwoFactorTokenAsync(user, _userManager.Options.Tokens.ChangePhoneNumberTokenProvider);
                var token = await _userManager.GenerateUserTokenAsync(user, _userManager.Options.Tokens.ChangeEmailTokenProvider, "UserAuthentication");


               var Resp = MessageService.SendEmail("bluebell-api@octacer.com", $"Phone Number Verification Token - {user.PhoneNumber}", tok);
                if(!Resp)
                {
                    return BadRequest("Email Not Sent");
                }
                // send token 
                return Ok(new { UserVerificationToken = token });
            }
            else
            {
                return BadRequest("User Can not be null");
            }
            

        }
    }

    
}