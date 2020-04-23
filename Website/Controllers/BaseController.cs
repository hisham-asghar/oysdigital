using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Generics.DataModels;
using Generics.Data;
using Microsoft.AspNetCore.Identity;

namespace Website.Controllers
{
    public class BaseController : Controller
    {
        protected readonly ILogger<BaseController> _logger;
        protected readonly UserManager<ApplicationUser> _userManager;

        public BaseController(ILogger<BaseController> logger, UserManager<ApplicationUser> userManager)
        {
            _logger = logger;
            _userManager = userManager;
        }
        public async Task<ApplicationUser> GetCurrentUserAsync()
        {
            if (User.Identity.IsAuthenticated == false)
                return null;
            return await _userManager.GetUserAsync(User);
        }

    }
}
